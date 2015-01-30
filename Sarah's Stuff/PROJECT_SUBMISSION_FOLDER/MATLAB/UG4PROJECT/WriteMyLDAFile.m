function ...
    WriteMyLDAFile(ChosenFeatures,CurrentMatrixName,BinMulti,...
    Pm,PM,Rm,RM,F1M,F1m,Ac,ConfMat)

fileName = sprintf('%s_%s_%s_LDA',ChosenFeatures,CurrentMatrixName,BinMulti);
write_fileName = fopen(fileName,'w');

fprintf(write_fileName,'%s_%s_%s_LDA \n',ChosenFeatures,CurrentMatrixName,BinMulti);
fprintf(write_fileName, 'Precision Macro: %f \n',PM);
fprintf(write_fileName, 'Precision micro: %f \n',Pm);

fprintf(write_fileName, 'Recall Macro: %f \n',RM);
fprintf(write_fileName, 'Recall micro: %f \n',Rm);


fprintf(write_fileName, 'F1Score Macro: %f \n',F1M);
fprintf(write_fileName, 'F1Score micro: %f \n',F1m);

fprintf(write_fileName, 'Accuracy: %f \n',Ac);

fprintf(write_fileName,'\n');

fprintf(write_fileName, 'Confusion Matrix \n');
dlmwrite(fileName,ConfMat,'-append');

fclose('all');


end