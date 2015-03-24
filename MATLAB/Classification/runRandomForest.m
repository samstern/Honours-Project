function rf=runRandomForest(x_train,x_test,y_train,y_test,task)
    NTrees=13;
    rf.B = TreeBagger(NTrees,x_train,y_train,'FBoot',0.5,'OOBPred','On');
    [rf.yhat,rf.score,rf.stdevs]= predict(rf.B,x_test);
    rf.yhat =str2num(cell2mat(rf.yhat));
    rf.confusion=confusionmat(y_test,rf.yhat);
    rf.accuracy=sum(diag(rf.confusion))/sum(sum(rf.confusion));
    temp=num2cell(rf.confusion(:));
    rf.err=error(rf.B,x_test,y_test,'mode','ensemble');
    [rf.TP,rf.FP, rf.FN, rf.TP]=temp{:};
    rf.missRate=(rf.FP+rf.FN)/sum(sum(rf.confusion));
    rf.meanOOBError=mean(rf.B.oobError);

    
end