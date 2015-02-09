function pihat=glm_log_reg(x_train,x_test,y_train,y_test,task)

    if strmatch(task,{'child','children','c'},'exact')~=0
        %y_test=y_test+1;
        %y_train=y_train+1;
    end
    
    [b,dev,stats] = glmfit(x_train,y_train,'binomial','link','logit'); % Logistic regression
    pihat = glmval(b,x_test,'logit');

    %[m_prob,y_hat]= max(pihat');

    y_hat=round(pihat(:,1))';

    %count=0;

    accuracy=sum(y_test==y_hat')/length(y_test)

    if strmatch(task,{'child','children','c'},'exact')~=0
        TP=sum(y_hat'==0 & y_hat'==y_test);
        TN=sum(y_hat'==1 & y_hat'==y_test);
        FP=sum(y_hat'==0 & y_hat'~=y_test);
        FN=sum(y_hat'==1 & y_hat'~=y_test);

        precision=TP/(TP+FP)
        recall=TP/(TP+FN)
    end

end