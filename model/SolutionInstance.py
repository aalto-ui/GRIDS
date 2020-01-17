import tools.GurobiUtils
class SolutionInstance:
    def __init__(self, objVal, X,Y,W,H):
        self.X = X
        self.Y = Y
        self.W = W
        self.H = H
        self.objVal = objVal

    def computeIndex(ABOVE, LEFT):
        index = 0
        for element in range(1, tools.GurobiUtils.data.N+1):
            for other in range(1, tools.GurobiUtils.data.N+1):
                index = index + (element*other*other*ABOVE[element,other])+(element*other*element*LEFT[element,other])
        return index
