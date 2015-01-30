monthly_data=importMonthlyData(dbConn);

lengths = zeros(length(monthly_data),1);

for i = 1:length(monthly_data)
    lengths(i)=length(monthly_data{i});
end

x_length = min(lengths);

x_raw = zeros(length(monthly_data),x_length);

for i = 1:length(monthly_data)
    x_raw(i,:) = cell2mat(monthly_data{i}(1:x_length,3));
end