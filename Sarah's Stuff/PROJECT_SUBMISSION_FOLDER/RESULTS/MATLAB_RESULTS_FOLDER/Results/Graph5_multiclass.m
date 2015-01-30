
% MultiClass Graphs More More Complex Graph 5 %

% Accuracy
M_SAPD_Month = [54,44,59];
M_SAPD_Week = [50,46,56];

M_SAPH_Month = [57,55,61];
M_SAPH_Week = [54,53,63];

M_SAPHH_Month = [57,47,63];
M_SAPHH_Week = [58,53,60];

M_SAHD_Month = [58,60,67];

M_SAHHD_Month = [66,65,70];

% FScore
F_M_SAPD_Month = [72,63,81];
F_M_SAPD_Week = [72,71,80];

F_M_SAPH_Month = [65,67,80];
F_M_SAPH_Week = [73,66,79];

F_M_SAPHH_Month = [59,61,72];
F_M_SAPHH_Week = [76,68,73];

F_M_SAHD_Month = [58,89,64];
F_M_SAHHD_Month = [66,96,91];

% Plot Months with Months

% Accuracy

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y = [M_SAPD_Month; M_SAPH_Month ; M_SAPHH_Month; M_SAHD_Month; M_SAHHD_Month];
figure;
h = bar(Y,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'SAPD-Month';'SAPH-Month'; 'SAPHH-Month'; 'SAHD-Month';'SAHHD-Month'};
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

Y2 = [F_M_SAPD_Month; F_M_SAPH_Month ; F_M_SAPHH_Month; F_M_SAHD_Month; F_M_SAHHD_Month];
figure;
h2 = bar(Y2,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'SAPD-Month';'SAPH-Month'; 'SAPHH-Month'; 'SAHD-Month';'SAHHD-Month'};
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

Y3 = [M_SAPD_Week; M_SAPH_Week ; M_SAPHH_Week];
figure;
h3 = bar(Y3,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'SAPD-Week';'SAPH-Week'; 'SAPHH-Week'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
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

Y4 = [F_M_SAPD_Week; F_M_SAPH_Week ; F_M_SAPHH_Week];
figure;
h4 = bar(Y4,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'SAPD-Week';'SAPH-Week'; 'SAPHH-Week'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 5])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h4,l)