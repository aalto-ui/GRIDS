# GRIDS LayoutEngine

### By Niraj Dayama, Kashyap Todi, Taru Saarelainen, Antti Oulasvirta
### Copyright (c) 2020 Aalto University. All rights reserved.

The layout engine implements the MILP optimiser used by GRIDS. It is implemented in Python, and uses the Gurobi optimiser.

## Requirements
1. Python 3.0
2. Gurobipy (Gurobi Optimiser for Python)

## How to use
To run the optimiser with an input JSON file (example file included in directory), execute the following command in terminal:

> python StartMe.py <PATH_TO_JSON_INPUT_FILE>

The generated output JSON files will be saved in the present working directory.
To view the JSON files, you can use the layout viewer app available at: https://kashyaptodi.com/jsonviewer/
