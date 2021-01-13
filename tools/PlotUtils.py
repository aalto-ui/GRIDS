# Copyright (c) 2020 Aalto University. All rights reserved.

import matplotlib.pyplot as plt

from model.SolutionInstance import SolutionInstance
from model.DataInstance import DataInstance
from model.Constants import OUTPUT_DIR
from external.vis import draw_layout_direct


def draw_solution(data: DataInstance, solution: SolutionInstance):
    plt.clf()
    elements = []
    for elementNo in range(data.element_count):
        elements.append({
            'x': solution.X[elementNo],
            'y': solution.Y[elementNo],
            'w': solution.W[elementNo],
            'h': solution.H[elementNo],
            'name': data.elements[elementNo].elementType
        })

    draw_layout_direct(elements, (data.canvasWidth, data.canvasHeight))
    plt.xticks([])
    plt.yticks([])

    plt.savefig(OUTPUT_DIR + data.inputFile + "_" + str(solution.solNo) + ".png")
    # plt.show()
