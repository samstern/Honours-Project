x=x_filtered(121,:)/1000;
ts1=timeseries(x);
ts1.Time=ts1.Time+start;
ts1.TimeInfo.Format='days';
ts1.TimeInfo.StartDate = '00-Jan-0000';
ts1.TimeInfo.Units='days';
ts2=timeseries(x_gauss(75,:));
ts2.Time=ts2.Time+start;
ts2.TimeInfo.StartDate = '00-Jan-0000';
ts2.TimeInfo.Units='days';
ts2.data=ts2.Data/1000;
plot(ts1)
%plot(ts1,'color',[0.1,0.5,1]);
%plot(getsamples(ts1,(length(ts1.data)/4):2*length(ts1.data)/4));
hold on
%plot(ts2,'r');
title('One Week Electricity Consumption of Household #121')
ylabel('Power (Kilo Watts)')
xlabel('Time')
%legend('Unsmoothed','Convolved with Gaussian filter')