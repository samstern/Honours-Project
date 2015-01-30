% First of the graphs.

%This graph will be accuracy vs Beckel, Us

BinaryAccuracy_results;

% We're just getting the first two rows, so Beckel and RWSHH

LDA = BinaryAccuracyResults(1:2,1);
SVM = BinaryAccuracyResults(1:2,2);
KNN = BinaryAccuracyResults(1:2,3);

y_points = [1,2];
x_labels = {' ';'Beckel';'Recreated'};

scatter(y_points,LDA,240,'Marker','x','markerfacecolor','black','MarkerEdgeColor','k');
hold on
scatter(y_points,SVM,40,'Marker','d','markerfacecolor','cyan','MarkerEdgeColor','b');
hold on
scatter(y_points,KNN,140,'Marker','*','markerfacecolor','red','MarkerEdgeColor','r');
title('Beckel and Recreated Work on HES dataset with Accuracy')
ylabel('Accuracy')


set(gca,'YLim', [20 90])
set(gca,'YTick',[20:10:90])
set(gca,'XLim',[0 2.5])
set(gca,'XTick',[0:2.5])
grid on
set(gca,'YTickLabel',['20%';'30%';'40%';'50%';'60%';'70%';'80%';'90%'])
set(gca,'XTickLabel',x_labels)
grid on
set(gca,'FontSize',15)

rotateXLabels( gca(), 45)

