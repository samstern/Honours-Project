function err = classf(xtrain,ytrain,xtest,ytest)
         yfit = classify(xtest,xtrain,ytrain,'linear');
         err = sum(~strcmp(ytest,yfit));