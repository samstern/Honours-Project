function cEvaluate(log_reg,rf,knn,lrMan,rfMan,knnMan,baseline)

%--Accuracy
accuracies=[log_reg.accuracy,lrMan.accuracy;rf.accuracy,rfMan.accuracy;knn.accuracy,knnMan.accuracy].*100
labels={'Logistic Regression','Random Forest','K Nearest Neighbor'};
p1=bar(accuracies);
ylim([0 100])
title('Classifier Accuracy')
ylabel('%');
set(gca,'XTickLabel',labels)
hold on
p2=plot(xlim,[baseline.accuracy baseline.accuracy].*100,'black');
legend('SFS','Man','Baseline')
hold off

%---ROC
%SFS
figure;
subplot(1,2,1)
plot(log_reg.FPR,log_reg.TPR,'b')
hold on
plot(rf.FPR,rf.TPR,'g')
plot(knn.FPR,knn.TPR,'r')
plot([0:0.1:1],[0:0.1:1],'black')
legend('Logistic Regression','Random Forest','K Nearest Neighbor','Rangom Guess','location','southeast')
title('ROC for SFS Features')
ylabel('TPR')
xlabel('FPR')

%MAN
subplot(1,2,2)
plot(lrMan.FPR,lrMan.TPR,'b')
hold on
plot(rfMan.FPR,rfMan.TPR,'g')
plot(knnMan.FPR,knnMan.TPR,'r')
plot([0:0.1:1],[0:0.1:1],'black')
legend('Logistic Regression','Random Forest','K Nearest Neighbor','Random Guess','location','southeast')
title('ROC for Manually Selected Features')
ylabel('TPR')
xlabel('FPR')

%---Matthews
figure;
mats=[matthews(log_reg),matthews(lrMan);matthews(rf),matthews(rfMan);matthews(knn),matthews(knnMan)]
bar(mats)
set(gca,'XTickLabel',labels)
ylim([-1,1]);
legend('SFS','MAN')
title('Matthews Correlation Coefficient')

%---Confusion Matrecies

lrSFSConf=log_reg.confusion
lrManConf=lrMan.confusion
rfSFSConf=rf.confusion
rfManConf=rfMan.confusion
knnSFSConf=knn.confusion
knnManConf=knnMan.confusion

AUC=[log_reg.AUC,lrMan.AUC;rf.AUC,rfMan.AUC;knn.AUC,knnMan.AUC]

%TPR=[TPR(log_reg),TPR(lrMan);TPR(rf),TPR(rfMan);TPR(knn),TPR(knnMan)]
TNR=[TNR(log_reg),TNR(lrMan);TNR(rf),TNR(rfMan);TPR(knn),TNR(knnMan)]
end

function coef=matthews(model)
    TP=model.confusion(1,1);
    FN=model.confusion(1,2);
    FP=model.confusion(2,1);
    TN=model.confusion(2,2);
    
    coef=((TP*TN)-(FP*FN))/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));
end

function out=TPR(model)
    TP=model.confusion(1,1);
    FN=model.confusion(1,2);
    FP=model.confusion(2,1);
    TN=model.confusion(2,2);
    
    out=TP/(TP+FN);
end

function out=TNR(model)
    TP=model.confusion(1,1);
    FN=model.confusion(1,2);
    FP=model.confusion(2,1);
    TN=model.confusion(2,2);
    
    out=TN/(TN+FP);
end
%[knn_Man.child.FPR,knn_Man.child.TPR,knn_Man.child.T,knn_Man.child.AUC] = perfcurve(y_test.child.knn,knn.child.score(:,2),1);