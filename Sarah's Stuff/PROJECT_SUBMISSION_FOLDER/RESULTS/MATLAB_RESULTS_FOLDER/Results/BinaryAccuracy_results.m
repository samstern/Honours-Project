% Binary Accuracy results;
LDA_result = 0;
SVM_Result = 0;
KNN_result = 0;

featurename = [LDA_result,SVM_Result,KNN_result];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Beckel = [73,73,70];

B_RWSHH = [77,78,81];

B_RWSH = [78,78,83];

B_RMSHH = [76,77,81];

B_RMSH = [76,79,80];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B_AD_Month = [69,73,70];

B_AD_Week = [75,76,76];

B_AH_Month = [71,74,73];

B_AH_Week = [75,76,76];

B_AHD_Month = [72,75,75];

B_AHD_Week = [73,75,77];

B_AHH_Month = [70,73,72];

B_AHH_Week = [74,76,76];

B_AHHD_Month = [79,78,82];

B_AHHD_Week = [73,75,75];

B_APD_Month = [68,74,71];

B_APD_Week = [73,75,75];

B_APH_Month = [73,77,76];

B_APH_Week = [75,77,79];

B_APHH_Month = [75,75,75];

B_APHH_Week = [76,76,78];

B_ASD_Month = [70,73,72];

B_ASD_Week = [73,75,77];

B_MS       = [70,74,74];

B_SAHD_Month = [78,84,83];

B_SAHHD_Month = [74,80,82];

B_SAPD_Month = [75,75,76];

B_SAPD_Week = [74,76,79];

B_SAPH_Month = [76,77,78];

B_SAPH_Week = [77,79,81];

B_SAPHH_Month = [75,79,80];

B_SAPHH_Week = [77,75,80];

B_WS = [75,76,76];

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y = BinaryAccuracyResults;
figure;
h = bar(Y,'grouped','LineWidth',3);
%set(h(1),'facecolor','r');
%set(h(2),'facecolor','k');
%set(h(3),'facecolor','b');
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);

set(gca,'YLim',[60 90])
set(gca,'YTick', [60:10:90])
set(gca,'YTickLabel',['60%';'70%';'80%';'90%'])
%set(gca,'XTickLabel',LabelNames)
%set(gca,'XLim',[0 3])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
%rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h,l)