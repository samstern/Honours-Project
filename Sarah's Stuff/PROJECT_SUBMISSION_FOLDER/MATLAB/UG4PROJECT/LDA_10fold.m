%%% LDA %%%


model = ClassificationDiscriminant.fit(X,Y);
cvModel = crossval(model,'kfold',10);

KLoss = kfoldLoss(cvModel);
M = kfoldMargin(cvModel);
        
[LABEL,SCORE,COST]=kfoldPredict(cvModel);
        
ConfMat = confusionmat(Y,LABEL);

KLoss = kfoldLoss(cvModel);

Accuracy = 1-KLoss;
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
        