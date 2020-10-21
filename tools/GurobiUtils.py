# Copyright (c) 2020 Aalto University. All rights reserved.

from gurobipy import GRB, Model


def define1DIntVarArray(gurobiModel: Model, N: int, label: str):
    return gurobiModel.addVars(N, vtype=GRB.INTEGER, name=label)


def define2DBoolVarArrayArray(gurobiModel, sizeX, sizeY, name):
    return gurobiModel.addVars(sizeX, sizeY, vtype=GRB.BINARY, name=name)


def define1DBoolVarArray(gurobiModel: Model, N: int, label: str):
    return gurobiModel.addVars(N, vtype=GRB.BINARY, name=label)
