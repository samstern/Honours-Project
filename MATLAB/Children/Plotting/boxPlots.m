function boxPlots(c_x,nc_x)
    figure;
    ax1=subplot(1,2,1);
    boxplot(c_x)
    title('children')
    xlabel('day')
    ax2=subplot(1,2,2);
    boxplot(nc_x)
    xlabel('day')
    ylabel('mean energy use')    
    title('no children')
    
    linkaxes([ax1,ax2],'y')
    out=0;
end
