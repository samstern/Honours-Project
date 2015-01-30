%% This version currently uses F1_M_k to find best k %%

% Using ClassificationKNN from the statistics toolbo in matlab, 
% Using kdtree for space partitioning (to avoid linear tree)
% varying the levels of cross validation and of number of neighbors
% k is the number of neighbours

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

for k = 2:20

    model = ClassificationKNN.fit(X,Y,'NSMethod','kdtree','NumNeighbors',k);
        cvModel = crossval(model,'kfold',10);
        KLoss = kfoldLoss(cvModel);
        M = kfoldMargin(cvModel);
        
        [LABEL,SCORE,COST]=kfoldPredict(cvModel);
        
        ConfMat = confusionmat(Y,LABEL);
        
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
            F1_mu_k = k;
        end
        
        if Best_F1_M < F1Score_M
            Best_F1_M = F1Score_M;
            F1_M_k = k;
        end
        
        if Best_FPR_mu > FPR_mu
            Best_FPR_mu = FPR_mu;
            FPR_mu_k = k;
        end
        
        if Best_FPR_M > FPR_M
            Best_FPR_M = FPR_M;
            FPR_M_k = k;
        end
        
        Accuracy = 1-KLoss;
        
        if Best_Accuracy <= Accuracy
            Best_Accuracy = Accuracy;
            Accuracy_k = k;
        end
        
        %disp('Number of Neighbors')
        %disp(k)
        %disp('Accuracy')
        %disp(Accuracy)
end
%disp('Best_F1_mu')
%disp(Best_F1_mu)
%disp(F1_mu_k)

%disp('Best_F1_M')
%disp(Best_F1_M)
%disp(F1_M_k)

%disp('Best_FPR_mu')
%isp(Best_FPR_mu)
%disp(FPR_mu_k)

%disp('Best_FPR_M')
%disp(Best_FPR_M)
%disp(FPR_M_k)

%disp('Best_Accuracy')
%disp(Best_Accuracy)

% Going to use F1_M_k as the best number of neighbours to use

model = ClassificationKNN.fit(X,Y,'NSMethod','kdtree','NumNeighbors',F1_M_k);
        cvModel = crossval(model,'kfold',10);
        KLoss = kfoldLoss(cvModel);
        M = kfoldMargin(cvModel);
        
        [LABEL,SCORE,COST]=kfoldPredict(cvModel);
        
        ConfMat = confusionmat(Y,LABEL);
        
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
        

% help crossval