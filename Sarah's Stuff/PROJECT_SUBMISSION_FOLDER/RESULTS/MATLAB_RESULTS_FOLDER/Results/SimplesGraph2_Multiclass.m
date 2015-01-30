% MultiClass Accuracys %

M_AD_Month = [51,39,53];
M_AD_Week = [44,39,49];

M_AH_Month = [50,39,50];
M_AH_Week = [44,39,49];

M_AHH_Month = [51,39,52];
M_AHH_Week = [44,39,49];

M_MS       = [50,40,51];

M_WS = [44,39,49];

% Binary F_Scores %
F_M_AD_Month = [20,19,42];
F_M_AD_Week = [34,24,50];

F_M_AH_Month = [27,13,40];
F_M_AH_Week = [34,24,53];

F_M_AHH_Month = [27,14,41];
F_M_AHH_Week = [34,24,54];

F_M_MS       = [27,14,35];
F_M_WS = [34,24,35];


% Plot Months with Months

% Accuracy

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y = [M_AD_Month; M_AH_Month ; M_AHH_Month; M_MS];
figure;
h = bar(Y,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'AD-Month';'AH-Month'; 'AHH-Month'; 'MS'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%'; '30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 5])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h,l)

% FScore

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y2 = [F_M_AD_Month; F_M_AH_Month ; F_M_AHH_Month; F_M_MS];
figure;
h2 = bar(Y2,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'AD-Month';'AH-Month'; 'AHH-Month'; 'MS'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%'; '30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 5])

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

Y3 = [M_AD_Week; M_AH_Week ; M_AHH_Week; M_WS];
figure;
h3 = bar(Y3,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'AD-Week';'AH-Week'; 'AHH-Week'; 'WS'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%'; '30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 5])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h3,l)

% F Score
set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y4 = [F_M_AD_Week; F_M_AH_Week ; F_M_AHH_Week; F_M_WS];
figure;
h4 = bar(Y4,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'AD-Week';'AH-Week'; 'AHH-Week'; 'WS'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%'; '30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 5])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h4,l)
