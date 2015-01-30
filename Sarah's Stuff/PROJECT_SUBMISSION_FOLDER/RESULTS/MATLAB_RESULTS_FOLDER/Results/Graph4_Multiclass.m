% Binary Graphs %
% More Complex Graph 4 %

% Accuracy
M_APD_Month = [54,44,54];
M_APD_Week = [45,43,52];

M_APH_Month = [53,46,60];
M_APH_Week = [50,49,63];

M_APHH_Month = [56,46,61];
M_APHH_Week = [51,48,61];

M_AHD_Month = [61,48,62];
M_AHD_Week = [56,51,59];


M_AHHD_Month = [62,55,63];
M_AHHD_Week = [54,48,62];

% F Score
F_M_APD_Month = [56,63,87];
F_M_APD_Week = [53,47,75];

F_M_APH_Month = [52,49,87];
F_M_APH_Week = [55,55,75];

F_M_APHH_Month = [60,45,73];
F_M_APHH_Week = [60,56,80];


F_M_AHD_Month = [75,73,82];
F_M_AHD_Week = [83,69,86];


F_M_AHHD_Month = [84,84,88];
F_M_AHHD_Week = [86,82,88];

% Plot Months with Months

% Accuracy

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y = [M_APD_Month; M_APH_Month ; M_APHH_Month; M_AHD_Month; M_AHHD_Month];
figure;
h = bar(Y,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'APD-Month';'APH-Month'; 'APHH-Month'; 'AHD-Month';'AHHD-Month'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 7])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h,l)

% FScore

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y2 = [F_M_APD_Month; F_M_APH_Month ; F_M_APHH_Month; F_M_AHD_Month; F_M_AHHD_Month];
figure;
h2 = bar(Y2,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'APD-Month';'APH-Month'; 'APHH-Month'; 'AHD-Month';'AHHD-Month'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 7])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h2,l)

% Plot Weeks with Weeks

% Accuracy
set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y3 = [M_APD_Week; M_APH_Week ; M_APHH_Week; M_AHD_Week; M_AHHD_Week];
figure;
h3 = bar(Y3,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'APD-Week';'APH-Week'; 'APHH-Week'; 'AHD-Week';'AHHD-Week'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 7])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h3,l)

% F Score
set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y4 = [F_M_APD_Week; F_M_APH_Week ; F_M_APHH_Week; F_M_AHD_Week; F_M_AHHD_Week];
figure;
h4 = bar(Y4,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'APD-Week';'APH-Week'; 'APHH-Week'; 'AHD-Week';'AHHD-Week'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 7])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h4,l)