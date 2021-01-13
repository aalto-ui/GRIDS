# Copyright 2018 Google LLC
# Modifications copyright 2020 Aalto University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
import numpy as np


def draw_layout_direct(elements: iter, size=None, bgcolor=(255, 255, 255)):
    """
    Borrowed from sg2im https://github.com/google/sg2im/blob/master/sg2im/vis.py
    Heavily modified according to own requirements
    """
    if size is None:
        size = (256, 200)

    cmap = plt.get_cmap('rainbow')
    colors = cmap(np.linspace(0, 1, len(elements)))

    bgcolor = np.asarray(bgcolor)
    bg = np.ones((size[1], size[0], 1)) * bgcolor
    plt.imshow(bg.astype(np.uint8))

    plt.gca().set_xlim(0, size[0])
    plt.gca().set_ylim(size[1], 0)
    plt.gca().set_aspect(1.0, adjustable='box')

    for i, el in enumerate(elements):
        draw_box(el, colors[i], el['name'], size[1])


def draw_box(el, color, text, size=200):
    """
    Borrowed from sg2im https://github.com/google/sg2im/blob/master/sg2im/vis.py
    Heavily modified according to own requirements
    """
    TEXT_BOX_HEIGHT = int(size / 10)

    x0, y0, w, h = el['x'], el['y'], el['w'], el['h'],
    x1 = x0 + w

    fccolor = '#ffffff'
    alpha = .7

    rect = Rectangle((x0, y0), w, h, fc=fccolor, lw=2, ec=color, alpha=alpha)
    plt.gca().add_patch(rect)

    text_rect = Rectangle((x0, y0), w, min(TEXT_BOX_HEIGHT, h), fc=color, alpha=0.5)
    plt.gca().add_patch(text_rect)
    tx = 0.5 * (x0 + x1)
    ty = y0 + min(TEXT_BOX_HEIGHT, h) / 2.0
    plt.text(tx, ty, text, va='center', ha='center')
