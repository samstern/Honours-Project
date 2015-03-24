%Use sequential feature selection to find the best features to perform
%classification
function x_opt = selectFeatures(x,y,task,numfeatures,classifier)
    ys=y.all;
    xs=x.all;
    c = cvpartition(y.all,'k',5);
    opts = statset('display','iter','TolTypeFun','abs');
    fun = @(XT,yT,Xt,yt)(sum(~strcmp(yt,classify(Xt,XT,yT))));
    funKnn = @(x_tst,y_tst,x_trn,y_trn)(getfield(runKNN(x_trn,x_tst,y_trn,y_tst),'loss'));
    funRF = @(x_tst,y_tst,x_trn,y_trn)(getfield(runRandomForest(x_trn,x_tst,y_trn,y_tst),'err'));
    funLR_child = @(x_tst,y_tst,x_trn,y_trn)(getfield(runLogReg(x_trn,x_tst,y_trn,y_tst,task),'SSE'));
    funLR_se = @(x_tst,y_tst,x_trn,y_trn)(getfield(runLogReg(x_trn,x_tst,y_trn,y_tst,task),'SSE'));
    if strmatch(task,{'child','children','c'},'exact')
        if strcmp(classifier,'log_reg')
            [fs,history] = sequentialfs(funLR_child,x.all,y.all,'options',opts,'cv',c,'nfeatures',numfeatures);
        elseif strcmp(classifier,'knn')
            [fs,history] = sequentialfs(funKnn,x.all,y.all,'options',opts,'cv',c,'nfeatures',numfeatures);
        elseif strcmp(classifier,'rf')
            [fs,history] = sequentialfs(funRF,x.all,y.all,'options',opts,'cv',c,'nfeatures',numfeatures);
        end
    else
        if strcmp(classifier,'log_reg')
            [fs,history] = sequentialfs(funLR_se,x.all,y.all,'options',opts,'cv',c,'nfeatures',numfeatures);
        elseif strcmp(classifier,'knn')            
            [fs,history] = sequentialfs(funKnn,x.all,y.all,'options',opts,'cv',c,'nfeatures',numfeatures);
        elseif strcmp(classifier,'rf')
            [fs,history] = sequentialfs(funRF,x.all,y.all,'options',opts,'cv',c,'nfeatures',numfeatures);
        end
    end
    
    x_opt.indecies=find(fs);
    
    x_opt.all=x.all(:,x_opt.indecies);
    %x_opt.child=x.child(:,indecies);
   %x_opt.noChild=x.noChild(:,indecies);
    
end

function dev = critfunC(X,Y)
    mdl=fitglm(X,Y,'distribution','binomial','link','logit');
    dev=mdl.SSE;
    
    %[b,dev] = glmfit(X,Y,'binomial'); 
  
end

function dev = critfunSE(X,Y)

[b,dev,stats] = mnrfit(X,Y,'model','ordinal');

end