BinaryAccuracy_results;

% We're just getting the first two rows, so Beckel and RWSHH

% First row is Beckel
% Second row is RWSHH
Beckel = BinaryAccuracyResults(1,:);
RWSHH = BinaryAccuracyResults(2,:);
x_labels = {'Beckel';'Recreated'};

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')

Y = [Beckel;RWSHH];
figure;
h = bar(Y,'grouped','LineWidth',0.3);
%set(h(1),'facecolor','r');
%set(h(2),'facecolor','k');
%set(h(3),'facecolor','b');
grid on;

ylabel('Accuracy','FontName','Copperplate Gothic Bold','FontSize',15);

set(gca,'YLim',[20 90])
set(gca,'YTick', [20:10:90])
set(gca,'YTickLabel',['20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'])
set(gca,'XTickLabel',x_labels)
set(gca,'XLim',[0 3])

set(gca,'FontSize',15)
set(gca,'FontName','Copperplate Gothic Bold')
rotateXLabels( gca(), 45)

l = cell(1,3);
l{1} = 'LDA';l{2} ='SVM';l{3} = 'K-NN';
legend(h,l)


