# Copyright (c) 2020 Aalto University. All rights reserved.

import math

from gurobipy.gurobipy import Model, GRB, LinExpr

from model.Constants import FLEXIBILITY_VALUE
from model.DataInstance import DataInstance
from model.SolutionInstance import SolutionInstance
from tools.GurobiUtils import define1DIntVarArray, define2DBoolVarArrayArray, define1DBoolVarArray
from tools.JSONExportUtility import save_to_json


def setControlParams(model: Model):
    model.Params.PoolSearchMode = 2
    model.Params.PoolSolutions = 1
    model.Params.MIPGap = 0.04
    model.Params.TimeLimit = 30
    # gurobi.Params.MIPGapAbs = 0.97
    model.Params.LogFile = "GurobiLog.txt"
    model.Params.OutputFlag = 1


def defineVars(data: DataInstance):
    model = Model("GLayout")
    L = define1DIntVarArray(model, data.element_count, "L")
    R = define1DIntVarArray(model, data.element_count, "R")
    T = define1DIntVarArray(model, data.element_count, "T")
    B = define1DIntVarArray(model, data.element_count, "B")
    H = define1DIntVarArray(model, data.element_count, "H")
    W = define1DIntVarArray(model, data.element_count, "W")
    ABOVE = define2DBoolVarArrayArray(model, data.element_count, data.element_count, "ABOVE")
    LEFT = define2DBoolVarArrayArray(model, data.element_count, data.element_count, "LEFT")
    N = data.element_count
    LAG = define1DBoolVarArray(model, data.element_count, "LAG")
    RAG = define1DBoolVarArray(model, data.element_count, "RAG")
    TAG = define1DBoolVarArray(model, data.element_count, "TAG")
    BAG = define1DBoolVarArray(model, data.element_count, "BAG")
    vLAG = define1DIntVarArray(model, data.element_count, "vLAG")
    vRAG = define1DIntVarArray(model, data.element_count, "vRAG")
    vTAG = define1DIntVarArray(model, data.element_count, "vTAG")
    vBAG = define1DIntVarArray(model, data.element_count, "vBAG")
    elemAtLAG = define2DBoolVarArrayArray(model, data.element_count, data.element_count, "zLAG")
    elemAtRAG = define2DBoolVarArrayArray(model, data.element_count, data.element_count, "zRAG")
    elemAtTAG = define2DBoolVarArrayArray(model, data.element_count, data.element_count, "zTAG")
    elemAtBAG = define2DBoolVarArrayArray(model, data.element_count, data.element_count, "zBAG")

    return model, N, (L, R, T, B, H, W), (ABOVE, LEFT), (LAG, RAG, TAG, BAG), (vLAG, vRAG, vTAG, vBAG), \
        (elemAtLAG, elemAtRAG, elemAtTAG, elemAtBAG)


def setVarNames(data: DataInstance, posVars, vVars):
    L, R, T, B, H, W = posVars
    vLAG, vRAG, vTAG, vBAG = vVars

    for element in range(data.element_count):
        L[element].LB = data.borderXPadding
        L[element].UB = data.canvasWidth - data.elements[element].minWidth - data.borderXPadding

        R[element].LB = data.elements[element].minWidth + data.borderXPadding
        R[element].UB = data.canvasWidth - data.borderXPadding

        T[element].LB = data.borderYPadding
        T[element].UB = data.canvasHeight - data.elements[element].minHeight - data.borderYPadding

        B[element].LB = data.elements[element].minHeight + data.borderYPadding
        B[element].UB = data.canvasHeight - data.borderYPadding

        W[element].LB = data.elements[element].minWidth
        W[element].UB = data.elements[element].maxWidth

        H[element].LB = data.elements[element].minHeight
        H[element].UB = data.elements[element].maxHeight

        vLAG[element].LB = 0
        vLAG[element].UB = data.canvasWidth - 1

        vRAG[element].LB = 1
        vRAG[element].UB = data.canvasWidth

        vTAG[element].LB = 0
        vTAG[element].UB = data.canvasHeight - 1

        vBAG[element].LB = 1
        vBAG[element].UB = data.canvasHeight


