%% create a training and test set, then run the classification algorithms

numFeatures=10;
testHouseholds=randsample(numhouse,round(numhouse/5));

%Baseline
baseline.child.accuracy=max([children_filtered.numChild, children_filtered.numNoChild])/numhouse;
baseline.sg.accuracy=max([social_grade.numE,social_grade.numD,social_grade.numC2,social_grade.numC1,social_grade.numB,social_grade.numA])/numhouse;

%% Children
x=compositeFeatures(monthSum,dayAverages,x_APOD,x_POW_ratio,x_ADV,x_corr,x_fourier);


%find the best features
%findOptFeatures;


%knn
% [x_test.child.knn,x_train.child.knn,y_test.child.knn,y_train.child.knn]=create_test_set(numhouse,x_opt_knn_child.all,children_filtered.all,testHouseholds);
% knn.child=runKNN(x_train.child.knn,x_test.child.knn,y_train.child.knn,y_test.child.knn);
% [knn.child.FPR,knn.child.TPR,knn.child.T,knn.child.AUC] = perfcurve(y_test.child.knn,knn.child.score(:,2),1);
% 
% [x_test.child.knnMan,x_train.child.knnMan,y_test.child.knnMan,y_train.child.knnMan]=create_test_set(numhouse,x_man.child.all,children_filtered.all,testHouseholds);
% knn_Man.child=runKNN(x_train.child.knnMan,x_test.child.knnMan,y_train.child.knnMan,y_test.child.knnMan);
% [knn_Man.child.FPR,knn_Man.child.TPR,knn.child.T,knn_Man.child.AUC] = perfcurve(y_test.child.knnMan,knn_Man.child.score(:,2),1);
% 
%  
% %logistic regression
% [x_test.child.log_reg,x_train.child.log_reg,y_test.child.log_reg,y_train.child.log_reg]=create_test_set(numhouse,x_opt_log_reg_child.all,children_filtered.all,testHouseholds);
% log_reg.child=runLogReg(x_train.child.log_reg,x_test.child.log_reg,y_train.child.log_reg,y_test.child.log_reg,'c');
% [log_reg.child.FPR,log_reg.child.TPR,log_reg.child.T,log_reg.child.AUC] = perfcurve(y_test.child.log_reg,log_reg.child.score,1);
% 
% [x_test.child.lr_Man,x_train.child.lr_Man,y_test.child.lr_Man,y_train.child.lr_Man]=create_test_set(numhouse,x_man.child.all,children_filtered.all,testHouseholds);
% lrMan.child=runLogReg(x_train.child.lr_Man,x_test.child.lr_Man,y_train.child.lr_Man,y_test.child.lr_Man,'c');
% [lrMan.child.FPR,lrMan.child.TPR,lrMan.T,lrMan.child.AUC] = perfcurve(y_test.child.lr_Man,lrMan.child.score,1);
%  
% %random forest
% [x_test.child.rf,x_train.child.rf,y_test.child.rf,y_train.child.rf]=create_test_set(numhouse,x_opt_rf_child.all,children_filtered.all,testHouseholds);
% randomForest.child= runRandomForest(x_train.child.rf,x_test.child.rf,y_train.child.rf,y_test.child.rf,'c');
% [randomForest.child.FPR,randomForest.child.TPR, randomForest.child.T,randomForest.child.AUC] = perfcurve(y_test.child.rf,randomForest.child.score(:,2),1);
% 
% [x_test.child.rf_Man,x_train.child.rf_Man,y_test.child.rf_Man,y_train.child.rf_Man]=create_test_set(numhouse,x_man.child.all,children_filtered.all,testHouseholds);
% rf_Man.child= runRandomForest(x_train.child.rf_Man,x_test.child.rf_Man,y_train.child.rf_Man,y_test.child.rf_Man,'c');
% [rf_Man.child.FPR,rf_Man.child.TPR, rf_Man.child.T,rf_Man.child.AUC] = perfcurve(y_test.child.rf,rf_Man.child.score(:,2),1);
% % 
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

