function B=randomForrest(x_train,x_test,y_train,y_test,task)
    NTrees=13;
    B = TreeBagger(NTrees,x_train,y_train,'FBoot',0.5,'OOBPred','On');
    Y = predict(B,x_test);
    
    sum(str2num(cell2mat(Y))==y_test)/length(y_test)
end