function [Precision_Macro,Precision_micro,Recall_Macro,...
    Recall_micro,F1Score_Macro,F1Score_micro, ...
    Final__Accuracy,Best_Cost,Best_Gamma,Final_ConfMatrix,Final_Inconclusive] ...
    = RunMySVM(InputMatrix,LabelMatrix)
X = InputMatrix;
Y = LabelMatrix;

C = unique(Y);

number_of_classes = length(C);

%Depending on the number of classes we run different models
if number_of_classes == 2
    % Binary SVM model
    
    % RBF Version
    %SVM2class10fold
    
    %Linear Version
    LINEAR_SVM2class10fold
else 
    disp('Multi-Class')
    % Multiclass SVM Model
    numOfClasses = number_of_classes;
    
    % RBF Version
    %tenFold_SVM1v1
    
    %Linear Version
    LINEAR_1v1SVM
end

Precision_Macro = Final_Precision_M;
Precision_micro = Final_Precision_mu;

Recall_Macro = Final_Recall_M;
Recall_micro = Final_Recall_mu;

F1Score_Macro = Final_F1Score_M;
F1Score_micro = Final_F1Score_mu;

Final__Accuracy = Final_Accuracy;

Best_Cost = Best_cost;
%Best_Gamma = Best_gamma;
Best_Gamma = 0;

Final_ConfMatrix = Final_ConfMat;

Final_Inconclusive = Fin_Inconclusive;

% What do I want to return?

% precsion_mu and M
% recall_mu and M
% fscore1_mu and M
% confusion matrix
% accuracy
% best_Cost
% best_Gamma


end

