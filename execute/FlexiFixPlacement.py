# Copyright (c) 2020 Aalto University. All rights reserved.

from gurobipy import *

from tools import Constants
from tools.GurobiUtils import *
from tools.JSONLoader import DataInstance
from tools.Constants import *
from tools.JSonExportUtility import *
import math
import tools.GurobiUtils
from model.SolutionManager import buildNewSolution

def solve(data: DataInstance):
	try:
		# Define vars
		ABOVE, B, BAG, H, L, LAG, LEFT, N, R, RAG, T, TAG, W, elemAtBAG, elemAtLAG, elemAtRAG, elemAtTAG, gurobi, vBAG, vLAG, vRAG, vTAG = defineVars(data)

		# Sanity ranges and names of vars
		setVarNames(B, H, L, R, T, W, data, vBAG, vLAG, vRAG, vTAG)

		# Define Objective
		OBJECTIVE_GRIDCOUNT, OBJECTIVE_LT = defineObjectives(N, W, H, B, BAG, L, LAG, R, RAG, T, TAG, data, gurobi)

		setConstraints(ABOVE, B, BAG, H, L, LAG, LEFT, N, R, RAG, T, TAG, W, data, elemAtBAG, elemAtLAG, elemAtRAG, elemAtTAG, gurobi, vBAG, vLAG, vRAG, vTAG)

		globalizeVariablesForOpenAccess(H, L, T, W, data)

		# Solve
		gurobi.write("FlexiFitModel.lp")

		setControlParams(gurobi)

		gurobi.optimize(tapSolutions)

		if gurobi.Status == GRB.Status.INFEASIBLE:
			gurobi.computeIIS()
			gurobi.write("Infeasible.ilp")
			print("Instance Infeasible")
			exit(-1)

		if gurobi.Status == GRB.Status.OPTIMAL or gurobi.Status == GRB.Status.TIME_LIMIT:
			repeatBruteForceExecutionForMoreResults(BAG, H, L, LAG, LEFT, ABOVE, N, OBJECTIVE_GRIDCOUNT, OBJECTIVE_LT, RAG, T, TAG, W, data, gurobi, vBAG, vLAG, vRAG, vTAG)



	except GurobiError as e:
		print('Gurobi Error code ' + str(e.errno) + ": " + str(e))

	except AttributeError  as e:
		print('AttributeError:', str(e), e)

	except Exception as e:
		print('Unidentified Error:' + str(e))


def globalizeVariablesForOpenAccess(H, L, T, W, data):
	tools.GurobiUtils.data = data
	tools.GurobiUtils.solNo = 1
	tools.GurobiUtils.L = L
	tools.GurobiUtils.T = T
	tools.GurobiUtils.W = W
	tools.GurobiUtils.H = H


def repeatBruteForceExecutionForMoreResults(BAG, H, L, LAG, LEFT, ABOVE, N, OBJECTIVE_GRIDCOUNT, OBJECTIVE_LT, RAG, T, TAG, W,data, gurobi, vBAG, vLAG, vRAG, vTAG):
	optimalGridCount = OBJECTIVE_GRIDCOUNT.getValue()
	print("---------------- Now into brute force with GRIDCOUNT = ", optimalGridCount, "-----------------")
	gurobi.addConstr(OBJECTIVE_GRIDCOUNT <= optimalGridCount + 2)
	gurobi.addConstr(OBJECTIVE_GRIDCOUNT >= optimalGridCount - 1)

	for topElem in range(N):
		for bottomElem in range(N):
			if (topElem != bottomElem):

				temporaryConstraint = gurobi.addConstr(LEFT[topElem, bottomElem] == 1)
				gurobi.optimize(tapSolutions)
				gurobi.remove(temporaryConstraint)

				temporaryConstraint = gurobi.addConstr(ABOVE[topElem, bottomElem] == 1)
				gurobi.optimize(tapSolutions)
				gurobi.remove(temporaryConstraint)


def reportResult(BAG, H, L, LAG, N, OBJECTIVE_GRIDCOUNT, OBJECTIVE_LT, RAG, T, TAG, W, data, gurobi, vBAG, vLAG, vRAG,vTAG):
	print("Value of grid measure is: ", OBJECTIVE_GRIDCOUNT.getValue())
	print("Value of LT objective is: ", OBJECTIVE_LT.getValue())
	for solNo in range(gurobi.Params.PoolSolutions):
		Hval, Lval, Tval, Wval = extractVariableValues(N, H, L, T, W, gurobi, solNo)

		# Output
		SaveToJSon(N, data.inputFile, data.canvasWidth, data.canvasHeight, Lval, Tval, Wval, Hval, 100 + solNo, data)

		printResultToConsole(N, BAG, LAG, RAG, TAG, vBAG, vLAG, vRAG, vTAG)



