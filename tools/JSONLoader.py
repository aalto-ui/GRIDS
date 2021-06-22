# Copyright (c) 2020 Aalto University. All rights reserved.

import json
import os

from model.DataInstance import DataInstance, Element


def load_json_file(fileName: str) -> DataInstance:
    with open(fileName, "r") as read_file:
        JSONdata = json.load(read_file).get("layouts")[0]
        fileString = os.path.basename(fileName)
        data = dict_to_datainstance(JSONdata)
        data.inputFile = os.path.splitext(fileString)[0]
        print("Loaded ", data.element_count, " elements data from ", fileName)
        return data


def dict_to_datainstance(json_data: dict):
    data = DataInstance()
    data.canvasWidth = json_data.get('canvasWidth')
    data.borderXPadding = json_data.get('borderXPadding')
    data.borderYPadding = json_data.get('borderYPadding')
    data.elementXPadding = json_data.get('elementXPadding')
    data.elementYPadding = json_data.get('elementYPadding')
    data.canvasHeight = json_data.get('canvasHeight')
    if json_data.get('NumOfSolutions'): data.NumOfSolutions = json_data.get('NumOfSolutions')
    else: data.NumOfSolutions = 50 # Default number of solutions
    data.Nearby = json_data.get('Nearby')
    JSONelements = json_data.get('elements')
    data.element_count = len(JSONelements)
    for JSONelement in JSONelements:
        element = Element()
        element.id = JSONelement.get('id')
        element.X = JSONelement.get('x')
        element.Y = JSONelement.get('y')
        element.width = JSONelement.get('width')
        element.height = JSONelement.get('height')
        element.minWidth = JSONelement.get('minWidth')
        element.minHeight = JSONelement.get('minHeight')
        element.maxWidth = JSONelement.get('maxWidth')
        element.maxHeight = JSONelement.get('maxHeight')
        element.horizontalPreference = JSONelement.get('horizontalPreference')
        element.verticalPreference = JSONelement.get('verticalPreference')
        element.aspectRatio = JSONelement.get('aspectRatio')
        element.elementType = JSONelement.get('type')
        element.redValue = JSONelement.get('fillColorRedValue')
        element.greenValue = JSONelement.get('fillColorGreenValue')
        element.blueValue = JSONelement.get('fillColorBlueValue')
        element.isLocked = JSONelement.get('isLocked')

        if element.width is not None and element.width >= 0:
            element.minWidth = element.width
            element.maxWidth = element.width
        if element.height is not None and element.height >= 0:
            element.minHeight = element.height
            element.maxHeight = element.height

        data.elements.append(element)
    return data
