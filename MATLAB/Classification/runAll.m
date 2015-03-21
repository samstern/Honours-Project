%% create a training and test set, then run the classification algorithms

numFeatures=10;
%% Children
x=compositeFeatures(monthSum,dayAverages,x_APOD,x_POW_ratio,x_ADV,x_corr,x_fourier);


%Baseline
baseline.acc=max([children_filtered.numChild, children_filtered.numNoChild])/numhouse;


% %knn
% %x_opt_knn=selectFeatures(x,children_filtered,'c',10,'knn');
% [x_test,x_train,y_test,y_train]=create_test_set(numhouse,x_opt_knn.all,children_filtered.all);
% knn=runKNN(x_train,x_test,y_train,y_test);
% [knn.FPR,knn.TPR,knn.T,knn.AUC] = perfcurve(y_test,knn.score(:,2),1);
% 
% %logistic regression
%x_opt_log_reg_child=selectFeatures(x,children_filtered,'c',numFeatures,'log_reg');
[x_test,x_train,y_test,y_train]=create_test_set(numhouse,x_opt_log_reg_child.all,children_filtered.all);
log_reg_child=runLogReg(x_train,x_test,y_train,y_test,'c');
[log_reg_child.FPR,log_reg_child.TPR,log_reg_child.T,log_reg_child.AUC] = perfcurve(y_test,log_reg_child.predProb,1);
% 
% %random forest
 x_opt_rf=selectFeatures(x,children_filtered,'c',numFeatures,'rf');
 [x_test,x_train,y_test,y_train]=create_test_set(numhouse,x_opt_rf.all,children_filtered.all);
 randomForest= runRandomForest(x_train,x_test,y_train,y_test,'c');
 [randomForest.FPR,randomForest.TPR, randomForest.T,randomForest.AUC] = perfcurve(y_test,randomForest.scores(:,2),1);
% 
% %Plot ROC
% plot(knn.FPR,knn.TPR,'b')
% hold on
% plot(log_reg.FPR,log_reg.TPR,'r')
% plot(randomForest.FPR,randomForest.TPR,'g')
% plot([0:0.1:1],[0:0.1:1],'color',[0.5 0.5 0.5])
% 
% knnAcc=knn.accuracy
% rfAcc=randomForest.accuracy
% lrAcc=log_reg.accuracy
% baselineAcc=baseline.acc

%% Social Grade

%logistic regression
%x_opt_log_reg_sg=selectFeatures(x,social_grade,'s',numFeatures,'log_reg');
[x_test,x_train,y_test,y_train]=create_test_set(numhouse,x_opt_log_reg_sg.all,social_grade.all);
log_reg_sg=runLogReg(x_train,x_test,y_train,y_test,'sg');
%[log_reg_sg.FPR,log_reg_sg.TPR,log_reg_sg.T,log_reg_sg.AUC] = perfcurve(y_test,log_reg_sg.predProb,1);

%knn
%x_opt_knn_social=selectFeatures(x,social_grade,'s',numFeatures,'knn');
[x_test,x_train,y_test,y_train]=create_test_set(numhouse,x_opt_knn_social.all,social_grade.all);
knn=runKNN(x_train,x_test,y_train,y_test);
[knn.FPR,knn.TPR,knn.T,knn.AUC] = perfcurve(y_test,knn.score(:,2),1);

%random forest
%x_opt_rf_social=selectFeatures(x,social_grade,'s',numFeatures,'rf');
[x_test,x_train,y_test,y_train]=create_test_set(numhouse,x_opt_rf_social.all,social_grade.all);
randomForest=runRandomForest(x_train,x_test,y_train,y_test);
[randomForest.FPR,randomForest.TPR,randomForest.T,randomForest.AUC] = perfcurve(y_test,randomForest.scores(:,2),1);
