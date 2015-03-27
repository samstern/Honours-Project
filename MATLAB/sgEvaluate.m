function sgEvaluate(ord,nom,rf,knn,ordMan,nomMan,rfMan,knnMan,baseline,y_test)
%--Accuracy
figure;
subplot(3,1,1)
accuracies=[ord.accuracy,ordMan.accuracy;nom.accuracy,nomMan.accuracy;rf.accuracy,rfMan.accuracy;knn.accuracy,knnMan.accuracy];
labels={'Ordinal LR','Nominal LR','Random Forest','K Nearest Neighbor'};
p1=bar(accuracies*100);
ylim([0 100])
title('Classifier Accuracy')
ylabel('%');
set(gca,'XTickLabel',labels)
hold on
p2=plot(xlim,[baseline.accuracy baseline.accuracy].*100,'black');
legend('SFS','MAN','Baseline','location','eastoutside')
hold off

%Accuracy Within 1
subplot(3,1,2)
acc1=[accuracyWithinN(ord,1),accuracyWithinN(ordMan,1);accuracyWithinN(nom,1),accuracyWithinN(nomMan,1);accuracyWithinN(rf,1),...
    accuracyWithinN(rfMan,1);accuracyWithinN(knn,1),accuracyWithinN(knnMan,1)];
bar(acc1*100);
ylim([0 100])
title('Classifier Accuracy within 1')
ylabel('%');
set(gca,'XTickLabel',labels)
hold on;
p2=plot(xlim,[0.63 0.63].*100,'black');
legend('SFS','MAN','C1 or C2','location','eastoutside')

%Accuracy Within 2
%figure;
subplot(3,1,3)
acc2=[accuracyWithinN(ord,2),accuracyWithinN(ordMan,2);accuracyWithinN(nom,2),accuracyWithinN(nomMan,2);accuracyWithinN(rf,2),...
    accuracyWithinN(rfMan,2);accuracyWithinN(knn,2),accuracyWithinN(knnMan,2)];
bar(acc2*100);
ylim([0 100])
title('Classifier Accuracy within 2')
ylabel('%');
set(gca,'XTickLabel',labels)
hold on;
p2=plot(xlim,[0.63 0.63].*100,'black');
legend('SFS','MAN','C1, C2 or B','location','eastoutside')

%Binarize Classifier (2.vs.all)
probAB.nom=binarizeProb(nom,[5,6]);probAB.nomMan=binarizeProb(nomMan,[5,6]);probAB.ord=binarizeProb(ord,[5,6]);probAB.ordMan=binarizeProb(ordMan,[5,6]);
probAB.rf=binarizeProb(rf,[5,6]);probAB.rfMan=binarizeProb(rfMan,[5,6]);probAB.knn=binarizeProb(knn,[5,6]);probAB.knnMan=binarizeProb(knnMan,[5,6]);

probC1C2.nom=binarizeProb(nom,[3,4]);probC1C2.nomMan=binarizeProb(nomMan,[3,4]);probC1C2.ord=binarizeProb(ord,[3,4]);probC1C2.ordMan=binarizeProb(ordMan,[3,4]);
probC1C2.rf=binarizeProb(rf,[3,4]);probC1C2.rfMan=binarizeProb(rfMan,[3,4]);probC1C2.knn=binarizeProb(knn,[3,4]);probC1C2.knnMan=binarizeProb(knnMan,[3,4]);

probDE.nom=binarizeProb(nom,[1,2]);probDE.nomMan=binarizeProb(nomMan,[1,2]);probDE.ord=binarizeProb(ord,[1,2]);probDE.ordMan=binarizeProb(ordMan,[1,2]);
probDE.rf=binarizeProb(rf,[1,2]);probDE.rfMan=binarizeProb(rfMan,[1,2]);probDE.knn=binarizeProb(knn,[1,2]);probDE.knnMan=binarizeProb(knnMan,[1,2]);


%--Matthews
figure;
mats=[matthews(ord),matthews(ordMan);matthews(nom),matthews(nomMan);matthews(rf),matthews(rfMan);matthews(knn),matthews(knnMan)]
bar(mats)
set(gca,'XTickLabel',labels)
legend('SFS','MAN')
%ylim([-1 1])
title('Matthews Correlation Coefficient')

%--ROC

