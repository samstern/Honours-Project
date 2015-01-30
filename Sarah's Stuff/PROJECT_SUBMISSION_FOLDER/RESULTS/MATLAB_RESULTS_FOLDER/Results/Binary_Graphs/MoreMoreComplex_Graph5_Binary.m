% Binary Graphs More More Complex Graph 5 %

% Accuracy
B_SAPD_Month = [75,75,76];
B_SAPD_Week = [74,76,79];

B_SAPH_Month = [76,77,78];
B_SAPH_Week = [77,79,81];

B_SAPHH_Month = [75,79,80];
B_SAPHH_Week = [77,75,80];

B_SAHD_Month = [78,84,83];

B_SAHHD_Month = [74,80,82];

% FScore
F_B_SAPD_Month = [66,70,72];
F_B_SAPD_Week = [72,75,78];

F_B_SAPH_Month = [68,72,73];
F_B_SAPH_Week = [75,77,79];

F_B_SAPHH_Month = [67,75,76];
F_B_SAPHH_Week = [73,77,79];

F_B_SAHD_Month = [71,80,78];

F_B_SAHHD_Month = [73,74,80];

% Plot Months with Months

% Accuracy

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y = [B_SAPD_Month; B_SAPH_Month ; B_SAHD_Month];
figure;
h = bar(Y,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'SAPD-Month';'SAPH-Month'; 'SAHD-Month'};
set(gca,'YLim',[50 90])
set(gca,'YTick', [50:5:90])
set(gca,'YTickLabel',['50%';'55%';'60%';'65%';'70%';'75%';'80%';'85%';'90%'])
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

Y2 = [F_B_SAPD_Month; F_B_SAPH_Month ; F_B_SAHD_Month];
figure;
h2 = bar(Y2,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'SAPD-Month';'SAPH-Month'; 'SAHD-Month'};
set(gca,'YLim',[50 90])
set(gca,'YTick', [50:5:90])
set(gca,'YTickLabel',['50%';'55%';'60%';'65%';'70%';'75%';'80%';'85%';'90%'])
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

Y3 = [B_SAPD_Week; B_SAPH_Week ];
figure;
h3 = bar(Y3,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'SAPD-Week';'SAPH-Week'};
set(gca,'YLim',[50 90])
set(gca,'YTick', [50:5:90])
set(gca,'YTickLabel',['50%';'55%';'60%';'65%';'70%';'75%';'80%';'85%';'90%'])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 3])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h3,l)

% F Score
set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y4 = [F_B_SAPD_Week; F_B_SAPH_Week ];
figure;
h4 = bar(Y4,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'SAPD-Week';'SAPH-Week'};
set(gca,'YLim',[50 90])
set(gca,'YTick', [50:5:90])
set(gca,'YTickLabel',['50%';'55%';'60%';'65%';'70%';'75%';'80%';'85%';'90%'])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 3])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h4,l)