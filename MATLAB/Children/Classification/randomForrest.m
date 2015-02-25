function [B,Y]=randomForrest(x_train,x_test,y_train,y_test,task)
    NTrees=13;
    B = TreeBagger(NTrees,x_train,y_train,'FBoot',0.5,'OOBPred','On');
    Y = str2num(cell2mat(predict(B,x_test)));
    
    sum(Y==y_test)/length(y_test)
    
    confusionmat(y_test,Y)
    
end