%AB
[nom.FPR.AB,nom.TPR.AB,nom.T,nom.AUC]=perfcurve(y_test.log_reg_nom,probAB.nom(:,1),1);
[nomMan.FPR.AB,nomMan.TPR.AB,nomMan.T,nomMan.AUC]=perfcurve(y_test.log_reg_nom,probAB.nomMan(:,1),1);
[ord.FPR.AB,ord.TPR.AB,ord.T,ord.AUC]=perfcurve(y_test.log_reg_ord,probAB.ord(:,1),1);
[ordMan.FPR.AB,ordMan.TPR.AB,ordMan.T,ordMan.AUC]=perfcurve(y_test.log_reg_ord,probAB.ordMan(:,1),1);
[rf.FPR.AB,rf.TPR.AB,rf.T,rf.AUC]=perfcurve(y_test.rf,probAB.rf(:,1),1);
[rfMan.FPR.AB,rfMan.TPR.AB,rfMan.T,rfMan.AUC]=perfcurve(y_test.rf,probAB.rfMan(:,1),1);
[knn.FPR.AB,knn.TPR.AB,knn.T,knn.AUC]=perfcurve(y_test.knn,probAB.knn(:,1),1);
[knnMan.FPR.AB,knnMan.TPR.AB,knnMan.T,knnMan.AUC]=perfcurve(y_test.knn,probAB.knnMan(:,1),1);

% figure;
% plot(nom.FPR.AB,nom.TPR.AB,'b');
% hold on
% plot(nomMan.FPR.AB,nomMan.TPR.AB,':b');
% plot(ord.FPR.AB,ord.TPR.AB,'m');
% plot(ordMan.FPR.AB,ordMan.TPR.AB,':m');
% plot(rf.FPR.AB,rf.TPR.AB,'g');
% plot(rfMan.FPR.AB,rfMan.TPR.AB,':g');
% plot(knn.FPR.AB,knn.TPR.AB,'r');
% plot(knnMan.FPR.AB,knnMan.TPR.AB,':r');
% title('ROC A&B vs All')
% ylabel('TPR')
% xlabel('FPR')
% legend('Nominal Logistic Regression SFS','Nominal Logistic Regression MAN',...
%     'Ordinal Logistic Regression SFS','Ordinal Logistic Regression MAN',...
%     'Random Forest SFS','Random Forest MAN',...
%     'KNN SFS','KNN MAN','Location','eastoutside')
% 
% %C1C2

[nom.FPR.C1C2,nom.TPR.C1C2,nom.T,nom.AUC]=perfcurve(y_test.log_reg_nom,probC1C2.nom(:,2),1);
[nomMan.FPR.C1C2,nomMan.TPR.C1C2,nomMan.T,nomMan.AUC]=perfcurve(y_test.log_reg_nom,probC1C2.nomMan(:,2),1);
[ord.FPR.C1C2,ord.TPR.C1C2,ord.T,ord.AUC]=perfcurve(y_test.log_reg_ord,probC1C2.ord(:,2),1);
[ordMan.FPR.C1C2,ordMan.TPR.C1C2,ordMan.T,ordMan.AUC]=perfcurve(y_test.log_reg_ord,probC1C2.ordMan(:,2),1);
[rf.FPR.C1C2,rf.TPR.C1C2,rf.T,rf.AUC]=perfcurve(y_test.rf,probC1C2.rf(:,2),1);
[rfMan.FPR.C1C2,rfMan.TPR.C1C2,rfMan.T,rfMan.AUC]=perfcurve(y_test.rf,probC1C2.rfMan(:,2),1);
[knn.FPR.C1C2,knn.TPR.C1C2,knn.T,knn.AUC]=perfcurve(y_test.knn,probC1C2.knn(:,2),1);
[knnMan.FPR.C1C2,knnMan.TPR.C1C2,knnMan.T,knnMan.AUC]=perfcurve(y_test.knn,probC1C2.knnMan(:,2),1);

%DE

[nom.FPR.DE,nom.TPR.DE,nom.T,nom.AUC]=perfcurve(y_test.log_reg_nom,probDE.nom(:,2),1);
[nomMan.FPR.DE,nomMan.TPR.DE,nomMan.T,nomMan.AUC]=perfcurve(y_test.log_reg_nom,probDE.nomMan(:,2),1);
[ord.FPR.DE,ord.TPR.DE,ord.T,ord.AUC]=perfcurve(y_test.log_reg_ord,probDE.ord(:,2),1);
[ordMan.FPR.DE,ordMan.TPR.DE,ordMan.T,ordMan.AUC]=perfcurve(y_test.log_reg_ord,probDE.ordMan(:,2),1);
[rf.FPR.DE,rf.TPR.DE,rf.T,rf.AUC]=perfcurve(y_test.rf,probDE.rf(:,2),1);
[rfMan.FPR.DE,rfMan.TPR.DE,rfMan.T,rfMan.AUC]=perfcurve(y_test.rf,probDE.rfMan(:,2),1);
[knn.FPR.DE,knn.TPR.DE,knn.T,knn.AUC]=perfcurve(y_test.knn,probDE.knn(:,2),1);
[knnMan.FPR.DE,knnMan.TPR.DE,knnMan.T,knnMan.AUC]=perfcurve(y_test.knn,probDE.knnMan(:,2),1);
figure;

