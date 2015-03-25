function sgEvaluate(ord,nom,rf,knn,ordMan,nomMan,rfMan,knnMan,baseline,y_test)
%--Accuracy
accuracies=[ord.accuracy,ordMan.accuracy;nom.accuracy,nomMan.accuracy;rf.accuracy,rfMan.accuracy;knn.accuracy,knnMan.accuracy];
labels={'Ordinal Logistic Regression','Nominal Logistic Regression','Random Forest','K Nearest Neighbor'};
p1=bar(accuracies*100);
ylim([0 100])
title('Classifier Accuracy')
ylabel('%');
set(gca,'XTickLabel',labels)
hold on
p2=plot(xlim,[baseline.accuracy baseline.accuracy].*100,'black');
legend('SFS','Man','Baseline')
hold off

%Accuracy Within 1
figure;
acc1=[accuracyWithinN(ord,1),accuracyWithinN(ordMan,1);accuracyWithinN(nom,1),accuracyWithinN(nomMan,1);accuracyWithinN(rf,1),...
    accuracyWithinN(rfMan,1);accuracyWithinN(knn,1),accuracyWithinN(knnMan,1)];
bar(acc1*100);
ylim([0 100])
title('Classifier Accuracy within 1')
ylabel('%');
set(gca,'XTickLabel',labels)
legend('SFS','Man')

%Accuracy Within 2
figure;
acc1=[accuracyWithinN(ord,2),accuracyWithinN(ordMan,2);accuracyWithinN(nom,2),accuracyWithinN(nomMan,2);accuracyWithinN(rf,2),...
    accuracyWithinN(rfMan,2);accuracyWithinN(knn,2),accuracyWithinN(knnMan,2)];
bar(acc1*100);
ylim([0 100])
title('Classifier Accuracy within 1')
ylabel('%');
set(gca,'XTickLabel',labels)
legend('SFS','Man')

%Binarize Classifier (2.vs.all)
probAB.nom=binarizeProb(nom,[5,6]);probAB.nomMan=binarizeProb(nomMan,[5,6]);probAB.ord=binarizeProb(ord,[5,6]);probAB.ordMan=binarizeProb(ordMan,[5,6]);
probAB.rf=binarizeProb(rf,[5,6]);probAB.rfMan=binarizeProb(rfMan,[5,6]);probAB.knn=binarizeProb(knn,[5,6]);probAB.knnMan=binarizeProb(knnMan,[5,6]);

probC1C2.nom=binarizeProb(nom,[3,4]);probC1C2.nomMan=binarizeProb(nomMan,[3,4]);probC1C2.ord=binarizeProb(ord,[3,4]);probC1C2.ordMan=binarizeProb(ordMan,[3,4]);
probC1C2.rf=binarizeProb(rf,[3,4]);probC1C2.rfMan=binarizeProb(rfMan,[3,4]);probC1C2.knn=binarizeProb(knn,[3,4]);probC1C2.knnMan=binarizeProb(knnMan,[3,4]);

probDE.nom=binarizeProb(nom,[1,2]);probDE.nomMan=binarizeProb(nomMan,[1,2]);probDE.ord=binarizeProb(ord,[1,2]);probDE.ordMan=binarizeProb(ordMan,[1,2]);
probDE.rf=binarizeProb(rf,[1,2]);probDE.rfMan=binarizeProb(rfMan,[1,2]);probDE.knn=binarizeProb(knn,[1,2]);probDE.knnMan=binarizeProb(knnMan,[1,2]);

[nom.FPR,nom.TPR,nom.T,nom.AUC]=perfcurve(y_test,probAB.nom(:,1),1);
[nomMan.FPR,nomMan.TPR,nomMan.T,nomMan.AUC]=perfcurve(y_test,probAB.nomMan(:,1),1);
[ord.FPR,ord.TPR,ord.T,ord.AUC]=perfcurve(y_test,probAB.ord(:,1),1);
[ordMan.FPR,ordMan.TPR,ordMan.T,ordMan.AUC]=perfcurve(y_test,probAB.ordMan(:,1),1);
[rf.FPR,rf.TPR,rf.T,rf.AUC]=perfcurve(y_test,probAB.rf(:,1),1);
[frMan.FPR,rfMan.TPR,rfMan.T,rfMan.AUC]=perfcurve(y_test,probAB.rfMan(:,1),1);
figure;
plot(nom.FPR,nom.TPR,'b');
hold on
plot(nomMan.FPR,nomMan.TPR,':b');
plot(ord.FPR,ord.TPR,'m');
plot(ordMan.FPR,ordMan.TPR,':m');
plot(rf.FPR,rf.TPR,'g');
plot(rfMan.FPR,rfMan.TPR,':g');
plot(knn.FPR,knn.TPR,'r');
plot(knnMan.FPR,knnMan.TPR,':r');
% probC1C2=[binarizeProb(log_reg,[3,4]),binarizeProb(rf,[3,4]),binarizeProb(knn,[3,4])];
% probDE=[binarizeProb(log_reg,[1,2]),binarizeProb(rf,[1,2]),binarizeProb(knn,[1,2])];
% [l,r,k]=perfCurve(probC1C2,y_test);
% plot(r.FPR,r.TPR)
end


function acc=accuracyWithinN(model,n)
    for i=1:length(model.confusion)
        if i<=n
            ac(i) = sum(model.confusion(i,[i:i+n]));
        elseif i>=length(model.confusion)-n
            ac(i) = sum(model.confusion(i,[i-n:length(model.confusion)]));
        else
            ac(i) = sum(model.confusion(i,[i-n:i+n]));
        end
    end
    acc=sum(ac)/sum(sum(model.confusion));
end

function p=binarizeProb(model,classes)
    p(:,1)=sum(model.score(:,classes)')';
    p(:,2)=sum(model.score(:,find(~ismember([1:6],classes)))')';
end

function [lr,rf,knn]=perfCurve(scores, y_test)
    [lr.FPR,lr.TPR,lr.T,lr.AUC]=perfcurve(y_test.sg.log_reg,scores(:,2),1);
    [rf.FPR,rf.TPR,rf.T,rf.AUC]=perfcurve(y_test.sg.rf,scores(:,4),1);
    [knn.FPR,knn.TPR,knn.T,knn.AUC]=perfcurve(y_test.sg.knn,scores(:,6),1);
end

    