def defineObjectives(data: DataInstance, model: Model, boolVars, N, posVars):
    LAG, RAG, TAG, BAG = boolVars
    L, R, T, B, H, W = posVars

    maxX = model.addVar(vtype=GRB.INTEGER, name="maxX")
    maxY = model.addVar(vtype=GRB.INTEGER, name="maxY")
    for element in range(data.element_count):
        model.addConstr(maxX >= R[element])
        model.addConstr(maxY >= B[element])

    OBJECTIVE_GRIDCOUNT = LinExpr(0.0)
    for element in range(data.element_count):
        OBJECTIVE_GRIDCOUNT.addTerms([1.0, 1.0], [LAG[element], TAG[element]])
        OBJECTIVE_GRIDCOUNT.addTerms([1.0, 1.0], [BAG[element], RAG[element]])
    OBJECTIVE_LT = LinExpr(0)
    for element in range(data.element_count):
        OBJECTIVE_LT.addTerms([1, 1, 2, 2, -1, -1],
                              [T[element], L[element], B[element], R[element], W[element], H[element]])
    Objective = LinExpr(0)
    Objective.add(OBJECTIVE_GRIDCOUNT, 1)
    Objective.add(OBJECTIVE_LT, 0.001)
    # Objective.add(maxX, 10)
    # Objective.add(maxY, 10)
    model.addConstr(OBJECTIVE_GRIDCOUNT >= (calculateLowerBound(N)))
    model.setObjective(Objective, GRB.MINIMIZE)
    return OBJECTIVE_GRIDCOUNT, OBJECTIVE_LT


def calculateLowerBound(N: int) -> int:
    floorRootN = math.floor(math.sqrt(N))
    countOfElementsInGrid = floorRootN * floorRootN
    countOfNonGridElements = N - countOfElementsInGrid
    if countOfNonGridElements == 0:
        result = 4 * floorRootN
    else:
        countOfAdditionalFilledColumns = math.floor(countOfNonGridElements / floorRootN)
        remainder = (countOfNonGridElements - (countOfAdditionalFilledColumns * floorRootN))
        if remainder == 0:
            result = (4 * floorRootN) + (2 * countOfAdditionalFilledColumns)
        else:
            result = (4 * floorRootN) + (2 * countOfAdditionalFilledColumns) + 2
    print("Min Objective value is " + str(result))
    return result


