# Copyright (c) 2020 Aalto University. All rights reserved.

from typing import List, Optional


class DataInstance:
    def __init__(self):
        self.inputFile: str = ""
        self.canvasWidth: int = 0
        self.canvasHeight: int = 0
        self.NumOfSolutions: int = 0
        self.elements: List[Element] = []
        self.element_count: int = 0
        self.Nearby = None
        self.borderXPadding: int = 0
        self.elementXPadding: int = 0
        self.elementYPadding: int = 0
        self.borderYPadding: int = 0


class Element:
    def __init__(self):
        self.width: Optional[int] = None
        self.height: Optional[int] = None
        self.minWidth: Optional[int] = None
        self.minHeight: Optional[int] = None
        self.maxWidth: Optional[int] = None
        self.maxHeight: Optional[int] = None
        self.aspectRatio = None
        self.horizontalPreference = None
        self.verticalPreference = None
        self.elementType = None
        self.X: Optional[int] = None
        self.Y: Optional[int] = None
        self.id = None
        self.redValue: Optional[int] = None
        self.greenValue: Optional[int] = None
        self.blueValue: Optional[int] = None
        self.isLocked: bool = False