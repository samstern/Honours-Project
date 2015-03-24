%% create a training and test set, then run the classification algorithms

numFeatures=10;

%Baseline
baseline.child.accuracy=max([children_filtered.numChild, children_filtered.numNoChild])/numhouse;
baseline.ord.accuracy=max([social_grade.numE,social_grade.numD,social_grade.numC2,social_grade.numC1,social_grade.numB,social_grade.numA])/numhouse;

%% Children
x=compositeFeatures(monthSum,dayAverages,x_APOD,x_POW_ratio,x_ADV,x_corr,x_fourier);


%find the best features
%findOptFeatures;


%knn
[x_test.child.knn,x_train.child.knn,y_test.child.knn,y_train.child.knn]=create_test_set(numhouse,x_opt_knn_child.all,children_filtered.all);
knn.child=runKNN(x_train.child.knn,x_test.child.knn,y_train.child.knn,y_test.child.knn);
[knn.child.FPR,knn.child.TPR,knn.child.T,knn.child.AUC] = perfcurve(y_test.child.knn,knn.child.score(:,2),1);

 
%logistic regression
[x_test.child.log_reg,x_train.child.log_reg,y_test.child.log_reg,y_train.child.log_reg]=create_test_set(numhouse,x_opt_log_reg_child.all,children_filtered.all);
log_reg.child=runLogReg(x_train.child.log_reg,x_test.child.log_reg,y_train.child.log_reg,y_test.child.log_reg,'c');
[log_reg.child.FPR,log_reg.child.TPR,log_reg_child.T,log_reg.child.AUC] = perfcurve(y_test.child.log_reg,log_reg.child.score,1);
 
%random forest
[x_test.child.rf,x_train.child.rf,y_test.child.rf,y_train.child.rf]=create_test_set(numhouse,x_opt_rf_child.all,children_filtered.all);
randomForest.child= runRandomForest(x_train.child.rf,x_test.child.rf,y_train.child.rf,y_test.child.rf,'c');
[randomForest.child.FPR,randomForest.child.TPR, randomForest.child.T,randomForest.child.AUC] = perfcurve(y_test.child.rf,randomForest.child.score(:,2),1);
% 
% %Plot ROC
% plot(knn.child.FPR,knn.child.TPR,'b')
% hold on
% plot(log_reg.child.FPR,log_reg.child.TPR,'r')
% plot(randomForest.child.FPR,randomForest.child.TPR,'g')
% plot([0:0.1:1],[0:0.1:1],'color',[0.5 0.5 0.5])
% 
% knnAcc=knn.accuracy
% rfAcc=randomForest.accuracy
% lrAcc=log_reg.accuracy
% baselineAcc=baseline.acc

%% Social Grade

%logistic regression ordinal
[x_test.sg.log_reg_ord,x_train.sg.log_reg_ord,y_test.sg.log_reg_ord,y_train.sg.log_reg_ord]=create_test_set(numhouse,x_opt_log_reg_ord.all,social_grade.all);
log_reg.sg.ord=runLogReg(x_train.sg.log_reg_ord,x_test.sg.log_reg_ord,y_train.sg.log_reg_ord,y_test.sg.log_reg_ord,'ord');
%[log_reg.sg.FPR,log_reg_sg.TPR,log_reg.sg.T,log_reg.sg.AUC] = perfcurve(y_test,log_reg.sg.predProb,1);

%loggistic regression nominal
[x_test.sg.log_reg_nom,x_train.sg.log_reg_nom,y_test.sg.log_reg_nom,y_train.sg.log_reg_nom]=create_test_set(numhouse,x_opt_log_reg_nom.all,social_grade.all);
log_reg.sg.nom=runLogReg(x_train.sg.log_reg_nom,x_test.sg.log_reg_nom,y_train.sg.log_reg_nom,y_test.sg.log_reg_nom,'nom');

%knn
[x_test.sg.knn,x_train.sg.knn,y_test.sg.knn,y_train.sg.knn]=create_test_set(numhouse,x_opt_knn_social.all,social_grade.all);
knn.sg=runKNN(x_train.sg.knn,x_test.sg.knn,y_train.sg.knn,y_test.sg.knn);
[knn.sg.FPR,knn.sg.TPR,knn.sg.T,knn.sg.AUC] = perfcurve(y_test.sg.knn,knn.sg.score(:,2),1);

%random forest
[x_test.sg.rf,x_train.sg.rf,y_test.sg.rf,y_train.sg.rf]=create_test_set(numhouse,x_opt_rf_social.all,social_grade.all);
randomForest.sg=runRandomForest(x_train.sg.rf,x_test.sg.rf,y_train.sg.rf,y_test.sg.rf);
[randomForest.sg.FPR,randomForest.sg.TPR,randomForest.sg.T,randomForest.sg.AUC] = perfcurve(y_test.sg.rf,randomForest.sg.score(:,2),1);

%manual set
[x_test.sg.man,x_train.sg.man,y_test.sg.man,y_train.sg.man]=create_test_set(numhouse,x_man.sg.all,social_grade.all);
