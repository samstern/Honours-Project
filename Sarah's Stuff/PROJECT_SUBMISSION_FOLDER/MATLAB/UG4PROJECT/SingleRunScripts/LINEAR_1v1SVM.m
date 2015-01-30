Best_F1_mu = 0;
Best_F1_M = 0;


Best_FPR_mu = 10;
Best_FPR_M = 10;

Best_Accuracy = 0;

F1_mu_k = 0;
F1_M_k = 0;
FPR_mu_k = 0;
FPR_M_k = 0;
Accuracy_k = 0;

F1_mu_gamma = 0;
F1_M_gamma = 0;
FPR_mu_gamma = 0;
FPR_M_gamma = 0;


Accuracy_gamma = 0;

%# split training/testing sets
cvFolds = crossvalind('Kfold', Y, 10);
cp = classperf(Y);

%for gamma = (2^15):(2^2):(2^3)
%for Cost = (2^-5):(2^2):(2^15)

    for Cost = linspace(10^(-5),(10^5),10)
        disp('Cost')
        disp(Cost)
        for i = 1:10
    
        testIdx = (cvFolds == i);
        trainIdx = ~testIdx;
    % Hard Coded number of classes
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
    
            % Need to increase number of iterations
            options = optimset('maxiter',10000);
            %options = svmsmoset('MaxIter',50000);
            % 'SMO','smo_opts'
            
            svmModel{k} = svmtrain(X(idx,:), Y(idx), ...
                 'Autoscale',true, 'Showplot',false, 'Method','QP','QUADPROG_OPTS',options, ...
                 'BoxConstraint',Cost, 'Kernel_Function','linear');

    %# test
            predTest(:,k) = svmclassify(svmModel{k}, X(testIdx,:));
        end
        pred = mode(predTest,2);   %# voting: clasify as the class receiving most votes
        cp = classperf(cp,pred,testIdx);
%# performance
    %cmat = confusionmat(Y(testIdx),pred);
    %acc = 100*sum(diag(cmat))./sum(cmat(:));
    %fprintf('SVM (1-against-1):\naccuracy = %.2f%%\n', acc);
    %fprintf('Confusion Matrix:\n'), disp(cmat)
    
        end

    Accuracy = cp.CorrectRate;

    ConfMat = cp.CountingMatrix;
    ConfMat(7,:) = [];

    [l,p] = size(ConfMat);
        
    tp = zeros(1,p);
    tn = zeros(1,p);
        
    fp = zeros(1,p);
    fn = zeros(1,p);
        
    for i =1:l
        tp(i) = ConfMat(i,i);
        fn(i) = sum(ConfMat(i,:)) - tp(i);
        fp(i) = sum(ConfMat(:,i)) - tp(i);
        tn(i) = sum(diag(ConfMat)) - tp(i);
    end
        
        
    Precision_mu = (sum(tp)) / (sum(tp)+sum(fp));
    Recall_mu = (sum(tp)) / (sum(tp) + sum(fn));
    F1Score_mu = 2 *((Precision_mu * Recall_mu)/(Precision_mu + Recall_mu));
        
    FPR_mu = (sum(fp)/ (sum(fp) + sum(tn)));
        
    AverageAccuracy = 0;
    Precision_M = 0;
    Recall_M = 0;
    FPR_M = 0;
        
    for r = 1:l
        AverageAccuracy = AverageAccuracy + ((tp(i)+tn(i))/((tp(i)+fn(i)+fp(i)+tn(i))));
        Precision_M = Precision_M + (tp(i)/(tp(i)+fp(i)));
        Recall_M = Recall_M + (tp(i)/(tp(i)+fn(i)));
        FPR_M = FPR_M + (fp(i)/(fp(i)+tn(i)));
            
    end
    AverageAccuracy = AverageAccuracy/l;
    Precision_M = Precision_M/l;
    Recall_M = Recall_M/l;
        
    F1Score_M = 2*((Precision_M * Recall_M)/(Precision_M + Recall_M));
    
    if Best_F1_mu < F1Score_mu
            Best_F1_mu = F1Score_mu;
            F1_mu_k = Cost;
            
    end
        
        if Best_F1_M < F1Score_M
            Best_F1_M = F1Score_M;
            F1_M_k = Cost;
           
        end
        
        if Best_FPR_mu > FPR_mu
            Best_FPR_mu = FPR_mu;
            FPR_mu_k = Cost;
           
        end
        
        if Best_FPR_M > FPR_M
            Best_FPR_M = FPR_M;
            FPR_M_k = Cost;
           
        end
        
        
        if Best_Accuracy <= Accuracy
            Best_Accuracy = Accuracy;
            Accuracy_k = Cost;
        end
        

    end

