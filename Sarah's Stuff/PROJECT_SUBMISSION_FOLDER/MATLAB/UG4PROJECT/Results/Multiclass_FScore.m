%  MULTICLASS F_Score Results results;
LDA_result = 0;
SVM_Result = 0;
KNN_result = 0;

featurename = [LDA_result,SVM_Result,KNN_result];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%5 Recreated Features %%%%%
M_RWSHH = [64,0,84];

M_RWSH = [70,0,83];

M_RMSHH = [55,0,84];

M_RMSH = [62,0,84];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M_AD_Month = [20,0,42];

M_AD_Week = [34,0,50];

M_AH_Month = [27,0,40];

M_AH_Week = [34,0,53];

M_AHD_Month = [75,0,82];

M_AHD_Week = [83,0,86];

M_AHH_Month = [27,0,41];

M_AHH_Week = [34,0,54];

M_AHHD_Month = [84,0,88];

M_AHHD_Week = [86,0,88];

M_APD_Month = [56,0,87];

M_APD_Week = [53,0,75];

M_APH_Month = [52,0,87];

M_APH_Week = [55,0,75];

M_APHH_Month = [60,0,73];

M_APHH_Week = [60,0,80];

M_ASD_Month = [26,0,45];

M_ASD_Week = [32,0,58];

M_MS       = [27,0,35];

M_SAHD_Month = [58,0,64];

M_SAHHD_Month = [66,0,91];

M_SAPD_Month = [72,0,81];

M_SAPD_Week = [72,0,80];

M_SAPH_Month = [65,0,80];

M_SAPH_Week = [73,0,79];

M_SAPHH_Month = [59,0,72];

M_SAPHH_Week = [76,0,73];

M_WS = [34,0,35];

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