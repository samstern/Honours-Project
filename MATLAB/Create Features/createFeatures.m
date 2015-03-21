load('data/children.mat')
load('data/social_grade.mat')
social_grade.unfiltered=social_grade;
social_grade.ints=socialGradeToInts(social_grade.unfiltered);
load('data/x_data_4_weeks.mat')
%% Removing outliers



means=mean(mean(x_data'));
std3=3*std(mean(x_data'));
%outliers=[37;38;39;40;41;42;43;46;48;261;262;332]; %outliers found from visualising data
%outliers=[(37:42)'];
outliers=[42;43];
numOutliers=length(outliers);
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

%Convert from Watts to Watt Hours
%x_filtered=x_filtered.\6;

%%Gaussian Filter to smooth the data
g = gausswin(15);
g = g/sum(g);
for i=1:519
x_gauss(i,:)=conv(x_filtered(i,:),g,'same');
end

%correcting some of the data
children_filtered.all([24 90 271 368 438 191 366 143 74 422  336 210 82 298 444 513 374 395 277 391 395 417 449 427 430 434 202 187 178 34 406 488 509 30 479 209 376 386 30 190 214 441 442 445 19 31 31 15 86 87 104 188 335 468 489 13 14 16 17 88 140 211 102 412 308 362 311 303 376 315])=1;


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

x_APOD=APOD(numhouse,x_POD,children_filtered,social_grade);

%% Weekend to weekday ratio

x_POW_ratio=POW_rat(numhouse,monthSum,dayAverages,children_filtered,social_grade);

%% Average daily variance

x_ADV=ADV(numhouse,daylength,numpts,x_filtered,children_filtered,social_grade);

%% Average weekday correlation

x_corr=WC(numhouse,x_filtered,children_filtered,social_grade);

%% Fourier transform features

x_fourier=fourierFeatures(x_gauss,children_filtered,social_grade);

%% Average Day Fourier

%x_ADF = ADF(numhouse,x_filtered,children_filtered);
%% Part_of_Day/average total daily usage ratio

%pod_atd_ratio=POD_ATDOW_ratio(numhouse,x_POD,numPOD,dayAverages);

%% taking the log of some of the features as it resulted in normaly distributed data when usint qqplot

monthSum=structfun(@(x) log(x),monthSum,'UniformOutput',0);
dayAverages=structfun(@(x) log(x),dayAverages,'UniformOutput',0);
x_APOD=structfun(@(x) log(x),x_APOD,'UniformOutput',0);
x_ADV=structfun(@(x) log(x),x_ADV,'UniformOutput',0);
%% Clearning unnecesarry variables
clear i j k numhouse_data x divNum means std3 numOutliers %numpts daylength