# Copyright (c) 2020 Aalto University. All rights reserved.

import argparse

import model.SolutionManager as SolutionManager
from execute.FlexiFixPlacement import FlexiFixPlacement
from tools import JSONLoader

parser = argparse.ArgumentParser()
parser.add_argument('input', type=str, help='Please launch with JSON file as first argument')
parser.add_argument('--draw', action='store_true')

args = parser.parse_args()

data = JSONLoader.load_json_file(args.input)
SolutionManager.add_solution_handler(SolutionManager.json_handler)
if args.draw:
    SolutionManager.add_solution_handler(SolutionManager.plot_handler)

model = FlexiFixPlacement(data)
model.solve()
