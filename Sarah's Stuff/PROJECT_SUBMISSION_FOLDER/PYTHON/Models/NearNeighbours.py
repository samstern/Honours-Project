#!/usr/bin/python
from sklearn.neighbors import KNeighborsClassifier
X = [[0], [1], [2], [3]]
y = [0, 0, 1, 1]

# Dataset_X = function to get the data array
# Dataset_y = function to get the target array
neigh = KNeighborsClassifier(n_neighbors=3)
neigh.fit(X, y)