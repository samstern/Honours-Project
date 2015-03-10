function knn=runKNN(x_train,x_test,y_train,y_test)

k=10;
mdl = fitcknn(x_train,y_train,'NumNeighbors',k,'Distance','euclidean');
knn.yhat = predict(mdl,x_test);
knn.confusion = confusionmat(y_test,knn.yhat);
knn.accuracy=sum(diag(knn.confusion))/sum(sum(knn.confusion));
temp=num2cell(knn.confusion(:));
[knn.TP,knn.FP, knn.FN, knn.TP]=temp{:};
end