function BoxPlot1D(X,Y,Title)

[M,Z,NumberRemoved] = RemoveOutliers(X,Y);


M = M ./ 1000;

boxplot(M,Z)


xlabel('Household Occupancy')
ylabel('Energy use kWh')


title(Title)

end