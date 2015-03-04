function [fourier_features]=fourierFeatures(x,children_filtered,social_grade)
x_ft = fft(x')';
numhouse= size(x,1);
fisher_scores = fsFisher(x_ft',children_filtered.all);
numFeatures=10;
fList=fisher_scores.fList(1:numFeatures);
fisher_scores.W;

fourier_features.all=bestEnergy(x_ft);
[fourier_features.child,fourier_features.noChild]=split_children(numhouse,fourier_features,children_filtered);
[fourier_features.a,fourier_features.b,fourier_features.c1,fourier_features.c2,fourier_features.d,fourier_features.e]=split_se(numhouse,fourier_features,social_grade);

end
    
function out=bestEnergy(x)
    squared=x.^2;
    meaned=mean(squared);
    [b ix] = sort( meaned, 'descend' );
    out= real(x(:,ix(1:5)));
end

function [xc,xnc]=split_children(numhouse,x,children_filtered)
    xc=[];
    xnc=[];
    for i= 1:numhouse
        if children_filtered.all(i)==0
            xnc=[xnc;x.all(i,:)];
        elseif children_filtered.all(i)==1
            xc=[xc;x.all(i,:)];
        end
    end
end

function [xa,xb,xc1,xc2,xd,xe]=split_se(numhouse,x,social_grade)
    xa=[];
    xb=[];
    xc1=[];
    xc2=[];
    xd=[];
    xe=[];
    
    for i=1:numhouse
        if social_grade.all(i)==1
            xe=[xe;x.all(i,:)];
        elseif social_grade.all(i)==2
            xd=[xd;x.all(i,:)];
        elseif social_grade.all(i)==3
            xc2=[xc2;x.all(i,:)];
        elseif social_grade.all(i)==4
            xc1=[xc1;x.all(i,:)];
        elseif social_grade.all(i)==5
            xb=[xb;x.all(i,:)];
        elseif social_grade.all(i)==6
            xa=[xa;x.all(i,:)];
        end
    end
    
end
%t_score = fsTtest(x_ft',children_filtered);