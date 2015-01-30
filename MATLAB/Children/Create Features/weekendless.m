function data = weekendless(numpts,daylength,x)
%remove weekends from filtered 10-min data
day=1; %start on a sunday
%data=x;
k=1;
for j=1:daylength:numpts
    if (day==1|day==7)
        %data(:,j:j+daylength-1)=[];
    else
        data(:,k:k+daylength-1)=x(:,j:j+daylength-1);
        k=k+daylength;
    end
    if day==7
        day=1;
    else
        day=day+1;
    end
end
