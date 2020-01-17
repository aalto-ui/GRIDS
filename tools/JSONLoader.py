# Copyright (c) 2020 Aalto University. All rights reserved.

from json.encoder import JSONEncoder
import json
import sys
import os

class DataInstance:
    inputFile = ""
    canvasWidth = None
    canvasHeight = None
    NumOfSolutions = None
    elements = []
    N = None
    Nearby = None
    borderXPadding : int = None
    elementXPadding : int = None
    elementYPadding : int = None
    borderYPadding : int = None


class Element:
    width  = None
    height = None
    minWidth  = None
    minHeight = None
    maxWidth  = None
    maxHeight = None
    aspectRatio = None
    horizontalPreference = None
    verticalPreference = None
    elementType = None
    X = None
    Y = None
    id = None
    redValue = None
    greenValue = None
    blueValue = None
    isLocked = None



def loadJSONFile(fileName) -> DataInstance:
    with open(fileName, "r") as read_file:
        data = DataInstance()
        JSONdata = json.load(read_file).get("layouts")[0]
        fileString = os.path.basename(fileName)
        data.inputFile = os.path.splitext(fileString)[0]
        data.canvasWidth = JSONdata.get('canvasWidth')
        data.borderXPadding = JSONdata.get('borderXPadding')
        data.borderYPadding = JSONdata.get('borderYPadding')
        data.elementXPadding = JSONdata.get('elementXPadding')
        data.elementYPadding = JSONdata.get('elementYPadding')
        data.canvasHeight = JSONdata.get('canvasHeight')
        data.NumOfSolutions = JSONdata.get('NumOfSolutions')
        data.Nearby = JSONdata.get('Nearby')
        JSONelements = JSONdata.get('elements')
        data.N = len(JSONelements)
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


            if(element.width is not None and element.width >= 0):
                element.minWidth = element.width
                element.maxWidth = element.width
            if (element.height is not None and element.height >= 0):
                element.minHeight = element.height
                element.maxHeight = element.height

            data.elements.append(element)
        print("Loaded ",data.N," elements data from ",fileName)
        return data
