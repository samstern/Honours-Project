%  MULTICLASS F_Score Results results;
LDA_result = 0;
SVM_Result = 0;
KNN_result = 0;

featurename = [LDA_result,SVM_Result,KNN_result];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%5 Recreated Features %%%%%
M_RWSHH = [64,67,84];

M_RWSH = [70,70,83];

M_RMSHH = [55,56,84];

M_RMSH = [62,58,84];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M_AD_Month = [20,19,42];

M_AD_Week = [34,24,50];

M_AH_Month = [27,13,40];

M_AH_Week = [34,24,53];

M_AHD_Month = [75,73,82];

M_AHD_Week = [83,69,86];

M_AHH_Month = [27,14,41];

M_AHH_Week = [34,24,54];

M_AHHD_Month = [84,84,88];

M_AHHD_Week = [86,82,88];

M_APD_Month = [56,63,87];

M_APD_Week = [53,47,75];

M_APH_Month = [52,49,87];

M_APH_Week = [55,55,75];

M_APHH_Month = [60,45,73];

M_APHH_Week = [60,56,80];

M_ASD_Month = [26,27,45];

M_ASD_Week = [32,29,58];

M_MS       = [27,14,35];

M_SAHD_Month = [58,89,64];

M_SAHHD_Month = [66,96,91];

M_SAPD_Month = [72,63,81];

M_SAPD_Week = [72,71,80];

M_SAPH_Month = [65,67,80];

M_SAPH_Week = [73,66,79];

M_SAPHH_Month = [59,61,72];

M_SAPHH_Week = [76,68,73];

M_WS = [34,24,35];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% All F_Score Multiclass Results as a matrix %%%
MultiClassFscoreResults = [M_RWSHH;...
M_RWSH;...

M_RMSHH ;...

M_RMSH;...



M_AD_Month;...

M_AD_Week;...

M_AH_Month ;...

M_AH_Week;...

M_AHD_Month;...

M_AHD_Week ;...

M_AHH_Month ;...

M_AHH_Week ;...

M_AHHD_Month ;...

M_AHHD_Week ;...

M_APD_Month ;...

M_APD_Week ;...

M_APH_Month ;...

M_APH_Week ;...

M_APHH_Month ;...

M_APHH_Week ;...

M_ASD_Month ;...

M_ASD_Week ;...

M_MS       ;...

M_SAHD_Month ;...

M_SAHHD_Month ;...

M_SAPD_Month ;...

M_SAPD_Week ;...

M_SAPH_Month ;...

M_SAPH_Week ;...

M_SAPHH_Month ;...

M_SAPHH_Week;...

M_WS];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
