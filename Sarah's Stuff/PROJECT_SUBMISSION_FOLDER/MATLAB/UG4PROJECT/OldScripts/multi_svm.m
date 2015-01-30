
% X are the instances
% Y are the class labels
% k is the number of neighbors
k = 10;

indices = crossvalind('Kfold',Y,10);
cp = classperf(Y); % initializes the CP object
for i = 1:10
    test = (indices == i); train = ~test;
    results = multisvm(X(train,:),Y(train),X(test,:));
    % updates the CP object with the current classification results
    disp(results)
end
