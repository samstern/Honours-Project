%Use sequential feature selection to find the best features to perform
%classification
function x_opt = selectFeatures(x,y,task)
    ys=y.all;
    xs=x.all;
    c = cvpartition(y.all,'k',5);
    opts = statset('display','iter','TolTypeFun','abs');
    fun = @(XT,yT,Xt,yt)(sum(~strcmp(yt,classify(Xt,XT,yT))));
    numfeatures=18;
    if strmatch(task,{'child','children','c'},'exact')
        [fs,history] = sequentialfs(@critfunC,x.all,y.all,'options',opts,'cv','none','nfeatures',numfeatures);
    else
        [fs,history] = sequentialfs(@critfunSE,x.all,y.all,'options',opts,'cv','none','nfeatures',numfeatures);
    end
    
    indecies=find(fs);
    
    x_opt.all=x.all(:,indecies);
    %x_opt.child=x.child(:,indecies);
   %x_opt.noChild=x.noChild(:,indecies);
    
end

function dev = critfunC(X,Y)

    [b,dev] = glmfit(X,Y,'binomial'); 
  
end

function dev = critfunSE(X,Y)

[b,dev,stats] = mnrfit(X,Y,'model','ordinal');

end