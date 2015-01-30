%# SVM for 2 class Problem, 10-fold CV
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

groups = Y;

k=10;

cvFolds = crossvalind('Kfold', groups, k);   %# get indices of 10-fold CV
cp = classperf(groups);                      %# init performance tracker

disp('here')
for gamma = linspace((2^(-15)),(2^3),10)
    disp('gamma')
    disp(gamma)
    for Cost = linspace(2^(-5),(2^15),10)
        disp('Cost')
        disp(Cost)
        for i = 1:k                                  %# for each fold
            testIdx = (cvFolds == i);                %# get indices of test instances
            trainIdx = ~testIdx;                     %# get indices training instances
    %# train an SVM model over training instances
    % Need to increase number of iterations
            options = optimset('maxiter',10000);
            
            svmModel = svmtrain(X(trainIdx,:), groups(trainIdx), ...
                 'Autoscale',true, 'Showplot',false, 'Method','QP','QUADPROG_OPTS',options, ...
                 'BoxConstraint',Cost, 'Kernel_Function','rbf', 'RBF_Sigma',gamma);
    
    % BoxConstraint relates to the C in the C-SVM implementation
    % RBF_Sigma is the scaling factor in the RBF kernel, the gamma
    %# test using test instances
            pred = svmclassify(svmModel, X(testIdx,:), 'Showplot',false);

    %# evaluate and update performance object
            cp = classperf(cp, pred, testIdx);
        end

    Accuracy = cp.CorrectRate;

    ConfMat = cp.CountingMatrix;
    ConfMat(3,:) = [];

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
            F1_mu_gamma = gamma;
    end
        
    if Best_F1_M < F1Score_M
        Best_F1_M = F1Score_M;
        F1_M_k = Cost;
        F1_M_gamma = gamma;
    end
        
    if Best_FPR_mu > FPR_mu
        Best_FPR_mu = FPR_mu;
        FPR_mu_k = Cost;
        FPR_mu_gamma = gamma;
    end
    
    if Best_FPR_M > FPR_M
        Best_FPR_M = FPR_M;
        FPR_M_k = Cost;
        FPR_M_gamma = gamma;
    end
    
    if Best_Accuracy <= Accuracy
        Best_Accuracy = Accuracy;
        Accuracy_k = Cost;
        Accuracy_gamma = gamma;
    end
        

    end
end

disp('Best_F1_mu')
disp(Best_F1_mu)
disp(F1_mu_k)
disp(F1_mu_gamma)

disp('#############################')

disp('Best_F1_M')
disp(Best_F1_M)
disp(F1_M_k)
disp(F1_M_gamma)
disp('#############################')

disp('Best_FPR_mu')
disp(Best_FPR_mu)
disp(FPR_mu_k)
disp(FPR_mu_gamma)
disp('#############################')

disp('Best_FPR_M')
disp(Best_FPR_M)
disp(FPR_M_k)
disp(FPR_M_gamma)
disp('#############################')

disp('Best_Accuracy')
disp(Best_Accuracy)
disp(Accuracy_k)
disp(Accuracy_gamma)
disp('#############################')

%##################################################################################
% Now we are using the best Cost and Gamma readings to get our final
% results

k=10;

cvFolds = crossvalind('Kfold', groups, k);   %# get indices of 10-fold CV
cp = classperf(groups); 

Best_cost = F1_M_k;
Best_gamma = F1_M_gamma;

for i = 1:k                                  %# for each fold
            testIdx = (cvFolds == i);                %# get indices of test instances
            trainIdx = ~testIdx;                     %# get indices training instances
    %# train an SVM model over training instances
    
            % Need to increase number of iterations
            options = optimset('maxiter',10000);
            
            svmModel = svmtrain(X(trainIdx,:), groups(trainIdx), ...
                 'Autoscale',true, 'Showplot',false, 'Method','QP','QUADPROG_OPTS',options, ...
                 'BoxConstraint',Best_cost, 'Kernel_Function','rbf', 'RBF_Sigma',Best_gamma);
    
    % BoxConstraint relates to the C in the C-SVM implementation
    % RBF_Sigma is the scaling factor in the RBF kernel, the gamma
    %# test using test instances
            pred = svmclassify(svmModel, X(testIdx,:), 'Showplot',false);

    %# evaluate and update performance object
            cp = classperf(cp, pred, testIdx);
end

Final_Accuracy = cp.CorrectRate;

    Final_ConfMat = cp.CountingMatrix;
    Fin_Inconclusive = Final_ConfMat(3,:);
    Final_ConfMat(3,:) = [];

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
    