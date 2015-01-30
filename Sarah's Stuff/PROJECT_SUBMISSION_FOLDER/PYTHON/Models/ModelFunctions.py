#!/usr/bin/python

import numpy as np
import matplotlib.pyplot as plt

# This file will contain the functions I have written that will be used in the modeling portion of this assignment

# One such function is a CSV reader
# that formats the csv files into the appropriate array format for use in modeling using sklearn


def show_data(X,y):
    for label in np.unique(y):
        plt.scatter(X[y == label,0], X[y == label, 1], c = "rgb"[label])
    plt.show()