% Binary FScore Results;
LDA_result = 0;
SVM_Result = 0;
KNN_result = 0;

featurename = [LDA_result,SVM_Result,KNN_result];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Beckel = [0,0,0];

B_RWSHH = [77,0,86];

B_RWSH = [77,0,85];

B_RMSHH = [68,0,74];

B_RMSH = [70,0,76];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B_AD_Month = [57,0,64];

B_AD_Week = [72,0,76];

B_AH_Month = [60,0,67];

B_AH_Week = [72,0,76];

B_AHD_Month = [63,0,67];

B_AHD_Week = [66,0,66];

B_AHH_Month = [57,0,64];

B_AHH_Week = [72,0,76];

B_AHHD_Month = [70,0,78];

B_AHHD_Week = [61,0,69];

B_APD_Month = [54,0,67];

B_APD_Week = [71,0,74];

B_APH_Month = [65,0,72];

B_APH_Week = [72,0,80];

B_APHH_Month = [66,0,68];

B_APHH_Week = [74,0,77];

B_ASD_Month = [58,0,65];

B_ASD_Week = [71,0,77];

B_MS       = [58,0,66];

B_SAHD_Month = [71,0,78];

B_SAHHD_Month = [73,0,80];

B_SAPD_Month = [66,0,72];

B_SAPD_Week = [72,0,78];

B_SAPH_Month = [68,0,73];

B_SAPH_Week = [75,0,79];

B_SAPHH_Month = [67,0,76];

B_SAPHH_Week = [73,0,79];

B_WS = [72,0,75];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BinaryAccuracyResults = [Beckel;...
B_RWSHH;...
B_RWSH;...

B_RMSHH ;...

B_RMSH;...



B_AD_Month;...

B_AD_Week;...

B_AH_Month ;...

B_AH_Week;...

B_AHD_Month;...

B_AHD_Week ;...

B_AHH_Month ;...

B_AHH_Week ;...

B_AHHD_Month ;...

B_AHHD_Week ;...

B_APD_Month ;...

B_APD_Week ;...

B_APH_Month ;...

B_APH_Week ;...

B_APHH_Month ;...

B_APHH_Week ;...

B_ASD_Month ;...

B_ASD_Week ;...

B_MS       ;...

B_SAHD_Month ;...

B_SAHHD_Month ;...

B_SAPD_Month ;...

B_SAPD_Week ;...

B_SAPH_Month ;...

B_SAPH_Week ;...

B_SAPHH_Month ;...

B_SAPHH_Week;...

B_WS];