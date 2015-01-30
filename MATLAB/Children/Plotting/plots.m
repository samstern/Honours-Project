function out = aveDayBoxplot(dayAveChild,dayAveNoChild)
    figure;
    ax1=subplot(1,2,1);
    boxplot(dayAveChild,'whisker',5)
    title('children')
    xlabel('day')
    ylabel('mean energy use')
    ax2=subplot(1,2,2);
    boxplot(dayAveNoChild,'whisker',5)
    xlabel('day')
    ylabel('mean energy use')    
    title('no children')
    
    linkaxes([ax1,ax2],'y')
    out=0;
end

function POD_Boxplot(a)
figure;
ax1=subplot(1,2,1);
childpod = [child_morning;child_afternoon;child_evening;child_night];
g1= [ones(size(child_morning));2*ones(size(child_afternoon));3*ones(size(child_evening));;4*ones(size(child_night))];
boxplot(childpod,g1)
ax2=subplot(1,2,2)
childlesspod = [childless_morning;childless_afternoon;childless_evening;childless_night];
g2= [ones(size(childless_morning));2*ones(size(childless_afternoon));3*ones(size(childless_evening));;4*ones(size(childless_night))];

boxplot(childlesspod,g2)
linkaxes([ax1,ax2],'y')
end