function [B,Y,conf]=randomForrest(x_train,x_test,y_train,y_test,task)
    NTrees=13;
    B = TreeBagger(NTrees,x_train,y_train,'FBoot',0.5,'OOBPred','On');
    Y = str2num(cell2mat(predict(B,x_test)));
    
    sum(Y==y_test)/length(y_test)
    
    conf=confusionmat(y_test,Y);
    
    if task==('c'||'child'||'children')
        [x,y] = perfcurve(y_test,Y,1);
        plot(x,y)
    end
    
end