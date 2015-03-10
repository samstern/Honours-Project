
function x=compositeFeatures(varargin)
    x.all=[];
    x.child=[];
    x.noChild=[];
    x.e=[];
    x.d=[];
    x.c2=[];
    x.c1=[];
    x.b=[];
    x.a=[];
    for i=1:length(varargin)
        x.all=[x.all varargin{i}.all];
        
        x.child=[x.child varargin{i}.child];
        x.noChild=[x.noChild varargin{i}.noChild];
        
        x.e=[x.e varargin{i}.e];
        x.d=[x.d varargin{i}.d];
        x.c2=[x.c2 varargin{i}.c2];
        x.c1=[x.c1 varargin{i}.c1];
        x.b=[x.b varargin{i}.b];
        x.a=[x.a varargin{i}.a];
        
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