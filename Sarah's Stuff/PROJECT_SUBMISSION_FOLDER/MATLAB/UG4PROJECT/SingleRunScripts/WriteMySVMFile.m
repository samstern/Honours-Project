function ...
    WriteMySVMFile(ChosenFeatures,CurrentMatrixName,BinMulti,...
    PM,Pm,RM,Rm,F1M,F1m,Ac,BC,BG,ConfMat, Inconclusives)

fileName = sprintf('%s_%s_%s_SVM',ChosenFeatures,CurrentMatrixName,BinMulti);
write_fileName = fopen(fileName,'w');


fprintf(write_fileName,'%s_%s_%s_SVM \n',ChosenFeatures,CurrentMatrixName,BinMulti);
fprintf(write_fileName, 'Precision Macro: %f \n',PM);
fprintf(write_fileName, 'Precision micro: %f \n',Pm);

fprintf(write_fileName, 'Recall Macro: %f \n',RM);
fprintf(write_fileName, 'Recall micro: %f \n',Rm);


fprintf(write_fileName, 'F1Score Macro: %f \n',F1M);
fprintf(write_fileName, 'F1Score micro: %f \n',F1m);

fprintf(write_fileName, 'Accuracy: %f \n',Ac);

fprintf(write_fileName, 'Best Cost: %f \n',BC);
fprintf(write_fileName, 'Best Gamma: %f \n',BG);

fprintf(write_fileName,'\n');


dlmwrite(fileName,ConfMat,'-append');
dlmwrite(fileName,Inconclusives,'-append');

fclose('all');


end