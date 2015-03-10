
function x=compositeFeatures(varargin)
    x.all=[];
    x.child=[];
    x.noChild=[];
    for i=1:length(varargin)
        x.all=[x.all varargin{i}.all];
        x.child=[x.child varargin{i}.child];
        x.noChild=[x.noChild varargin{i}.noChild];
    end
    
    %threeSTD=3*std(x.all)
    
%     for i=1:size(x.all,2)
%         outliers.all=x.all(:,i)>3*std(x.all(:,i));
%         x.all(outliers.all,i)=NaN;
%         outliers.child=x.child(:,i)>3*std(x.child(:,i));
%         x.all(outliers.child,i)=NaN;
%         outliers.noChild=x.noChild(:,i)>3*std(x.noChild(:,i));
%         x.all(outliers.noChild,i)=NaN;
%     end
        
    
end