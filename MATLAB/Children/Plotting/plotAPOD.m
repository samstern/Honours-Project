
plot([1:28],x_APOD.all(1,:))
hold on
scatter([1:28],x_APOD.all(1,:),'r')
xlabel('part of day')
ylabel('average POD energy use')
podLable={'Sun' 'Sun' 'Sun' 'Sun' 'Mon' 'Mon' 'Mon' 'Mon' 'Tue' 'Tue' 'Tue' 'Tue' 'Wed' 'Wed' 'Wed' 'Wed' 'Tur' 'Tur' 'Tur' 'Tur' 'Fri' 'Fri' 'Fri' 'Fri' 'Sat' 'Sat' 'Sat' 'Sat'};
set(gca, 'XTick',1:28, 'XTickLabel',podLable)