%AB-SFS
subplot(4,2,3)
p1=plot(nom.FPR.AB,nom.TPR.AB,'blue');
hold on
p2=plot(ord.FPR.AB,ord.TPR.AB,'m');
p3=plot(rf.FPR.AB,rf.TPR.AB,'green');
p4=plot(knn.FPR.AB,knn.TPR.AB,'red');
p5=plot([0:0.1:1],[0:0.1:1],'black');
title('SFS ROC A&B vs All')
ylabel('TPR')
xlabel('FPR')
%AB_MAN
subplot(4,2,4)
plot(nomMan.FPR.AB,nomMan.TPR.AB,'blue');
hold on
plot(ordMan.FPR.AB,ordMan.TPR.AB,'m');
plot(rfMan.FPR.AB,rfMan.TPR.AB,'green');
plot(knnMan.FPR.AB,knnMan.TPR.AB,'red');
plot([0:0.1:1],[0:0.1:1],'black')
title('MAN ROC A&B vs All')
ylabel('TPR')
xlabel('FPR')
%C1C2-SFS
subplot(4,2,5)
p1=plot(nom.FPR.C1C2,nom.TPR.C1C2,'blue');
hold on
p2=plot(ord.FPR.C1C2,ord.TPR.C1C2,'m');
p3=plot(rf.FPR.C1C2,rf.TPR.C1C2,'green');
p4=plot(knn.FPR.C1C2,knn.TPR.C1C2,'red');
p5=plot([0:0.1:1],[0:0.1:1],'black');
title('SFS ROC C1&C2 vs All')
ylabel('TPR')
xlabel('FPR')
%C1C2-MAN
subplot(4,2,6)
pa=plot(nomMan.FPR.C1C2,nomMan.TPR.C1C2,'b');
hold on
plot(ordMan.FPR.C1C2,ordMan.TPR.C1C2,'m');
plot(rfMan.FPR.C1C2,rfMan.TPR.C1C2,'g');
plot(knnMan.FPR.C1C2,knnMan.TPR.C1C2,'r');
plot([0:0.1:1],[0:0.1:1],'black');
title('MAN ROC C1&C2 vs All')
ylabel('TPR')
xlabel('FPR')
subplot(4,2,7)
p1=plot(nom.FPR.DE,nom.TPR.DE,'blue');
hold on
p2=plot(ord.FPR.DE,ord.TPR.DE,'m');
p3=plot(rf.FPR.DE,rf.TPR.DE,'green');
p4=plot(knn.FPR.DE,knn.TPR.DE,'red');
p5=plot([0:0.1:1],[0:0.1:1],'black');
title('SFS ROC A&B vs All')
ylabel('TPR')
xlabel('FPR')
%DE_MAN
subplot(4,2,8)
p1=plot(nomMan.FPR.DE,nomMan.TPR.DE,'blue');
hold on
p2=plot(ordMan.FPR.DE,ordMan.TPR.DE,'m');
p3=plot(rfMan.FPR.DE,rfMan.TPR.DE,'green');
p4=plot(knnMan.FPR.DE,knnMan.TPR.DE,'red');
p5=plot([0:0.1:1],[0:0.1:1],'black');
title('MAN ROC D&E vs All')
ylabel('TPR')
xlabel('FPR')

pl=subplot(4,2,[1,2]);
axis off
pp=get(pl,'position');
hL = legend([p1,p2,p3,p4,p5],{'Nominal LR','Ordinal LR','Random Forest','KNN','Randon Guess'},'Orientation','horizontal');
%legend([p1,p2,p3,p4,p5],{'Nominal Logistic Regression','Ordinal Logistic Regression','Random Forest','KNN','Randon Guess'},'Orientation','horizontal')
%linkaxes([p1,pa])
newPosition = [0.9 0.4 0.2 0.2];
%newUnits = 'normalized';
set(hL,'Position', pp);
%delete(pl)


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



    