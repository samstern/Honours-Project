function apodBoxPlots(c_x,nc_x)
    figure;
    count=1;
    times=['Morning','Afternoon','Evening','Night'];
    for i=1:4:28
        j=i:i+3;
        ax(count)=subplot(4,2,count);
        boxplot([c_x(:,j);nc_x(:,j)]);%,nc_x(:,j)]);


        if (i==1)
            title('Sunday');
        elseif(i==5)
            title('Monday');
        elseif(i==9)
            title('Tuesday');
        elseif(i==13)
            title('Wednesday');
        elseif(i==17)
            title('Thursday');
        elseif(i==21)
            title('Friday');
        elseif(i==25)
            title('Saturday');
        end
        ylabel('Energy Used')
        count=count+1;
        hold on
    end
end
    
