
%# split training/testing sets
[trainIdx testIdx] = crossvalind('HoldOut', Y, 1/3);

numOfClasses = 6;

pairwise = nchoosek(1:numOfClasses,2);            %# 1-vs-1 pairwise models
svmModel = cell(size(pairwise,1),1);            %# store binary-classifers
predTest = zeros(sum(testIdx),numel(svmModel)); %# store binary predictions

%# classify using one-against-one approach
for k=1:numel(svmModel)
    %# get only training instances belonging to this pair
    idx = trainIdx & any( bsxfun(@eq, Y, pairwise(k,:)) , 2 );

    %# train
    
    %svmModel{k} = svmtrain(X(idx,:), Y(idx), ...
    %    'BoxConstraint',2e-1, 'Kernel_Function','quadratic');
    
    svmModel{k} = svmtrain(X(idx,:), Y(idx), ...
                 'Autoscale',true, 'Showplot',false, 'Method','QP', ...
                 'BoxConstraint',2e-1, 'Kernel_Function','rbf', 'RBF_Sigma',1);

    %# test
    predTest(:,k) = svmclassify(svmModel{k}, X(testIdx,:));
end
pred = mode(predTest,2);   %# voting: clasify as the class receiving most votes

%# performance
cmat = confusionmat(Y(testIdx),pred);
acc = 100*sum(diag(cmat))./sum(cmat(:));
fprintf('SVM (1-against-1):\naccuracy = %.2f%%\n', acc);
fprintf('Confusion Matrix:\n'), disp(cmat)