%% Create part-of-day features

function [x_POD,numPOD]=POD(numhouse,x_filtered)
    i=1;
    numPOD=111;
    x=zeros(1,numPOD);
    x(1)=37;
    while i < length(x)
        x(i+1)=x(i)+18;
        x(i+2)=x(i+1)+36;
        x(i+3)=x(i+2)+42;
        x(i+4)=x(i+3)+48;
        i=i+4;
    end
    x_POD=zeros(numhouse,numPOD);
    for i =1:numhouse
        k=1;
        for j=1:length(x)-2
            x_POD(i,k)=sum(x_filtered(i,x(j):x(j+1)-1));
            k=k+1;
        end
    end
end

