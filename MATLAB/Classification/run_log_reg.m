function y_hat=run_log_reg(x_train,x_test,y_train,y_test,task)

    if strmatch(task,{'child','children','c'},'exact')~=0
        y_test=y_test+1;
        y_train=y_train+1;
    end
    
    [b,dev,stats] = mnrfit(x_train,y_train,'model','nominal'); % Logistic regression
    pihat = mnrval(b,x_test,'model','nominal');

    [m_prob,y_hat]= max(pihat');

    %y_hat=round(pihat(:,1));

    %count=0;
    accuracy=sum(y_test.class==y_hat')/length(y_test)
    accuracyPlusMinusOne=(sum(y_test.class==y_hat')+sum(y_test.class==y_hat'+1)+sum(y_test.class==y_hat'-1))/length(y_test)

    if strmatch(task,{'child','children','c'},'exact')~=0
        TP=sum(y_hat'==2 & y_hat'==y_test);
        TN=sum(y_hat'==1 & y_hat'==y_test);
        FP=sum(y_hat'==2 & y_hat'~=y_test);
        FN=sum(y_hat'==1 & y_hat'~=y_test);

        precision=TP/(TP+FP)
        recall=TP/(TP+FN)
    end

end
% for i=1:length(y_hat)
%     if y_hat(i)==y_test(i)
%         count=count+1;
%     end
% end
% count/length(y_hat)
% end