#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 24 14:14:00 2020

@author: Abishek Vaithylingam
"""
#Script to convert .bmp images to .png images

from PIL import Image
import os
directory = '/Users/abishekvaithylingam/Desktop/Dissertation Results/'

for filename in os.listdir(directory):
    if filename.endswith(".bmp"):
        img = Image.open(directory +  filename)
        new_img = img.save(directory + filename.split('.')[0]  +  ".png", 'png')
    else:
        pass