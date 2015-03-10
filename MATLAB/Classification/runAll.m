%% create a training and test set, then run the classification algorithms

%% Children
[x_test,x_train,y_test,y_train]=create_test_set(numhouse,x_opt.all,children_filtered.all);

%Baseline
baseline.acc=max([children_filtered.numChild, children_filtered.numNoChild])/numhouse;


%knn
knn=runKNN(x_train,x_test,y_train,y_test);


%% Social Grade
