dbConnect;
data=import4WeekData(dbConn);

lengths = zeros(length(data),1);

for i = 1:length(data)
    lengths(i)=length(data{i});
end

x_length = min(lengths);

x_data = zeros(length(data),x_length);

for i = 1:length(data)
    x_data(i,:) = cell2mat(data{i}(1:x_length,3));
end

%convert to wats
x_data=x_data.*0.6;

%create time series for plotting
a = x_data(1,:);
b = dataToDates(data,1);
ts = timeseries(a,b);
for i = 1:min(size(x_data))
    ts(i) = timeseries(x_data(i,:),dataToDates(data,i));
end



