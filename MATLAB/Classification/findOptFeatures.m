numFeatures=10;
x=compositeFeatures(monthSum,dayAverages,x_APOD,x_POW_ratio,x_ADV,x_corr,x_fourier);
x_opt_knn_child=selectFeatures(x,children_filtered,'c',10,'knn');
x_opt_log_reg_child=selectFeatures(x,children_filtered,'c',numFeatures,'log_reg');
x_opt_rf_child=selectFeatures(x,children_filtered,'c',numFeatures,'rf');
x_opt_log_reg_sg=selectFeatures(x,social_grade,'s',numFeatures,'log_reg');
x_opt_knn_social=selectFeatures(x,social_grade,'s',numFeatures,'knn');
x_opt_rf_social=selectFeatures(x,social_grade,'s',numFeatures,'rf');