%knn
[x_test.sg.knn,x_train.sg.knn,y_test.sg.knn,y_train.sg.knn]=create_test_set(numhouse,x_opt_knn_social.all,social_grade.all,testHouseholds);
knn.sg=runKNN(x_train.sg.knn,x_test.sg.knn,y_train.sg.knn,y_test.sg.knn);
[knn.sg.FPR,knn.sg.TPR,knn.sg.T,knn.sg.AUC] = perfcurve(y_test.sg.knn,knn.sg.score(:,2),1);

[x_test.sg.knnMan,x_train.sg.knnMan,y_test.sg.knnMan,y_train.sg.knnMan]=create_test_set(numhouse,x_man.sg.all,social_grade.all,testHouseholds);
knn_Man.sg=runKNN(x_train.sg.knnMan,x_test.sg.knnMan,y_train.sg.knnMan,y_test.sg.knnMan);
[knn_Man.sg.FPR,knn_Man.sg.TPR,knn.sg.T,knn_Man.sg.AUC] = perfcurve(y_test.sg.knnMan,knn_Man.sg.score(:,2),1);

 
%loggistic regression nominal
[x_test.sg.log_reg_nom,x_train.sg.log_reg_nom,y_test.sg.log_reg_nom,y_train.sg.log_reg_nom]=create_test_set(numhouse,x_opt_log_reg_nom.all,social_grade.all,testHouseholds);
log_reg.nom=runLogReg(x_train.sg.log_reg_nom,x_test.sg.log_reg_nom,y_train.sg.log_reg_nom,y_test.sg.log_reg_nom,'nom');

[x_test.sg.log_reg_nom,x_train.sg.log_reg_nom,y_test.sg.log_reg_nom,y_train.sg.log_reg_nom]=create_test_set(numhouse,x_man.sg.all,social_grade.all,testHouseholds);
lrMan.nom=runLogReg(x_train.sg.log_reg_nom,x_test.sg.log_reg_nom,y_train.sg.log_reg_nom,y_test.sg.log_reg_nom,'nom');

[x_test.sg.log_reg_ord,x_train.sg.log_reg_ord,y_test.sg.log_reg_ord,y_train.sg.log_reg_ord]=create_test_set(numhouse,x_opt_log_reg_ord.all,social_grade.all,testHouseholds);
log_reg.ord=runLogReg(x_train.sg.log_reg_ord,x_test.sg.log_reg_ord,y_train.sg.log_reg_ord,y_test.sg.log_reg_ord,'ord');

[x_test.sg.log_reg_ord,x_train.sg.log_reg_ord,y_test.sg.log_reg_ord,y_train.sg.log_reg_ord]=create_test_set(numhouse,x_man.sg.all,social_grade.all,testHouseholds);
lrMan.ord=runLogReg(x_train.sg.log_reg_ord,x_test.sg.log_reg_ord,y_train.sg.log_reg_ord,y_test.sg.log_reg_ord,'ord');
 
%random forest
[x_test.sg.rf,x_train.sg.rf,y_test.sg.rf,y_train.sg.rf]=create_test_set(numhouse,x_opt_rf_social.all,social_grade.all,testHouseholds);
randomForest.sg= runRandomForest(x_train.sg.rf,x_test.sg.rf,y_train.sg.rf,y_test.sg.rf,'c');
[randomForest.sg.FPR,randomForest.sg.TPR, randomForest.sg.T,randomForest.sg.AUC] = perfcurve(y_test.sg.rf,randomForest.sg.score(:,2),1);

[x_test.sg.rf_Man,x_train.sg.rf_Man,y_test.sg.rf_Man,y_train.sg.rf_Man]=create_test_set(numhouse,x_man.sg.all,social_grade.all,testHouseholds);
rf_Man.sg= runRandomForest(x_train.sg.rf_Man,x_test.sg.rf_Man,y_train.sg.rf_Man,y_test.sg.rf_Man,'c');
[rf_Man.sg.FPR,rf_Man.sg.TPR, rf_Man.sg.T,rf_Man.sg.AUC] = perfcurve(y_test.sg.rf,rf_Man.sg.score(:,2),1);