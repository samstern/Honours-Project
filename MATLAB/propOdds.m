e=social_grade.numE;
d=social_grade.numD;
c1=social_grade.numC1;
c2=social_grade.numC2;
b=social_grade.numB;
a=social_grade.numA;

pe=e/(numhouse);
pd=d/(numhouse);
pc2=c2/(numhouse);
pc1=c1/(numhouse);
pb=b/(numhouse);
pa=a/(numhouse);

lpe=log(pe/(pd+pc2+pc1+pb+pa));
lpd=log((pe+pd)/(pc2+pc1+pb+pa));
lpc1=log((pe+pd+pc2)/(pc1+pb+pa));
lpc2=log((pe+pd+pc2+pc1)/(pb+pa));
lpb=log((pe+pd+pc2+pc1+pb)/(pa));

[(lpd-lpe),(lpc2-lpd),(lpc1-lpc2),(lpb-lpc1)]
[lpe,lpd,lpc2,lpc1,lpb]
[lpe,lpd, lpc1,lpc2,lpb]
[(lpd-lpe),(lpc1-lpd),(lpc2-lpc1),(lpb-lpc2)]

lpe=log(pe/(pd+pc2+pc1+pb+pa));
lpd=log((pe+pd)/(pc2+pc1+pb+pa));
lpc1=log((pe+pd+pc1)/(pc2+pb+pa));
lpc2=log((pe+pd+pc2+pc1)/(pb+pa));
lpb=log((pe+pd+pc2+pc1+pb)/(pa));

[(lpd-lpe),(lpc2-lpd),(lpc1-lpc2),(lpb-lpc1)]
[lpe,lpd,lpc2,lpc1,lpb]

ye=social_grade.all>1
yd=social_grade.all>2
yc2=social_grade.all>3
yc1=social_grade.all>4
yb=social_grade.all>5

m1=fitglm(x_opt_log_reg_sg.all,ye,'distribution','binomial','link','logit');
m2=fitglm(x_opt_log_reg_sg.all,yd,'distribution','binomial','link','logit');
m3=fitglm(x_opt_log_reg_sg.all,yc2,'distribution','binomial','link','logit');
m4=fitglm(x_opt_log_reg_sg.all,yc1,'distribution','binomial','link','logit');
m5=fitglm(x_opt_log_reg_sg.all,yb,'distribution','binomial','link','logit');

[m1.Coefficients.Estimate m2.Coefficients.Estimate m3.Coefficients.Estimate m4.Coefficients.Estimate m5.Coefficients.Estimate]




