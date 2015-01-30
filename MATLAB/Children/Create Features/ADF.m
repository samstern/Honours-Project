% Take the fourier transform of each day seperately, then average values
% for each day of the week
function [fourier_features,fisher_scores] = ADF(numhouse,x,children_filtered)
    x_ADF=zeros(numhouse,1008);
    size(x,1);
    for i=1:numhouse
        x_temp=zeros(7,144);
        x_day=fft_day(x(i,:));
        day=1;
        for k=1:28
            x_temp(day,:)=x_temp(day,:)+x_day(k,:);
            day=day+1;
            if day==8
                day=1;
            end
        end
        x_ADF(i,:)=reshape(x_temp',[1,1008]);
    end
    x_ADF=x_ADF/4;
    
    fisher_scores = fsFisher(x_ADF',children_filtered.all)
    numFeatures=100;
    fList=fisher_scores.fList(1:numFeatures);
    fourier_features.all=zeros(numhouse,numFeatures);
    fourier_features.children=zeros(children_filtered.numChild,numFeatures);
    fourier_features.noChildren=zeros(children_filtered.numNoChild,numFeatures);
    j=1;
    k=1;
    for i=1:numhouse
        fourier_features.all(i,:)=x_ADF(i,fList);
    end
    
end

function out=fft_day(in)
    cutoff=0;
    out=zeros(28,144);
   for j =1:28
       out(j,:)=real(fft(in(cutoff+1:cutoff+144)));
       cutoff=cutoff+144;
   end
end
