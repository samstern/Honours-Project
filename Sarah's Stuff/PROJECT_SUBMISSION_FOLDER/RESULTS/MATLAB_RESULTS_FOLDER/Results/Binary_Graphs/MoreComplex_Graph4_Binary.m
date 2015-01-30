% Binary Graphs %
% More Complex Graph 4 %

% Accuracy
B_APD_Month = [68,74,71];
B_APD_Week = [73,75,75];

B_APH_Month = [73,77,76];
B_APH_Week = [75,77,79];

B_APHH_Month = [75,75,75];
B_APHH_Week = [76,76,78];

B_AHD_Month = [72,75,75];
B_AHD_Week = [73,75,77];

B_AHHD_Month = [79,78,82];
B_AHHD_Week = [73,75,75];

% F Score
F_B_APD_Month = [54,68,67];
F_B_APD_Week = [71,73,74];


F_B_APH_Month = [65,71,72];
F_B_APH_Week = [72,75,80];


F_B_APHH_Month = [66,70,68];
F_B_APHH_Week = [74,74,77];

F_B_AHD_Month = [63,69,67];
F_B_AHD_Week = [66,68,66];

F_B_AHHD_Month = [70,72,78];
F_B_AHHD_Week = [61,68,69];

% Plot Months with Months

% Accuracy

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y = [B_APD_Month; B_APH_Month ; B_AHD_Month];
figure;
h = bar(Y,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'APD-Month';'APH-Month'; 'AHD-Month'};
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

Y2 = [F_B_APD_Month; F_B_APH_Month ;  F_B_AHD_Month];
figure;
h2 = bar(Y2,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'APD-Month';'APH-Month'; 'AHD-Month'};
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

Y3 = [B_APD_Week; B_APH_Week ; B_AHD_Week];
figure;
h3 = bar(Y3,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'APD-Week';'APH-Week'; 'AHD-Week'};
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

Y4 = [F_B_APD_Week; F_B_APH_Week ; F_B_AHD_Week];
figure;
h4 = bar(Y4,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'APD-Week';'APH-Week'; 'AHD-Week'};
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