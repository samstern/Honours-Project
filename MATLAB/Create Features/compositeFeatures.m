
function x=compositeFeatures(varargin)
    x=[];
    for i=1:length(varargin)
        x=[x varargin{i}];
    end
end