def setConstraints(data: DataInstance, model: Model, relVars, boolVars, vVars, elemVars, posVars, N):
    L, R, T, B, H, W = posVars
    ABOVE, LEFT = relVars
    LAG, RAG, TAG, BAG = boolVars
    vLAG, vRAG, vTAG, vBAG = vVars
    elemAtLAG, elemAtRAG, elemAtTAG, elemAtBAG = elemVars

    # Known Position constraints X Y
    HORIZONTAL_TOLERANCE = data.canvasWidth * FLEXIBILITY_VALUE
    VERTICAL_TOLERANCE = data.canvasWidth * FLEXIBILITY_VALUE

    for element in range(data.element_count):
        print("At element ", element, "with lock = ", data.elements[element].isLocked)
        if data.elements[element].isLocked:
            if data.elements[element].X is not None and data.elements[element].X >= 0:
                model.addConstr(L[element] == data.elements[element].X, "PrespecifiedXOfElement(", element, ")")
            if data.elements[element].Y is not None and data.elements[element].Y >= 0:
                model.addConstr(T[element] == data.elements[element].Y, "PrespecifiedYOfElement(", element, ")")
        else:
            if data.elements[element].X is not None and data.elements[element].X >= 0:
                model.addConstr(L[element] >= data.elements[element].X - HORIZONTAL_TOLERANCE,
                                "PrespecifiedXminOfElement(", element, ")")
                model.addConstr(L[element] <= data.elements[element].X + HORIZONTAL_TOLERANCE,
                                "PrespecifiedXmaxOfElement(", element, ")")
            if data.elements[element].Y is not None and data.elements[element].Y >= 0:
                model.addConstr(T[element] >= data.elements[element].Y - VERTICAL_TOLERANCE,
                                "PrespecifiedYminOfElement(", element, ")")
                model.addConstr(T[element] <= data.elements[element].Y + VERTICAL_TOLERANCE,
                                "PrespecifiedYmaxOfElement(", element, ")")

        if data.elements[element].aspectRatio is not None and data.elements[element].aspectRatio > 0.001:
            model.addConstr(W[element] == data.elements[element].aspectRatio * H[element],
                            "PrespecifiedAspectRatioOfElement(", element, ")")

    # Known Position constraints TOP BOTTOM LEFT RIGHT
    coeffsForAbsolutePositionExpression = []
    varsForAbsolutePositionExpression = []
    for element in range(data.element_count):
        for other in range(data.element_count):
            if element != other:
                if data.elements[element].verticalPreference is not None:
                    if data.elements[element].verticalPreference.lower() == "top":
                        varsForAbsolutePositionExpression.append(ABOVE[other, element])
                        coeffsForAbsolutePositionExpression.append(1.0)
                    if data.elements[element].verticalPreference.lower() == "bottom":
                        varsForAbsolutePositionExpression.append(ABOVE[element, other])
                        coeffsForAbsolutePositionExpression.append(1.0)
                if data.elements[element].horizontalPreference is not None:
                    if data.elements[element].horizontalPreference.lower() == "left":
                        varsForAbsolutePositionExpression.append(LEFT[other, element])
                        coeffsForAbsolutePositionExpression.append(1.0)
                    if data.elements[element].horizontalPreference.lower() == "right":
                        varsForAbsolutePositionExpression.append(LEFT[element, other])
                        coeffsForAbsolutePositionExpression.append(1.0)
    expression = LinExpr(coeffsForAbsolutePositionExpression, varsForAbsolutePositionExpression)
    model.addConstr(expression == 0, "Disable non-permitted based on prespecified")
    # Height/Width/L/R/T/B Summation Sanity
    for element in range(N):
        model.addConstr(W[element] + L[element] == R[element], "R-L=W(" + str(element) + ")")
        model.addConstr(H[element] + T[element] == B[element], "B-T=H(" + str(element) + ")")
    # MinMax limits of Left-Above interactions
    for element in range(N):
        for otherElement in range(N):
            if element > otherElement:
                model.addConstr(
                    ABOVE[element, otherElement] + ABOVE[otherElement, element] + LEFT[element, otherElement] +
                    LEFT[
                        otherElement, element] >= 1,
                    "NoOverlap(" + str(element) + str(otherElement) + ")")
                model.addConstr(
                    ABOVE[element, otherElement] + ABOVE[otherElement, element] + LEFT[element, otherElement] +
                    LEFT[
                        otherElement, element] <= 2,
                    "UpperLimOfQuadrants(" + str(element) + str(otherElement) + ")")
                model.addConstr(ABOVE[element, otherElement] + ABOVE[otherElement, element] <= 1,
                                "Anti-symmetryABOVE(" + str(element) + str(otherElement) + ")")
                model.addConstr(LEFT[element, otherElement] + LEFT[otherElement, element] <= 1,
                                "Anti-symmetryLEFT(" + str(element) + str(otherElement) + ")")
    # Interconnect L-R-LEFT and T-B-ABOVE
    for element in range(N):
        for otherElement in range(N):
            if element != otherElement:
                model.addConstr(
                    R[element] + data.elementXPadding <= L[otherElement] + (1 - LEFT[element, otherElement]) * (
                            data.canvasWidth + data.elementXPadding),
                    (str(element) + "(ToLeftOf)" + str(otherElement)))
                model.addConstr(
                    B[element] + data.elementYPadding <= T[otherElement] + (1 - ABOVE[element, otherElement]) * (
                            data.canvasHeight + data.elementYPadding),
                    (str(element) + "(Above)" + str(otherElement)))
                model.addConstr(
                    (L[otherElement] - R[element] - data.elementXPadding) <= data.canvasWidth * LEFT[
                        element, otherElement]
                    , (str(element) + "(ConverseOfToLeftOf)" + str(otherElement)))
                model.addConstr(
                    (T[otherElement] - B[element] - data.elementYPadding) <= data.canvasHeight * ABOVE[
                        element, otherElement]
                    , (str(element) + "(ConverseOfAboveOf)" + str(otherElement)))
    # One Alignment-group for every edge of every element
    for element in range(N):
        coeffsForLAG = []
        coeffsForRAG = []
        coeffsForTAG = []
        coeffsForBAG = []
        varsForLAG = []
        varsForRAG = []
        varsForTAG = []
        varsForBAG = []
        for alignmentGroupIndex in range(data.element_count):
            varsForLAG.append(elemAtLAG[element, alignmentGroupIndex])
            coeffsForLAG.append(1)
            varsForRAG.append(elemAtRAG[element, alignmentGroupIndex])
            coeffsForRAG.append(1)
            varsForTAG.append(elemAtTAG[element, alignmentGroupIndex])
            coeffsForTAG.append(1)
            varsForBAG.append(elemAtBAG[element, alignmentGroupIndex])
            coeffsForBAG.append(1)

        model.addConstr(LinExpr(coeffsForLAG, varsForLAG) == 1, "OneLAGForElement[" + str(element) + "]")
        model.addConstr(LinExpr(coeffsForTAG, varsForTAG) == 1, "OneTAGForElement[" + str(element) + "]")
        model.addConstr(LinExpr(coeffsForBAG, varsForBAG) == 1, "OneBAGForElement[" + str(element) + "]")
        model.addConstr(LinExpr(coeffsForRAG, varsForRAG) == 1, "OneRAGForElement[" + str(element) + "]")
    # Symmetry breaking and sequencing of alignment groups
    # for alignmentGroupIndex in range(data.N):
    #	 if(alignmentGroupIndex >= 1):
    #		 print()
    # gurobi.addConstr(LAG[alignmentGroupIndex] <= LAG[alignmentGroupIndex-1], "SymmBreakLAG["+str(alignmentGroupIndex)+ "]")
    # gurobi.addConstr(TAG[alignmentGroupIndex] <= TAG[alignmentGroupIndex-1], "SymmBreakTAG["+str(alignmentGroupIndex)+ "]")
    # gurobi.addConstr(RAG[alignmentGroupIndex] <= RAG[alignmentGroupIndex-1], "SymmBreakRAG["+str(alignmentGroupIndex)+ "]")
    # gurobi.addConstr(BAG[alignmentGroupIndex] <= BAG[alignmentGroupIndex-1], "SymmBreakBAG["+str(alignmentGroupIndex)+ "]")
    # gurobi.addConstr(vLAG[alignmentGroupIndex] >= vLAG[alignmentGroupIndex-1]+1, "ProgressiveIndexLAG["+str(alignmentGroupIndex)+"]")
    # gurobi.addConstr(vTAG[alignmentGroupIndex] >= vTAG[alignmentGroupIndex-1]+1, "ProgressiveIndexTAG["+str(alignmentGroupIndex)+"]")
    # gurobi.addConstr(vRAG[alignmentGroupIndex] >= vRAG[alignmentGroupIndex-1]+1, "ProgressiveIndexRAG["+str(alignmentGroupIndex)+"]")
    # gurobi.addConstr(vBAG[alignmentGroupIndex] >= vBAG[alignmentGroupIndex-1]+1, "ProgressiveIndexBAG["+str(alignmentGroupIndex)+"]")
    # Assign alignment groups to elements only if groups are enabled
    for alignmentGroupIndex in range(data.element_count):
        for element in range(N):
            model.addConstr(elemAtLAG[element, alignmentGroupIndex] <= LAG[alignmentGroupIndex])
            model.addConstr(elemAtRAG[element, alignmentGroupIndex] <= RAG[alignmentGroupIndex])
            model.addConstr(elemAtTAG[element, alignmentGroupIndex] <= TAG[alignmentGroupIndex])
            model.addConstr(elemAtBAG[element, alignmentGroupIndex] <= BAG[alignmentGroupIndex])
    # Correlate alignment groups value with element edge if assigned
    for alignmentGroupIndex in range(data.element_count):
        for element in range(N):
            model.addConstr(L[element] <= vLAG[alignmentGroupIndex] + data.canvasWidth * (
                    1 - elemAtLAG[element, alignmentGroupIndex]),
                            "MinsideConnectL[" + str(element) + "]ToLAG[" + str(alignmentGroupIndex) + "]")
            model.addConstr(R[element] <= vRAG[alignmentGroupIndex] + data.canvasWidth * (
                    1 - elemAtRAG[element, alignmentGroupIndex]),
                            "MinsideConnectR[" + str(element) + "]ToRAG[" + str(alignmentGroupIndex) + "]")
            model.addConstr(T[element] <= vTAG[alignmentGroupIndex] + data.canvasHeight * (
                    1 - elemAtTAG[element, alignmentGroupIndex]),
                            "MinsideConnectT[" + str(element) + "]ToTAG[" + str(alignmentGroupIndex) + "]")
            model.addConstr(B[element] <= vBAG[alignmentGroupIndex] + data.canvasHeight * (
                    1 - elemAtBAG[element, alignmentGroupIndex]),
                            "MinsideConnectB[" + str(element) + "]ToBAG[" + str(alignmentGroupIndex) + "]")

            model.addConstr(L[element] >= vLAG[alignmentGroupIndex] - data.canvasWidth * (
                    1 - elemAtLAG[element, alignmentGroupIndex]),
                            "MaxsideConnectL[" + str(element) + "]ToLAG[" + str(alignmentGroupIndex) + "]")
            model.addConstr(R[element] >= vRAG[alignmentGroupIndex] - data.canvasWidth * (
                    1 - elemAtRAG[element, alignmentGroupIndex]),
                            "MaxsideConnectR[" + str(element) + "]ToRAG[" + str(alignmentGroupIndex) + "]")
            model.addConstr(T[element] >= vTAG[alignmentGroupIndex] - data.canvasHeight * (
                    1 - elemAtTAG[element, alignmentGroupIndex]),
                            "MaxsideConnectT[" + str(element) + "]ToTAG[" + str(alignmentGroupIndex) + "]")
            model.addConstr(B[element] >= vBAG[alignmentGroupIndex] - data.canvasHeight * (
                    1 - elemAtBAG[element, alignmentGroupIndex]),
                            "MaxsideConnectB[" + str(element) + "]ToBAG[" + str(alignmentGroupIndex) + "]")


