# Copyright (c) 2020 Aalto University. All rights reserved.

from model.SolutionInstance import SolutionInstance
from tools.JSONExportUtility import save_to_json
from model.DataInstance import DataInstance
from tools.PlotUtils import draw_solution


class SolutionManager:
    def __init__(self):
        self.solution_hashes = set()
        self.solution_callbacks = []

    def build_new_solution(self, data: DataInstance, solNo, objValue, Lval, Tval, Wval, Hval):
        sol_hash = hash((str(Lval), str(Tval), str(Wval), str(Hval)))  # hash a tuple
        if sol_hash in self.solution_hashes:
            print("** Neglecting a repeat solution **")
            return
        else:
            self.solution_hashes.add(sol_hash)

            solution = SolutionInstance(objValue, Lval, Tval, Wval, Hval, solNo)
            for cb in self.solution_callbacks:
                cb(data, solution)

    def add_solution_handler(self, cb):
        assert callable(cb)
        self.solution_callbacks.append(cb)

    def sol_count(self) -> int:
        return len(self.solution_hashes)


def json_handler(data: DataInstance, solution: SolutionInstance):
    save_to_json(data, solution)


def plot_handler(data: DataInstance, solution: SolutionInstance):
    draw_solution(data, solution)
