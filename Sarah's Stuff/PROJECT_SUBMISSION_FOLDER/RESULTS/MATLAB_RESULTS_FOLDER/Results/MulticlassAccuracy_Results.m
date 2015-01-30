% Some MULTICLASS Accuracy results;
LDA_result = 0;
SVM_Result = 0;
KNN_result = 0;

featurename = [LDA_result,SVM_Result,KNN_result];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%5 Recreated Features %%%%%
M_RWSHH = [57,57,66];

M_RWSH = [57,58,64];

M_RMSHH = [58,51,59];

M_RMSH = [57,54,60];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M_AD_Month = [51,39,53];

M_AD_Week = [44,39,49];

M_AH_Month = [50,39,50];

M_AH_Week = [44,39,49];

M_AHD_Month = [61,48,62];

M_AHD_Week = [56,51,59];

M_AHH_Month = [51,39,52];

M_AHH_Week = [44,39,49];

M_AHHD_Month = [62,55,63];

M_AHHD_Week = [54,48,62];

M_APD_Month = [54,44,54];

M_APD_Week = [45,43,52];

M_APH_Month = [53,46,60];

M_APH_Week = [50,49,63];

M_APHH_Month = [56,46,61];

M_APHH_Week = [51,48,61];

M_ASD_Month = [51,38,53];

M_ASD_Week = [43,39,50];

M_MS       = [50,40,51];

M_SAHD_Month = [58,60,67];

M_SAHHD_Month = [66,65,70];

M_SAPD_Month = [54,44,59];

M_SAPD_Week = [50,46,56];

M_SAPH_Month = [57,55,61];

M_SAPH_Week = [54,53,63];

M_SAPHH_Month = [57,47,63];

M_SAPHH_Week = [58,53,60];

M_WS = [44,39,49];

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%