# Unused functions
def reportResult(BAG, H, L, LAG, N, OBJECTIVE_GRIDCOUNT, OBJECTIVE_LT, RAG, T, TAG, W, data: DataInstance, model: Model,
                 vBAG, vLAG, vRAG, vTAG):
    print("Value of grid measure is: ", OBJECTIVE_GRIDCOUNT.getValue())
    print("Value of LT objective is: ", OBJECTIVE_LT.getValue())
    objVal = OBJECTIVE_GRIDCOUNT.getValue() + OBJECTIVE_LT.getValue()
    for solNo in range(model.Params.PoolSolutions):
        Hval, Lval, Tval, Wval = extractVariableValues(N, H, L, T, W, model, solNo)
        solution = SolutionInstance(objVal, Lval, Tval, Wval, Hval, 100 + solNo)

        # Output
        save_to_json(data, solution)

        printResultToConsole(N, BAG, LAG, RAG, TAG, vBAG, vLAG, vRAG, vTAG)


def extractVariableValues(N, H, L, T, W, model, solNo):
    model.Params.SolutionNumber = solNo
    Lval = []
    Tval = []
    Wval = []
    Hval = []
    for element in range(N):
        Lval.append(L[element].xn)
        Tval.append(T[element].xn)
        Wval.append(W[element].xn)
        Hval.append(H[element].xn)
    return Hval, Lval, Tval, Wval


def printResultToConsole(N, BAG, LAG, RAG, TAG, vBAG, vLAG, vRAG, vTAG):
    leftCount = 0
    rightCount = 0
    topCount = 0
    bottomCount = 0
    for index in range(N):
        result = "Index:" + str(index) + ": "
        if LAG[index].xn > 0.99:
            leftCount = leftCount + 1
            result = result + "Left = " + str(round(vLAG[index].xn)) + ","
        else:
            result = result + "Left = <>,"
        if TAG[index].xn > 0.99:
            topCount = topCount + 1
            result = result + "Top = " + str(round(vTAG[index].xn)) + ","
        else:
            result = result + "Top = <>,"
        if RAG[index].xn > 0.99:
            rightCount = rightCount + 1
            result = result + "Right = " + str(round(vRAG[index].xn)) + ","
        else:
            result = result + "Right = <>,"
        if BAG[index].xn > 0.99:
            bottomCount = bottomCount + 1
            result = result + "Bottom = " + str(round(vBAG[index].xn)) + ","
        else:
            result = result + "Bottom = <>,"
        print(result)
