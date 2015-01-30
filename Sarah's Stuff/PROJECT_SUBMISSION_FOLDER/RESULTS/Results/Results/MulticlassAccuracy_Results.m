% Some MULTICLASS Accuracy results;
LDA_result = 0;
SVM_Result = 0;
KNN_result = 0;

featurename = [LDA_result,SVM_Result,KNN_result];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%5 Recreated Features %%%%%
M_RWSHH = [57,0,66];

M_RWSH = [57,0,64];

M_RMSHH = [58,0,59];

M_RMSH = [57,0,60];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M_AD_Month = [51,0,53];

M_AD_Week = [44,0,49];

M_AH_Month = [50,0,50];

M_AH_Week = [44,0,49];

M_AHD_Month = [61,0,62];

M_AHD_Week = [56,0,59];

M_AHH_Month = [51,0,52];

M_AHH_Week = [44,0,49];

M_AHHD_Month = [62,0,63];

M_AHHD_Week = [54,0,62];

M_APD_Month = [54,0,54];

M_APD_Week = [45,0,52];

M_APH_Month = [53,0,60];

M_APH_Week = [50,0,63];

M_APHH_Month = [56,0,61];

M_APHH_Week = [51,0,61];

M_ASD_Month = [51,0,53];

M_ASD_Week = [43,0,50];

M_MS       = [50,0,51];

M_SAHD_Month = [58,0,67];

M_SAHHD_Month = [66,0,70];

M_SAPD_Month = [54,0,59];

M_SAPD_Week = [50,0,56];

M_SAPH_Month = [57,0,61];

M_SAPH_Week = [54,0,63];

M_SAPHH_Month = [57,0,63];

M_SAPHH_Week = [58,0,60];

M_WS = [44,0,49];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% All Accuracy Multiclass Results as a matrix %%%
MultiClassResults = [M_RWSHH;...
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