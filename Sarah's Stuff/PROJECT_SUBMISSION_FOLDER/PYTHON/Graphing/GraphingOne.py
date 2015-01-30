#!/usr/bin/python

import matplotlib.pyplot as plt

LDAs = []
KNNs = []
SVMs = []


LDA_result = 0
SVM_Result = 0
KNN_result = 0

featurename = [LDA_result,SVM_Result,KNN_result]




Beckel = [73,73,70]

B_RWSHH = [77,78,86]

ListOfResults = [Beckel,B_RWSHH]

xpoints = range(0,len(ListOfResults))

for i in range(0,len(ListOfResults)):
    LDAs.append(ListOfResults[i][0])
    SVMs.append(ListOfResults[i][1])
    KNNs.append(ListOfResults[i][2])

fig = plt.scatter(xpoints,LDAs,s=200,c='g', marker='+')
fig = plt.scatter(xpoints,SVMs,s=150,c='k', marker = 'x')
fig = plt.scatter(xpoints,KNNs,s=150,c='r', marker = 'd')
plt.xticks(range(0,2))
plt.ylim((20,90))
plt.title('title')
plt.xlabel('xlabel')
plt.ylabel('ylabel')
plt.show()