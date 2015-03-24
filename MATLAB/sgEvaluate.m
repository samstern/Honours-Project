function sgEvaluate(log_reg,rf,knn,y_test)
acc=[log_reg.accuracy,rf.accuracy,knn.accuracy]%
acc1=[accuracyWithinN(log_reg,1),accuracyWithinN(rf,1),accuracyWithinN(knn,1)]%
acc2=[accuracyWithinN(log_reg,2),accuracyWithinN(rf,2),accuracyWithinN(knn,2)]%
probAB=[binarizeProb(log_reg,[5,6]),binarizeProb(rf,[5,6]),binarizeProb(knn,[5,6])];
probC1C2=[binarizeProb(log_reg,[3,4]),binarizeProb(rf,[3,4]),binarizeProb(knn,[3,4])];
probDE=[binarizeProb(log_reg,[1,2]),binarizeProb(rf,[1,2]),binarizeProb(knn,[1,2])];
[l,r,k]=perfCurve(probC1C2,y_test);
plot(r.FPR,r.TPR)
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

    