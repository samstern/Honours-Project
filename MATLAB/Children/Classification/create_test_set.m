function [x_test,x_train,y_test,y_train]=create_test_set(numhouse,x_data,y_data)
x_data_size = size(x_data);
testHouseholds=randsample(numhouse,round(numhouse/5));
length(testHouseholds);
x_test=zeros(length(testHouseholds),x_data_size(2));
x_train = zeros(x_data_size(1)-length(testHouseholds),x_data_size(2));
y_test=zeros(length(testHouseholds),1);
y_train=zeros(x_data_size(1)-length(testHouseholds),1);

j=1;
k=1;
for i=1:numhouse
    if isempty(find(testHouseholds==i, 1))
        x_train(j,:)=x_data(i,:);
        y_train(j)=y_data(i);
        j=j+1;
    else
        x_test(k,:)=x_data(i,:);
        y_test(k)=y_data(i);
        k=k+1;
    end
end
