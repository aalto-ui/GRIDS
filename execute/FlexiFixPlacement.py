# Copyright (c) 2020 Aalto University. All rights reserved.

from gurobipy import *

from execute.FlexiFixModelling import setControlParams, defineVars, setVarNames, defineObjectives, setConstraints
from model.SolutionManager import SolutionManager
from model.DataInstance import DataInstance


class FlexiFixPlacement:
    def __init__(self, data: DataInstance, sol_mgr: SolutionManager):
        self.listOfVars = []
        self.data: DataInstance = data
        self.solNo = None
        self.L = None
        self.T = None
        self.W = None
        self.H = None
        self.sol_mgr: SolutionManager = sol_mgr

    def solve(self, verbose=True):
        try:
            # Define vars
            model, N, posVars, relVars, boolVars, vVars, elemVars = defineVars(self.data)
            L, R, T, B, H, W = posVars

            # save to instance for gurobi callbacks
            self.L = L
            self.T = T
            self.W = W
            self.H = H

            # Sanity ranges and names of vars
            setVarNames(self.data, posVars, vVars)

            # Define Objective
            OBJECTIVE_GRID_COUNT, OBJECTIVE_LT = defineObjectives(self.data, model, boolVars, N, posVars)

            setConstraints(self.data, model, relVars, boolVars, vVars, elemVars, posVars, N)

            self.solNo = 1

            # Solve
            model.write("FlexiFitModel.lp")

            setControlParams(model, verbose)

            model.optimize(lambda model, where: self.tapSolutions(model, where))

            if model.Status == GRB.Status.INFEASIBLE:
                model.computeIIS()
                model.write("Infeasible.ilp")
                print("Instance Infeasible")
                return False

            # TODO are the status codes exclusive or should this actually be run in all cases
            #  except for the previously handled infeasible case?
            if self.need_more_solutions() and model.Status in [GRB.Status.OPTIMAL, GRB.Status.TIME_LIMIT]:
                self.repeatBruteForceExecutionForMoreResults(model, relVars, boolVars, vVars, posVars, N,
                                                             OBJECTIVE_GRID_COUNT, OBJECTIVE_LT)
            return True

        except GurobiError as e:
            print('Gurobi Error code ' + str(e.errno) + ": " + str(e))

        except AttributeError as e:
            print('AttributeError:', str(e), e)

        except Exception as e:
            print('Unidentified Error:' + str(e))
        return False

    def repeatBruteForceExecutionForMoreResults(self, model: Model, relVars, boolVars, vVars, posVars, N,
                                                OBJECTIVE_GRIDCOUNT, OBJECTIVE_LT):
        ABOVE, LEFT = relVars
        L, R, T, B, H, W = posVars
        LAG, RAG, TAG, BAG = boolVars
        vLAG, vRAG, vTAG, vBAG = vVars

        optimalGridCount = OBJECTIVE_GRIDCOUNT.getValue()
        print("---------------- Now into brute force with GRIDCOUNT = ", optimalGridCount, "-----------------")
        model.addConstr(OBJECTIVE_GRIDCOUNT <= optimalGridCount + 2)
        model.addConstr(OBJECTIVE_GRIDCOUNT >= optimalGridCount - 1)

        for topElem in range(N):
            for bottomElem in range(N):
                if topElem != bottomElem:
                    temporaryConstraint = model.addConstr(LEFT[topElem, bottomElem] == 1)
                    model.optimize(lambda model, where: self.tapSolutions(model, where))
                    model.remove(temporaryConstraint)

                    temporaryConstraint = model.addConstr(ABOVE[topElem, bottomElem] == 1)
                    model.optimize(lambda model, where: self.tapSolutions(model, where))
                    model.remove(temporaryConstraint)

                if not self.need_more_solutions():
                    break
            if not self.need_more_solutions():
                break

    def tapSolutions(self, model: Model, where):
        if where == GRB.Callback.MIPSOL:
            objeValue = model.cbGet(GRB.Callback.MIPSOL_OBJ)
            lowerBound = model.cbGet(GRB.Callback.MIPSOL_OBJBND)
            bestKnownSolution = model.cbGet(GRB.Callback.MIPSOL_OBJBST)
            print("*** Found a solution with ObjValue = ", objeValue, " where estimate range = <", lowerBound, " -- ",
                  bestKnownSolution, ">")

            percentGap = (objeValue - lowerBound) / lowerBound
            if bestKnownSolution == 0.0:
                qualityMetric = 0.0
            else:
                qualityMetric = (objeValue - bestKnownSolution) / bestKnownSolution
            print("Quality metric at ", qualityMetric)

            t = model.cbGet(GRB.Callback.RUNTIME)
            if (percentGap > 0.99) and (qualityMetric > 0.2):
                if t < 5 or t < self.data.element_count:
                    print("Neglected poor solution because percentGap=", percentGap, " and quality metric = ",
                          qualityMetric)
                    return
            percentGap = math.floor(percentGap * 100)
            print("Entering solution at t=", t, " with pending gap%=", percentGap)

            objeValue = math.floor(objeValue * 10000) / 10000.0
            print("Tapped into Solution No", self.solNo, " of objective value ", objeValue,
                  " with lower bound at ", lowerBound)
            Hval, Lval, Tval, Wval = self.extractVariableValuesFromPartialSolution(model)

            self.sol_mgr.build_new_solution(self.data, self.solNo, objeValue, Lval, Tval, Wval, Hval)
            self.solNo += 1

    def extractVariableValuesFromPartialSolution(self, model: Model):
        Lval = []
        Tval = []
        Wval = []
        Hval = []
        for element in range(self.data.element_count):
            Lval.append(model.cbGetSolution(self.L[element]))
            Tval.append(model.cbGetSolution(self.T[element]))
            Wval.append(model.cbGetSolution(self.W[element]))
            Hval.append(model.cbGetSolution(self.H[element]))
        return Hval, Lval, Tval, Wval

    def need_more_solutions(self):
        return self.data.NumOfSolutions == 0 or self.sol_mgr.sol_count() < self.data.NumOfSolutions
