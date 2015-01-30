% Here we will deal with Accuracy
% MultiClass Accuracy Results
M_RWSHH = [57,57,66];
M_RWSH = [57,58,64];
M_RMSHH = [58,51,59];
M_RMSH = [57,54,60];

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y = [M_RWSH; M_RMSH];
figure;
h = bar(Y,'grouped','LineWidth',0.3);
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'RWH'; 'RMH'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 3])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h,l)

% Here we will deal with FScore

M_RWSHH = [64,67,84];
M_RWSH = [70,70,83];
M_RMSHH = [55,56,84];
M_RMSH = [62,58,84];

Y2 = [ M_RWSH; M_RMSH];

figure;
h2 = bar(Y2,'grouped','LineWidth',0.3);
grid on;

ylabel('F_1 Score','FontName','Copperplate Gothic Bold','FontSize',15);
x_labels={'RWH'; 'RMH'};
set(gca,'YLim',[0 90])
set(gca,'YTick', [0:10:90])
set(gca,'YTickLabel',[{'0';'10%';'20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'}])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 3])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h2,l)