def setControlParams(gurobi):
	gurobi.Params.PoolSearchMode = 2
	gurobi.Params.PoolSolutions = 1
	gurobi.Params.MIPGap = 0.04
	gurobi.Params.TimeLimit =  30
	# gurobi.Params.MIPGapAbs = 0.97
	gurobi.Params.LogFile = "GurobiLog.txt"
	gurobi.Params.OutputFlag = 1


def setConstraints(ABOVE, B, BAG, H, L, LAG, LEFT, N, R, RAG, T, TAG, W, data, elemAtBAG, elemAtLAG, elemAtRAG,elemAtTAG, gurobi, vBAG, vLAG, vRAG, vTAG):

	# Known Position constraints X Y
	HORIZONTAL_TOLERANCE = data.canvasWidth * FLEXIBILITY_VALUE
	VERTICAL_TOLERANCE = data.canvasWidth * FLEXIBILITY_VALUE

	for element in range(data.N):
		print ("At element ",element, "with lock = ",data.elements[element].isLocked)
		if data.elements[element].isLocked == True:
			if (data.elements[element].X is not None and data.elements[element].X >= 0):
				gurobi.addConstr(L[element] == data.elements[element].X, "PrespecifiedXOfElement(", element, ")")
			if (data.elements[element].Y is not None and data.elements[element].Y >= 0):
				gurobi.addConstr(T[element] == data.elements[element].Y, "PrespecifiedYOfElement(", element, ")")
		else:
			if (data.elements[element].X is not None and data.elements[element].X >= 0):
				gurobi.addConstr(L[element] >= data.elements[element].X - HORIZONTAL_TOLERANCE, "PrespecifiedXminOfElement(", element, ")")
				gurobi.addConstr(L[element] <= data.elements[element].X + HORIZONTAL_TOLERANCE, "PrespecifiedXmaxOfElement(", element, ")")
			if (data.elements[element].Y is not None and data.elements[element].Y >= 0):
				gurobi.addConstr(T[element] >= data.elements[element].Y - VERTICAL_TOLERANCE, "PrespecifiedYminOfElement(", element, ")")
				gurobi.addConstr(T[element] <= data.elements[element].Y + VERTICAL_TOLERANCE, "PrespecifiedYmaxOfElement(", element, ")")

		if (data.elements[element].aspectRatio is not None and data.elements[element].aspectRatio > 0.001):
			gurobi.addConstr(W[element] == data.elements[element].aspectRatio * H[element],
							 "PrespecifiedAspectRatioOfElement(", element, ")")



	# Known Position constraints TOP BOTTOM LEFT RIGHT
	coeffsForAbsolutePositionExpression = []
	varsForAbsolutePositionExpression = []
	for element in range(data.N):
		for other in range(data.N):
			if (element != other):
				if (data.elements[element].verticalPreference is not None):
					if (data.elements[element].verticalPreference.lower() == "top"):
						varsForAbsolutePositionExpression.append(ABOVE[other, element])
						coeffsForAbsolutePositionExpression.append(1.0)
					if (data.elements[element].verticalPreference.lower() == "bottom"):
						varsForAbsolutePositionExpression.append(ABOVE[element, other])
						coeffsForAbsolutePositionExpression.append(1.0)
				if (data.elements[element].horizontalPreference is not None):
					if (data.elements[element].horizontalPreference.lower() == "left"):
						varsForAbsolutePositionExpression.append(LEFT[other, element])
						coeffsForAbsolutePositionExpression.append(1.0)
					if (data.elements[element].horizontalPreference.lower() == "right"):
						varsForAbsolutePositionExpression.append(LEFT[element, other])
						coeffsForAbsolutePositionExpression.append(1.0)
	expression = LinExpr(coeffsForAbsolutePositionExpression, varsForAbsolutePositionExpression)
	gurobi.addConstr(expression == 0, "Disable non-permitted based on prespecified")
	# Height/Width/L/R/T/B Summation Sanity
	for element in range(N):
		gurobi.addConstr(W[element] + L[element] == R[element], "R-L=W(" + str(element) + ")")
		gurobi.addConstr(H[element] + T[element] == B[element], "B-T=H(" + str(element) + ")")
	# MinMax limits of Left-Above interactions
	for element in range(N):
		for otherElement in range(N):
			if (element > otherElement):
				gurobi.addConstr(
					ABOVE[element, otherElement] + ABOVE[otherElement, element] + LEFT[element, otherElement] + LEFT[
						otherElement, element] >= 1,
					"NoOverlap(" + str(element) + str(otherElement) + ")")
				gurobi.addConstr(
					ABOVE[element, otherElement] + ABOVE[otherElement, element] + LEFT[element, otherElement] + LEFT[
						otherElement, element] <= 2,
					"UpperLimOfQuadrants(" + str(element) + str(otherElement) + ")")
				gurobi.addConstr(ABOVE[element, otherElement] + ABOVE[otherElement, element] <= 1,
								 "Anti-symmetryABOVE(" + str(element) + str(otherElement) + ")")
				gurobi.addConstr(LEFT[element, otherElement] + LEFT[otherElement, element] <= 1,
								 "Anti-symmetryLEFT(" + str(element) + str(otherElement) + ")")
	# Interconnect L-R-LEFT and T-B-ABOVE
	for element in range(N):
		for otherElement in range(N):
			if (element != otherElement):
				gurobi.addConstr(
					R[element] + data.elementXPadding <= L[otherElement] + (1 - LEFT[element, otherElement]) * (data.canvasWidth + data.elementXPadding), (str(element) + "(ToLeftOf)" + str(otherElement)))
				gurobi.addConstr(
					B[element] + data.elementYPadding <= T[otherElement] + (1 - ABOVE[element, otherElement]) * (data.canvasHeight + data.elementYPadding), (str(element) + "(Above)" + str(otherElement)))
				gurobi.addConstr(
					(L[otherElement] - R[element] - data.elementXPadding) <= data.canvasWidth * LEFT[element, otherElement]
					, (str(element) + "(ConverseOfToLeftOf)" + str(otherElement)))
				gurobi.addConstr(
					(T[otherElement] - B[element] - data.elementYPadding) <= data.canvasHeight * ABOVE[element, otherElement]
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
		for alignmentGroupIndex in range(data.N):
			varsForLAG.append(elemAtLAG[element, alignmentGroupIndex])
			coeffsForLAG.append(1)
			varsForRAG.append(elemAtRAG[element, alignmentGroupIndex])
			coeffsForRAG.append(1)
			varsForTAG.append(elemAtTAG[element, alignmentGroupIndex])
			coeffsForTAG.append(1)
			varsForBAG.append(elemAtBAG[element, alignmentGroupIndex])
			coeffsForBAG.append(1)

		gurobi.addConstr(LinExpr(coeffsForLAG, varsForLAG) == 1, "OneLAGForElement[" + str(element) + "]")
		gurobi.addConstr(LinExpr(coeffsForTAG, varsForTAG) == 1, "OneTAGForElement[" + str(element) + "]")
		gurobi.addConstr(LinExpr(coeffsForBAG, varsForBAG) == 1, "OneBAGForElement[" + str(element) + "]")
		gurobi.addConstr(LinExpr(coeffsForRAG, varsForRAG) == 1, "OneRAGForElement[" + str(element) + "]")
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
	for alignmentGroupIndex in range(data.N):
		for element in range(N):
			gurobi.addConstr(elemAtLAG[element, alignmentGroupIndex] <= LAG[alignmentGroupIndex])
			gurobi.addConstr(elemAtRAG[element, alignmentGroupIndex] <= RAG[alignmentGroupIndex])
			gurobi.addConstr(elemAtTAG[element, alignmentGroupIndex] <= TAG[alignmentGroupIndex])
			gurobi.addConstr(elemAtBAG[element, alignmentGroupIndex] <= BAG[alignmentGroupIndex])
	# Correlate alignment groups value with element edge if assigned
	for alignmentGroupIndex in range(data.N):
		for element in range(N):
			gurobi.addConstr(L[element] <= vLAG[alignmentGroupIndex] + data.canvasWidth * (
						1 - elemAtLAG[element, alignmentGroupIndex]),
							 "MinsideConnectL[" + str(element) + "]ToLAG[" + str(alignmentGroupIndex) + "]")
			gurobi.addConstr(R[element] <= vRAG[alignmentGroupIndex] + data.canvasWidth * (
						1 - elemAtRAG[element, alignmentGroupIndex]),
							 "MinsideConnectR[" + str(element) + "]ToRAG[" + str(alignmentGroupIndex) + "]")
			gurobi.addConstr(T[element] <= vTAG[alignmentGroupIndex] + data.canvasHeight * (
						1 - elemAtTAG[element, alignmentGroupIndex]),
							 "MinsideConnectT[" + str(element) + "]ToTAG[" + str(alignmentGroupIndex) + "]")
			gurobi.addConstr(B[element] <= vBAG[alignmentGroupIndex] + data.canvasHeight * (
						1 - elemAtBAG[element, alignmentGroupIndex]),
							 "MinsideConnectB[" + str(element) + "]ToBAG[" + str(alignmentGroupIndex) + "]")

			gurobi.addConstr(L[element] >= vLAG[alignmentGroupIndex] - data.canvasWidth * (
						1 - elemAtLAG[element, alignmentGroupIndex]),
							 "MaxsideConnectL[" + str(element) + "]ToLAG[" + str(alignmentGroupIndex) + "]")
			gurobi.addConstr(R[element] >= vRAG[alignmentGroupIndex] - data.canvasWidth * (
						1 - elemAtRAG[element, alignmentGroupIndex]),
							 "MaxsideConnectR[" + str(element) + "]ToRAG[" + str(alignmentGroupIndex) + "]")
			gurobi.addConstr(T[element] >= vTAG[alignmentGroupIndex] - data.canvasHeight * (
						1 - elemAtTAG[element, alignmentGroupIndex]),
							 "MaxsideConnectT[" + str(element) + "]ToTAG[" + str(alignmentGroupIndex) + "]")
			gurobi.addConstr(B[element] >= vBAG[alignmentGroupIndex] - data.canvasHeight * (
						1 - elemAtBAG[element, alignmentGroupIndex]),
							 "MaxsideConnectB[" + str(element) + "]ToBAG[" + str(alignmentGroupIndex) + "]")


def defineObjectives(N, W, H, B, BAG, L, LAG, R, RAG, T, TAG, data, gurobi):
	maxX = gurobi.addVar(vtype=GRB.INTEGER, name="maxX")
	maxY = gurobi.addVar(vtype=GRB.INTEGER, name="maxY")
	for element in range(data.N):
		gurobi.addConstr(maxX >= R[element])
		gurobi.addConstr(maxY >= B[element])

	OBJECTIVE_GRIDCOUNT = LinExpr(0.0)
	for element in range(data.N):
		OBJECTIVE_GRIDCOUNT.addTerms([1.0, 1.0], [LAG[element], TAG[element]])
		OBJECTIVE_GRIDCOUNT.addTerms([1.0, 1.0], [BAG[element], RAG[element]])
	OBJECTIVE_LT = LinExpr(0)
	for element in range(data.N):
		OBJECTIVE_LT.addTerms([1, 1, 2, 2, -1, -1],
							  [T[element], L[element], B[element], R[element], W[element], H[element]])
	Objective = LinExpr(0)
	Objective.add(OBJECTIVE_GRIDCOUNT, 1)
	Objective.add(OBJECTIVE_LT, 0.001)
	# Objective.add(maxX, 10)
	# Objective.add(maxY, 10)
	gurobi.addConstr(OBJECTIVE_GRIDCOUNT >= (calculateLowerBound(N)))
	gurobi.setObjective(Objective, GRB.MINIMIZE)
	return OBJECTIVE_GRIDCOUNT, OBJECTIVE_LT


def setVarNames(B, H, L, R, T, W, data, vBAG, vLAG, vRAG, vTAG):
	for element in range(data.N):
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


def extractVariableValues(N, H, L, T, W, gurobi, solNo):
	gurobi.Params.SolutionNumber = solNo
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
		if (LAG[index].xn > 0.99):
			leftCount = leftCount + 1
			result = result + "Left = " + str(round(vLAG[index].xn)) + ","
		else:
			result = result + "Left = <>,"
		if (TAG[index].xn > 0.99):
			topCount = topCount + 1
			result = result + "Top = " + str(round(vTAG[index].xn)) + ","
		else:
			result = result + "Top = <>,"
		if (RAG[index].xn > 0.99):
			rightCount = rightCount + 1
			result = result + "Right = " + str(round(vRAG[index].xn)) + ","
		else:
			result = result + "Right = <>,"
		if (BAG[index].xn > 0.99):
			bottomCount = bottomCount + 1
			result = result + "Bottom = " + str(round(vBAG[index].xn)) + ","
		else:
			result = result + "Bottom = <>,"
		print(result)


def defineVars(data):
	gurobi = Model("GLayout")
	L = define1DIntVarArray(gurobi, data.N, "L")
	R = define1DIntVarArray(gurobi, data.N, "R")
	T = define1DIntVarArray(gurobi, data.N, "T")
	B = define1DIntVarArray(gurobi, data.N, "B")
	H = define1DIntVarArray(gurobi, data.N, "H")
	W = define1DIntVarArray(gurobi, data.N, "W")
	ABOVE = define2DBoolVarArrayArray(gurobi, data.N, data.N, "ABOVE")
	LEFT = define2DBoolVarArrayArray(gurobi, data.N, data.N, "LEFT")
	N = data.N
	LAG = define1DBoolVarArray(gurobi, data.N, "LAG")
	RAG = define1DBoolVarArray(gurobi, data.N, "RAG")
	TAG = define1DBoolVarArray(gurobi, data.N, "TAG")
	BAG = define1DBoolVarArray(gurobi, data.N, "BAG")
	vLAG = define1DIntVarArray(gurobi, data.N, "vLAG")
	vRAG = define1DIntVarArray(gurobi, data.N, "vRAG")
	vTAG = define1DIntVarArray(gurobi, data.N, "vTAG")
	vBAG = define1DIntVarArray(gurobi, data.N, "vBAG")
	elemAtLAG = define2DBoolVarArrayArray(gurobi, data.N, data.N, "zLAG")
	elemAtRAG = define2DBoolVarArrayArray(gurobi, data.N, data.N, "zRAG")
	elemAtTAG = define2DBoolVarArrayArray(gurobi, data.N, data.N, "zTAG")
	elemAtBAG = define2DBoolVarArrayArray(gurobi, data.N, data.N, "zBAG")
	return ABOVE, B, BAG, H, L, LAG, LEFT, N, R, RAG, T, TAG, W, elemAtBAG, elemAtLAG, elemAtRAG, elemAtTAG, gurobi, vBAG, vLAG, vRAG, vTAG


def calculateLowerBound(N : int) -> int:
	floorRootN = math.floor(math.sqrt(N))
	countOfElementsInGrid = floorRootN * floorRootN
	countOfNonGridElements = N - countOfElementsInGrid
	if(countOfNonGridElements == 0):
		result = 4 * floorRootN
	else:
		countOfAdditionalFilledColumns = math.floor(countOfNonGridElements / floorRootN)
		remainder = (countOfNonGridElements - (countOfAdditionalFilledColumns * floorRootN))
		if(remainder == 0):
			result = (4 * floorRootN) + (2 * countOfAdditionalFilledColumns)
		else:
			result = (4 * floorRootN) + (2 * countOfAdditionalFilledColumns) + 2
	print("Min Objective value is " + str(result))
	return result


def tapSolutions(model, where):
	if where == GRB.Callback.MIPSOL:
		objeValue = model.cbGet(GRB.Callback.MIPSOL_OBJ)
		lowerBound = model.cbGet(GRB.Callback.MIPSOL_OBJBND)
		bestKnownSolution = model.cbGet(GRB.Callback.MIPSOL_OBJBST)
		print("*** Found a solution with ObjValue = ",objeValue," where estimate range = <", lowerBound," -- ",bestKnownSolution,">")
		percentGap = (objeValue - lowerBound) / lowerBound
		qualityMetric = (objeValue - bestKnownSolution)/bestKnownSolution
		print("Quality metric at ",qualityMetric)
		printThis = 0
		t = model.cbGet(GRB.Callback.RUNTIME)
		if (percentGap > 0.99) and (qualityMetric > 0.2):
			if (t < 5 or t < tools.GurobiUtils.data.N):
				print("Neglected poor solution because percentGap=",percentGap," and quality metric = ",qualityMetric)
				return
		print("Entering solution at t=", t, " with pending gap%=", percentGap)
		percentGap = math.floor(percentGap * 100)
		objeValue = math.floor(objeValue * 10000) / 10000.0
		print("Tapped into Solution No", tools.GurobiUtils.solNo, " of objective value ", objeValue," with lower bound at ", lowerBound)
		Hval, Lval, Tval, Wval = extractVariableValuesFromPartialSolution(model)
		buildNewSolution(objeValue, Lval, Tval, Wval, Hval)
		tools.GurobiUtils.solNo = tools.GurobiUtils.solNo + 1


def extractVariableValuesFromPartialSolution(gurobi):
	Lval = []
	Tval = []
	Wval = []
	Hval = []
	for element in range(tools.GurobiUtils.data.N):
		Lval.append(gurobi.cbGetSolution(tools.GurobiUtils.L[element]))
		Tval.append(gurobi.cbGetSolution(tools.GurobiUtils.T[element]))
		Wval.append(gurobi.cbGetSolution(tools.GurobiUtils.W[element]))
		Hval.append(gurobi.cbGetSolution(tools.GurobiUtils.H[element]))
	return Hval, Lval, Tval, Wval
