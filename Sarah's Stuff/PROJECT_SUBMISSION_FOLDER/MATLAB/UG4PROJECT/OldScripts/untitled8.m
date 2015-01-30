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
cp = classperf(groups);
for gamma = (2^-15):(2^2):(2^3)
    disp('gamma')
    disp(gamma)
    for Cost =1:3
        disp('Cost')
        disp(Cost)
        for i = 1:k                                  %# for each fold
                testIdx = (cvFolds == i);                %# get indices of test instances
                trainIdx = ~testIdx;                     %# get indices training instances
    %# train an SVM model over training instances
                svmModel = svmtrain(X(trainIdx,:), groups(trainIdx), ...
                 'Autoscale',true, 'Showplot',false, 'Method','QP', ...
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