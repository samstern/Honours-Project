load('children.mat')
load('x_data_4_weeks.mat')

%% Removing outliers

[numhouse_data,numpts]=size(x_data); % number of houses and number of readings for the 28 days
x_filtered=zeros(numhouse_data-2,numpts);
children_filtered=rand(length(children)-2,1);
[numhouse,numpts]=size(x_filtered);
j=1;

for i=1:numhouse_data
    if ~or(i==42,i==43)
        x_filtered(j,:)=x_data(i,:);
        children_filtered(j)=children(i);
        j=j+1;
    end
        
end

%% Define global variables

daylength=144; % number of readings in a day
numChild = 0; % number of househlds with children
numNoChild=0;
for i=1:length(children_filtered)
    if children_filtered(i)==1
        numChild=numChild+1;
    else 
        numNoChild=numNoChild+1;
    end
end

monthSum=zeros(numhouse,1);
childMonthSum=zeros(numChild,1);
childlessMonthSum=zero(numNoChild,1);
dayAverages = zeros(numhouse,7);

%create part of day intervals
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
clear i

x_POD=zeros(numhouse,numPOD);

%% call functions
j=1;
k=1;
for i=1:numhouse
    monthSum(i)=total_energy(i);
    ave_total_energy()
    pod()
end
%% Total energy used each household
function monthSum = total_monthly_energy(i,x_filtered)
    monthSum=sum(x_filtered(i,:));
end
%monthSum=zeros(numhouse,1);


for i= 1:numhouse    
    if children_filtered(i)==1
        childMonthSum(j)=monthSum(i);
        j=j+1;
    elseif children_filtered(i)==0
            childlessMonthSum(k)=monthSum(i);
            k=k+1;
    else
        'children not 1 or 0'
    end
end

%% Average total usage for each day of the week

%dayAverages = zeros(numhouse,7);
for i = 1:numhouse
    m=1;
    for n=1:daylength:numpts
    dayAverages(i,m)=dayAverages(i,m)+sum(x_filtered(i,n:n+daylength-1));
    k=k+1;
        if k==8
            k=1;
        end
    end
end
dayAverages=dayAverages/daylength;
dayAveChild = zeros(numChild,7);
dayAveNoChild = zeros(numNoChild,7);
j=1;
k=1;
for i= 1:numhouse
    if children_filtered(i)==0
        dayAveNoChild(j,:)=dayAverages(i,:);
        j=j+1;
    elseif children_filtered(i)==1
        dayAveChild(k,:)=dayAverages(i,:);
        k=k+1;
    end
end

%% Create part-of-day features
% i=1;
% numPOD=111;
% x=zeros(1,numPOD);
% x(1)=37;
% while i < length(x)
%     x(i+1)=x(i)+18;
%     x(i+2)=x(i+1)+36;
%     x(i+3)=x(i+2)+42;
%     x(i+4)=x(i+3)+48;
%     i=i+4;
% end
% x_POD=zeros(numhouse,numPOD);
for i =1:numhouse
    k=1;
    for j=1:length(x)-2
        x_POD(i,k)=sum(x_filtered(i,x(j):x(j+1)-1));
        k=k+1;
    end
end

child_POD = zeros(numChild,numPOD);
childless_POD = zeros(numNoChild, numPOD);

j=1;
k=1;
for i= 1:numhouse
    if children_filtered(i)==1
        child_POD(j,:)=x_POD(i,:);
        j=j+1;
    elseif children_filtered(i)==0
        childless_POD(k,:)=x_POD(i,:);
        k=k+1;
    end
end


child_morning = [];
childless_morning = [];
child_afternoon = [];
childless_afternoon = [];
child_evening = [];
childless_evening = [];
child_night = [];
childless_night = [];

for i = 1:max(size(child_POD))
   for j= 1:min(size(child_POD))
      if mod(j,4)==1
         child_morning = cat(1,child_morning,child_POD(i,j));
      elseif mod(j,4)==2
          child_afternoon = cat(1,child_afternoon, child_POD(i,j));
      elseif mod(j,4)==3
          child_evening = cat(1,child_evening,child_POD(i,j));
      else
          child_night = cat(1, child_night, child_POD(i,j));
      end
   end
end

for i = 1:max(size(childless_POD))
   for j= 1:min(size(childless_POD))
      if mod(j,4)==1
         childless_morning = cat(1,childless_morning,childless_POD(i,j));
      elseif mod(j,4)==2
          childless_afternoon = cat(1,childless_afternoon, childless_POD(i,j));
      elseif mod(j,4)==3
          childless_evening = cat(1,childless_evening,childless_POD(i,j));
      else
          childless_night = cat(1, childless_night, childless_POD(i,j));
      end
   end
end

%% Part_of_Day/average total daily usage ratio


        
%% Clearning unnecesarry variables
clear i j k numhouse numhouse_data numpts daylength x