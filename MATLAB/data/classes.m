occupancy = zeros(length(data),1);
children = zeros(length(data),1);
for i = 1:length(data)
    occupancy(i) = cell2mat(data{i}(1,7));
    children(i)=cell2mat(data{i}(1,8));
    social_grade(i)=cellstr(data{i}(1,9));
end
social_grade = social_grade';