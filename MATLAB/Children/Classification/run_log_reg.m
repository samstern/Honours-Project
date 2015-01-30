function run_log_reg(x_train,x_test,y_train,y_test)

[b,dev,stats] = mnrfit(x_train,y_train,'model','nominal','interactions','on'); % Logistic regression
pihat = mnrval(b,x_test,'model','nominal');

y_hat=round(pihat(:,1));

count=0;
for i=1:length(y_hat)
    if y_hat(i)==y_test(i)
        count=count+1;
    end
end
count/length(y_hat)
end