% Binary Accuracys %

B_AD_Month = [69,73,70];
B_AD_Week = [75,76,76];

B_AH_Month = [71,74,73];
B_AH_Week = [75,76,76];

B_AHH_Month = [70,73,72];
B_AHH_Week = [74,76,76];

B_WS = [75,76,76];

B_MS       = [70,74,74];

% Binary F_Scores %
F_B_AD_Month = [57,66,64];
F_B_AD_Week = [72,74,76];

F_B_AH_Month = [60,68,67];
F_B_AH_Week = [72,74,76];

F_B_AHH_Month = [57,67,64];
F_B_AHH_Week = [72,74,76];

F_B_MS       = [58,67,66];
F_B_WS = [72,74,75];


% Plot Months with Months

% Accuracy

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y = [B_AD_Month; B_AH_Month ; B_MS];
figure;
h = bar(Y,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'AD-Month';'AH-Month'; 'MS'};
set(gca,'YLim',[50 90])
set(gca,'YTick', [50:5:90])
set(gca,'YTickLabel',['50%';'55%';'60%';'65%';'70%';'75%';'80%';'85%';'90%'])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 4])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h,l)

% FScore

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y2 = [F_B_AD_Month; F_B_AH_Month ; F_B_MS];
figure;
h2 = bar(Y2,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'AD-Month';'AH-Month'; 'MS'};
set(gca,'YLim',[50 90])
set(gca,'YTick', [50:5:90])
set(gca,'YTickLabel',['50%';'55%';'60%';'65%';'70%';'75%';'80%';'85%';'90%'])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 4])

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

Y3 = [B_AD_Week; B_AH_Week ; B_WS];
figure;
h3 = bar(Y3,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'AD-Week';'AH-Week'; 'WS'};
set(gca,'YLim',[50 90])
set(gca,'YTick', [50:5:90])
set(gca,'YTickLabel',['50%';'55%';'60%';'65%';'70%';'75%';'80%';'85%';'90%'])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 4])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h3,l)

% F Score
set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y4 = [B_AD_Week; B_AH_Week ; B_WS];
figure;
h4 = bar(Y4,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'AD-Week';'AH-Week';'WS'};
set(gca,'YLim',[50 90])
set(gca,'YTick', [50:5:90])
set(gca,'YTickLabel',['50%';'55%';'60%';'65%';'70%';'75%';'80%';'85%';'90%'])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 4])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h4,l)
