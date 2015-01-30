%%% Using the results to makre scatter plots %%%


% Makes a grid that we want to work with

ThemFeatures = [1,1,1];
RSWHH = [2,2,2];

AllFeatures = [ThemFeatures,RSWHH];

LDA = [1,2];
KNN = [1,2];
SVM = [1,2];

ThemLDA = [73];
ThemKNN = [70];
ThemSVM = [73];

AllThem = [ThemLDA,ThemKNN,ThemSVM];


RSWHH_LDA = [77];
RSWHH_KNN = [81];
RSWHH_SVM = [0];

All_RSWHH = [RSWHH_LDA,RSWHH_KNN,RSWHH_SVM];



All_LDA = [ThemLDA,RSWHH_LDA];
All_KNN = [ThemKNN,RSWHH_KNN];
All_SVM = [ThemSVM,RSWHH_KNN];

%Want to scatter the LDA results
figure
scatter(LDA,All_LDA,'Marker','o','markerfacecolor','magenta')
hold on
scatter(SVM,All_SVM,'Marker','+','markerfacecolor','black')
hold on
scatter(KNN,All_KNN,'Marker','*','markerfacecolor','red')

set(gca,'YTick',[0,10,20,30,40,50,60,70,80,90,100])
set(gca,'XTick',[1,2,3])
set(gca,'XTickLabel',{'Beckel','Recreated'})


grid on