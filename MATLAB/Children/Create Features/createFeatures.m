load('data/children.mat')
load('data/social_grade.mat')
social_grade.unfiltered=social_grade;
social_grade.ints=socialGradeToInts(social_grade.unfiltered);
load('data/x_data_4_weeks.mat')
%% Removing outliers

means=mean(mean(x_data'));
std3=3*std(mean(x_data'));
outliers=[42;43]; %42 and 42 are empty
numOutliers=2;
%find the other outliers
for i=1:529
    if means+std3<mean(x_data(i,:))||means-std3>mean(x_data(i,:))||social_grade.ints(i)==0
        outliers=cat(1,outliers,i);
        numOutliers=numOutliers+1;
    end
end

[numhouse_data,numpts]=size(x_data); % number of houses and number of readings for the 28 days
x_filtered=zeros(numhouse_data-numOutliers,numpts);
children_filtered.all=rand(length(children)-numOutliers,1);
social_grade.all=rand(length(children)-numOutliers,1);
[numhouse,numpts]=size(x_filtered);
j=1;
for i=1:numhouse_data
    if isempty(find(outliers==i,1))
        x_filtered(j,:)=x_data(i,:);
        children_filtered.all(j)=children(i);
        social_grade.all(j)=social_grade.ints(i);
        j=j+1;
    end
        
end

%% Define global variables

daylength=144; % number of readings in a day
children_filtered.numChild = sum(children_filtered.all ==1); % number of househlds with children
children_filtered.numNoChild=sum(children_filtered.all ~=1);

social_grade.numE=sum(social_grade.all ==1);
social_grade.numD=sum(social_grade.all ==2);
social_grade.numC2=sum(social_grade.all ==3);
social_grade.numC1=sum(social_grade.all ==4);
social_grade.numB=sum(social_grade.all ==5);
social_grade.numA=sum(social_grade.all ==6);


%numNoChild=length(children_filtered)-numChild; % number of households without children
%% Total energy used each household

monthSum=total_energy(numhouse,x_filtered,children_filtered.all,social_grade.all);



%% Average total usage for each day of the week

dayAverages = ATDOW(numhouse,daylength,numpts,x_filtered,children_filtered,social_grade);


%% Create part-of-day features

[x_POD,numPOD]=POD(numhouse,x_filtered);

%% Average part-of-day for each day of the week

x_APOD=APOD(numhouse,x_POD,children_filtered);

%% Average Day Fourier

%x_ADF = ADF(numhouse,x_filtered,children_filtered);
%% Part_of_Day/average total daily usage ratio

%pod_atd_ratio=POD_ATDOW_ratio(numhouse,x_POD,numPOD,dayAverages);


%% Splitting to child vs no child households
% 
% 
% 
% c_POD = zeros(children_filtered.numChild,numPOD);
% c_less_POD = zeros(children_filtered.numNoChild, numPOD);
% c_ratio = zeros(children_filtered.numChild,numPOD);
% c_less_ratio = zeros(children_filtered.numNoChild,numPOD);
% 
% j=1;
% k=1;
% for i= 1:numhouse
%     if children_filtered.all(i)==1
%         c_POD(j,:)=x_POD(i,:);
%         c_ratio(j,:)=pod_atd_ratio(i,:);
%         j=j+1;
%     elseif children_filtered.all(i)==0
%         c_less_POD(k,:)=x_POD(i,:);
%         c_less_ratio(k,:)=pod_atd_ratio(i,:);
%         k=k+1;
%     end
% end
% 
% 
% c_morn_pod = [];
% c_less_morn_pod = [];
% c_aft_pod = [];
% c_less_aft_pod = [];
% c_eve_pod = [];
% c_less_eve_pod = [];
% c_night_pod = [];
% c_less_night_pod = [];
% 
% c_morn_ratio = [];
% c_less_morn_ratio = [];
% c_aft_ratio = [];
% c_less_aft_ratio = [];
% c_eve_ratio = [];
% c_less_eve_ratio = [];
% c_night_ratio = [];
% c_less_night_ratio = [];
% 
% for i = 1:max(size(c_POD))
%    for j= 1:min(size(c_POD))
%       if mod(j,4)==1
%          c_morn_pod = cat(1,c_morn_pod,c_POD(i,j));
%          c_morn_ratio = cat(1,c_morn_ratio, c_ratio(i,j));
%       elseif mod(j,4)==2
%           c_aft_pod = cat(1,c_aft_pod, c_POD(i,j));
%           c_aft_ratio = cat(1,c_aft_ratio,c_ratio(i,j));
%       elseif mod(j,4)==3
%           c_eve_pod = cat(1,c_eve_pod,c_POD(i,j));
%           c_eve_ratio = cat(1,c_eve_ratio,c_ratio(i,j));
%       else
%           c_night_pod = cat(1, c_night_pod, c_POD(i,j));
%           c_night_ratio = cat(1,c_night_ratio, c_ratio(i,j));
%       end
%    end
% end
% 
% for i = 1:max(size(c_less_POD))
%    for j= 1:min(size(c_less_POD))
%       if mod(j,4)==1
%          c_less_morn_pod = cat(1,c_less_morn_pod,c_less_POD(i,j));
%          c_less_morn_ratio = cat(1,c_less_morn_ratio, c_less_ratio(i,j));
%       elseif mod(j,4)==2
%           c_less_aft_pod = cat(1,c_less_aft_pod, c_less_POD(i,j));
%           c_less_aft_ratio = cat(1,c_less_aft_ratio, c_less_ratio(i,j));
%       elseif mod(j,4)==3
%           c_less_eve_pod = cat(1,c_less_eve_pod,c_less_POD(i,j));
%           c_less_eve_ratio = cat(1,c_less_eve_ratio, c_less_ratio(i,j));
%       else
%           c_less_night_pod = cat(1, c_less_night_pod, c_less_POD(i,j));
%           c_less_night_ratio = cat(1,c_less_night_ratio, c_less_ratio(i,j));
%       end
%    end
% end
%% Clearning unnecesarry variables
clear i j k numhouse_data x divNum means std3 outliers numOutliers %numpts daylength