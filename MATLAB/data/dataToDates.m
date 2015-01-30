function [timeseries] = dataToDates(data,index)

dates = cellstr(data{index}(:,4));
days = zeros(length(dates),1);
months = zeros(length(dates),1);
years = zeros(length(dates),1);
seconds = zeros(length(dates),1);
hours = cell2mat(data{index}(:,5));
minutes = cell2mat(data{index}(:,6));
timeseries = zeros(length(dates),1);
for i = 1:length(dates)
   days(i,:) = str2double(dates{i}(9:10));
   months(i,:) = str2double(dates{i}(6:7));
   years(i,:) = str2double(dates{i}(1:4));
   timeseries(i) = datenum(years(i,:),months(i,:),days(i,:),hours(i,:),minutes(i,:),seconds(i,:));
end





