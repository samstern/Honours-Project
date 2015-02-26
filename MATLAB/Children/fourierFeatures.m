function [fourier_features]=fourierFeatures(x,children_filtered)
x_ft = abs(fft(x'))';
numhouse= size(x,1);
fisher_scores = fsFisher(x_ft',children_filtered.all);
numFeatures=10;
fList=fisher_scores.fList(1:numFeatures);
fourier_features.all=zeros(numhouse,numFeatures);
fourier_features.children=zeros(children_filtered.numChild,numFeatures);
fourier_features.noChildren=zeros(children_filtered.numNoChild,numFeatures);
j=1;
k=1;
for i=1:numhouse
    fourier_features.all(i,:)=x_ft(i,fList);
    if children_filtered.all(i)==1
        fourier_features.children(j,:)=x_ft(i,fList);
        j=j+1;
    else
        fourier_features.noChildren(k,:)=x_ft(i,fList);
        k=k+1;
    end
end
    

%t_score = fsTtest(x_ft',children_filtered);