

boxPlots(monthSum.child,monthSum.noChild,'monthSum')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/Total_Electricity_child.tex','height','2in','width','3in');
boxPlots(monthSum.e,monthSum.d,monthSum.c2,monthSum.c1,monthSum.b,monthSum.a,'monthSum')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/Total_Electricity_socio.tex','height','2in','width','3in');

boxPlots(dayAverages.child,dayAverages.noChild,'dayAverages')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/Average_Daily_child.tex','height','4in','width','6in');
boxPlots(dayAverages.e,dayAverages.d,dayAverages.c2,dayAverages.c1,dayAverages.b,dayAverages.a,'dayAverages')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/Average_Daily_socio.tex','height','4in','width','6in');

boxPlots(x_APOD.child,x_APOD.noChild,'APOD')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/APOD_child.tex');
boxPlots(x_APOD.e,x_APOD.d,x_APOD.c1,x_APOD.c2,x_APOD.b,x_APOD.a,'APOD')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/APOD_socio.tex','height','10in','width','8in');

boxPlots(x_POW_ratio.child,x_POW_ratio.noChild,'POW_ratio')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/POW_rat_child.tex','height','2in','width','3in');
boxPlots(x_POW_ratio.e,x_POW_ratio.d,x_POW_ratio.c1,x_POW_ratio.c2,x_POW_ratio.b,x_POW_ratio.a,'POW_ratio')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/POW_rat_socio.tex','height','2in','width','3in');

boxPlots(x_ADV.child,x_ADV.noChild,'ADV')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/ADV_child.tex','height','height','4in','width','6in');
boxPlots(x_ADV.e,x_ADV.d,x_ADV.c1,x_ADV.c1,x_ADV.b,x_ADV.a,'ADV')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/ADV_socio.tex','height','4in','width','6in');

boxPlots(x_corr.child,x_corr.noChild,'corr')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/Corr_child.tex');
boxPlots(x_corr.e,x_corr.d,x_corr.c2,x_corr.c1,x_corr.b,x_corr.a,'corr')
matlab2tikz('/Users/samstern/Uni/Honours_Project/Report/fig/Corr_socio.tex');