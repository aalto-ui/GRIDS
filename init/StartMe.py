# Copyright (c) 2020 Aalto University. All rights reserved.

import sys
from tools import JSONLoader
from execute import FlexiFixPlacement

if(len(sys.argv)<2):
    print("SYNTAX ERROR: Please launch with JSON file as first argument")
    exit(-1)
if(len(sys.argv[1])<6):
    print("SYNTAX ERROR: Please give full path of JSON file as first argument")
    exit(-1)
    
data = JSONLoader.loadJSONFile(sys.argv[1])
FlexiFixPlacement.solve(data)