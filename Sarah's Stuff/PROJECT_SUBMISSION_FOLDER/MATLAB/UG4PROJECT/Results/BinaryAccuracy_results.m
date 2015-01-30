% Some Accuracy results;
LDA_result = 0;
SVM_Result = 0;
KNN_result = 0;

featurename = [LDA_result,SVM_Result,KNN_result];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Beckel = [73,73,70];

B_RWSHH = [77,0,81];

B_RWSH = [78,0,83];

B_RMSHH = [76,0,81];

B_RMSH = [76,0,80];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B_AD_Month = [69,0,70];

B_AD_Week = [75,0,76];

B_AH_Month = [71,0,73];

B_AH_Week = [75,0,76];

B_AHD_Month = [72,0,75];

B_AHD_Week = [73,0,77];

B_AHH_Month = [70,0,72];

B_AHH_Week = [74,0,76];

B_AHHD_Month = [79,0,82];

B_AHHD_Week = [73,0,75];

B_APD_Month = [68,0,71];

B_APD_Week = [73,0,75];

B_APH_Month = [73,0,76];

B_APH_Week = [75,0,79];

B_APHH_Month = [75,0,75];

B_APHH_Week = [76,0,78];

B_ASD_Month = [70,0,72];

B_ASD_Week = [73,0,77];

B_MS       = [70,0,74];

B_SAHD_Month = [78,0,83];

B_SAHHD_Month = [74,0,82];

B_SAPD_Month = [75,0,76];

B_SAPD_Week = [74,0,79];

B_SAPH_Month = [76,0,78];

B_SAPH_Week = [77,0,81];

B_SAPHH_Month = [75,0,80];

B_SAPHH_Week = [77,0,80];

B_WS = [75,0,76];

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