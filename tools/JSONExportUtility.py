# Copyright (c) 2020 Aalto University. All rights reserved.

import json
from pathlib import Path

from model.SolutionInstance import SolutionInstance
from model.Constants import OUTPUT_DIR
from model.DataInstance import DataInstance


def save_to_json(data: DataInstance, solution: SolutionInstance):
    # print("Started writing")
    layouts = {
        'layouts': [
            solution_to_layout(data, solution)
        ]
    }
    print("About to dump file")
    solution_filename = data.inputFile + "_" + str(solution.solNo) + ".json"

    Path(OUTPUT_DIR).mkdir(exist_ok=True, parents=True)
    with open(OUTPUT_DIR + solution_filename, "w") as write_file:
        json.dump(layouts, write_file)


def solution_to_layout(data: DataInstance, solution: SolutionInstance):
    thislayout = {
        'objectiveValue': solution.objVal,
        'canvasWidth': data.canvasWidth,
        'canvasHeight': data.canvasHeight,
        'id': solution.solNo,
        'elements': []
    }
    for x, y, w, h, el in zip(solution.X, solution.Y, solution.W, solution.H, data.elements):
        thislayout['elements'].append({
            'x': x,
            'y': y,
            'width': w,
            'height': h,

            'id': el.id,
            'type': el.elementType,
            'verticalPreference': el.verticalPreference,
            'horizontalPreference': el.horizontalPreference,
            'fillColorRedValue': el.redValue,
            'fillColorGreenValue': el.greenValue,
            'fillColorBlueValue': el.blueValue,
            'isLocked': el.isLocked,
        })
    return thislayout
