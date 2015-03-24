function log_reg=runLogReg(x_train,x_test,y_train,y_test,task)

%k=10;
mdl = fitLogReg(x_train,x_test,y_train,task);
evaluated = evalLogRed(mdl,x_test,task);
log_reg.b =mdl.Coefficients.Estimate;
log_reg.yhat =evaluated.yhat;
log_reg.score=evaluated.predProb;
%log_reg.loss=loss(mdl,x_test,y_test);
log_reg.confusion = confusionmat(y_test,log_reg.yhat);
log_reg.accuracy=sum(diag(log_reg.confusion))/sum(sum(log_reg.confusion));
log_reg.SSE=mdl.SSE;
temp=num2cell(log_reg.confusion(:));
[log_reg.TP,log_reg.FP, log_reg.FN, log_reg.TP]=temp{:};
end

function mdl=fitLogReg(x_train,x_test,y_train,task)
    if sum(strcmp(task,{'child','children','c'}))
        %[fitted.b,fitted.dev,fitted.stats] = glmfit(x_train,y_train,'binomial','link','logit'); % Logistic regression
        mdl=fitglm(x_train,y_train,'distribution','binomial','link','logit');
    elseif sum(strcmp(task,{'nominal','n','nom'}))
        %mdl=fitglm(x_train,y_train,'Ordinal',([1,2,3,4,5,6]));
        [mdl.Coefficients.Estimate,mdl.SSE,mdl.stats] = mnrfit(x_train,y_train,'model','nominal'); % Logistic regression
        %mdl.SSE=mdl.dev;
    else
        [mdl.Coefficients.Estimate,mdl.SSE,mdl.stats] = mnrfit(x_train,y_train,'model','ordinal'); % Logistic regression
    end
end

function log_reg=evalLogRed(mdl,x_test,task)
     if sum(strcmp(task,{'child','children','c'}))
        %log_reg.predProb = glmval(fitted.b,x_test,'logit');
        %log_reg.yhat=round(log_reg.predProb(:,1))';
        log_reg.predProb=feval(mdl,x_test);
        log_reg.yhat=round(log_reg.predProb);
     elseif sum(strcmp(task,{'nominal','n','nom'}))
        log_reg.predProb = mnrval(mdl.Coefficients.Estimate,x_test,'model','nominal');
        [m_prob,log_reg.yhat]= max(log_reg.predProb');
        %log_reg.predProb=feval(mdl,x_test);
        %log_reg.yhat=round(log_reg.predProb);
     else 
         log_reg.predProb = mnrval(mdl.Coefficients.Estimate,x_test,'model','ordinal');
         [m_prob,log_reg.yhat]= max(log_reg.predProb');
     end
end