disp('Best_F1_mu')
disp(Best_F1_mu)
disp(F1_mu_k)


disp('#############################')

disp('Best_F1_M')
disp(Best_F1_M)
disp(F1_M_k)

disp('#############################')

disp('Best_FPR_mu')
disp(Best_FPR_mu)
disp(FPR_mu_k)

disp('#############################')

disp('Best_FPR_M')
disp(Best_FPR_M)
disp(FPR_M_k)

disp('#############################')

disp('Best_Accuracy')
disp(Best_Accuracy)
disp(Accuracy_k)

disp('#############################')

%##################################################################################
% Now we are using the best Cost and Gamma readings to get our final
% results

k=10;

cvFolds = crossvalind('Kfold', Y, k);   %# get indices of 10-fold CV
cp = classperf(Y); 


Best_cost = F1_M_k;


for i = 1:10
    
        testIdx = (cvFolds == i);
        trainIdx = ~testIdx;
    
        % Hard coded number of classes
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
    
            % Need to increase number of iterations
            options = optimset('maxiter',10000);
            %options = svmsmoset('MaxIter',50000);
            % 'SMO','smo_opts'
    
            svmModel{k} = svmtrain(X(idx,:), Y(idx), ...
                 'Autoscale',true, 'Showplot',false, 'Method','QP','quadprog_opts',options, ...
                 'BoxConstraint',Best_cost, 'Kernel_Function','linear');

    %# test
            predTest(:,k) = svmclassify(svmModel{k}, X(testIdx,:));
        end
        pred = mode(predTest,2);   %# voting: clasify as the class receiving most votes
        cp = classperf(cp,pred,testIdx);
%# performance
    %cmat = confusionmat(Y(testIdx),pred);
    %acc = 100*sum(diag(cmat))./sum(cmat(:));
    %fprintf('SVM (1-against-1):\naccuracy = %.2f%%\n', acc);
    %fprintf('Confusion Matrix:\n'), disp(cmat)
    
end

Final_Accuracy = cp.CorrectRate;

    Final_ConfMat = cp.CountingMatrix;
    Fin_Inconclusive = Final_ConfMat(7,:);
    Final_ConfMat(7,:) = [];

    [l,p] = size(Final_ConfMat);
        
    tp = zeros(1,p);
    tn = zeros(1,p);
        
    fp = zeros(1,p);
    fn = zeros(1,p);
        
    for i =1:l
        tp(i) = Final_ConfMat(i,i);
        fn(i) = sum(Final_ConfMat(i,:)) - tp(i);
        fp(i) = sum(Final_ConfMat(:,i)) - tp(i);
        tn(i) = sum(diag(Final_ConfMat)) - tp(i);
    end
        
        
    Final_Precision_mu = (sum(tp)) / (sum(tp)+sum(fp));
    Final_Recall_mu = (sum(tp)) / (sum(tp) + sum(fn));
    Final_F1Score_mu = 2 *((Final_Precision_mu * Final_Recall_mu)/(Final_Precision_mu + Final_Recall_mu));
        
    Final_FPR_mu = (sum(fp)/ (sum(fp) + sum(tn)));
        
    Final_AverageAccuracy = 0;
    Final_Precision_M = 0;
    Final_Recall_M = 0;
    Final_FPR_M = 0;
        
    for r = 1:l
        Final_AverageAccuracy = Final_AverageAccuracy + ((tp(i)+tn(i))/((tp(i)+fn(i)+fp(i)+tn(i))));
        Final_Precision_M = Final_Precision_M + (tp(i)/(tp(i)+fp(i)));
        Final_Recall_M = Final_Recall_M + (tp(i)/(tp(i)+fn(i)));
        Final_FPR_M = Final_FPR_M + (fp(i)/(fp(i)+tn(i)));
            
    end
    Final_AverageAccuracy = Final_AverageAccuracy/l;
    Final_Precision_M = Final_Precision_M/l;
    Final_Recall_M = Final_Recall_M/l;
        
    Final_F1Score_M = 2*((Final_Precision_M * Final_Recall_M)/(Final_Precision_M + Final_Recall_M));