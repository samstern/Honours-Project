
% X are the instances
% Y are the class labels
% k is the number of neighbors
%k = 10;

for k = 1:10
    indices = crossvalind('Kfold',Y,10);
    cp = classperf(Y); % initializes the CP object
    for i = 1:10
        test = (indices == i);
        train = ~test;
        class = knnclassify(X(test,:),X(train,:),Y(train),k);
        % updates the CP object with the current classification results
        classperf(cp,class,test);  
    end
CorrectRate = cp.CorrectRate; % queries for the correct classification rate
ErrorRate = cp.ErrorRate;
CountingMatrix = cp.CountingMatrix;
InconclusiveRate = cp.InconclusiveRate; %Nonclassified SAmples/ total number of samples
Sensitivity = cp.Sensitivity; % correctly classified Positive smaples/ True Positive Samples
Specificity = cp.Specificity; % correctly classified Negative samples/ true negative samples
PositivePredictiveValue = cp.PositivePredictiveValue; %Correctly Classified Positive Samples / Positive Classified Samples
NegativePredictiveValue = cp.NegativePredictiveValue; %Correctly Classified Negative Samples / Negative Classified Samples


disp('Number of neighbors')
disp(k)
disp('Correct Rate')
disp(CorrectRate)
disp('Error Rate')
disp(ErrorRate)
disp(CountingMatrix)
disp('InconclusveRate')
disp(InconclusiveRate)
disp('Sensitivity')
disp(Sensitivity)
disp('Specificity')
disp(Specificity)
disp('PositivePredictiveValue')
disp(PositivePredictiveValue)
disp('NegativePredictiveValue')
disp(NegativePredictiveValue)
end