function [CFS_M,cfs_columns,FCBF_M,fcbf_columns,Fisher_M,fisher_columns] = FSMyMatrix(X,Y)

% Load the featureSelection Package
load_featureselection

[in_row,in_col] = size(X);

% CFS

cfs = fsCFS(X,Y);

cfs_columns = cfs.fList;

num_cfs_col = length(cfs_columns);

CFS_Mat = zeros(in_row,num_cfs_col);

for i = 1:num_cfs_col
    
    CFS_Mat(:,i) = X(:,cfs_columns(i));
    
end

CFS_M = CFS_Mat;

% FCBF ##############################################
fcbf = fsFCBF(X,Y);

fcbf_columns = fcbf.fList;

num_fcbf_col = length(fcbf_columns);

FCBF_Mat = zeros(in_row,num_fcbf_col);

for i = 1:num_fcbf_col
    
    FCBF_Mat(:,i) = X(:,fcbf_columns(i));
    
end

FCBF_M = FCBF_Mat;

% Fisher ########################################
% Fisher will list the features in order of goodness
% need to decide a number of features to take

%Say maximum of 1/5 of the features?

fisher = fsFisher(X,Y);

fisher_columns = fisher.fList;


num_fisher_col = length(fisher_columns);

%take only the first 1/5 of suggested columns if there are more that 5
%feature given

if num_fisher_col > 5

    num_fisher_col = int64(num_fisher_col/5);
    fisher_columns = fisher_columns(1:num_fisher_col);
end

Fisher_Mat = zeros(in_row,num_fisher_col);

for i = 1:num_fisher_col
    
    Fisher_Mat(:,i) = X(:,fisher_columns(i));
    
end

Fisher_M = Fisher_Mat;
end
