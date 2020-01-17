# Copyright (c) 2020 Aalto University. All rights reserved.

from json.encoder import JSONEncoder
import json
import tools.JSONLoader

class ResultInstance():

    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__,
            sort_keys=True, indent=4)

class ElementLevelResult():
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__,
            sort_keys=True, indent=4)

def SaveToJSon(N, filename, CanvasSize_W, CanvasSize_H, Lval, Tval, Wval, Hval, solNo, data, objValue):
    #print("Started writing")
    layouts = dict()
    layouts['layouts'] = []
    thislayout = dict()
    thislayout['objectiveValue'] = objValue
    thislayout['canvasWidth'] = CanvasSize_W
    thislayout['canvasHeight'] = CanvasSize_H
    thislayout['id'] = solNo
    thislayout['elements'] = []
    for elementNo in range(N):
        content = dict()
        content['x'] = Lval[elementNo]
        content['y'] = Tval[elementNo]
        content['width'] = Wval[elementNo]
        content['height'] = Hval[elementNo]
        content['id'] = data.elements[elementNo].id
        content['type'] = data.elements[elementNo].elementType
        content['verticalPreference'] = data.elements[elementNo].verticalPreference
        content['horizontalPreference'] = data.elements[elementNo].horizontalPreference
        content['fillColorRedValue'] = data.elements[elementNo].redValue
        content['fillColorGreenValue'] = data.elements[elementNo].greenValue
        content['fillColorBlueValue'] = data.elements[elementNo].blueValue
        content['isLocked'] = data.elements[elementNo].isLocked
        thislayout['elements'].append(content)
    layouts['layouts'].append(thislayout)
    print("About to dump file")
    with open("" + (filename + "_" + str(solNo) + ".json"), "w") as write_file:
        json.dump(layouts, write_file)
        write_file.close()