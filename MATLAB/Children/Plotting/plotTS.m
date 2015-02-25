function plotTS(x_filtered)
load('/Users/samstern/Uni/Honours_Project/MATLAB/data/ts.mat');
ts1.TimeInfo.StartDate = '00-Jan-0000';
ts1.TimeInfo.Units='days';
ts1.Name = 'Energy Used (Wats)';
yMax=30;
yMin=0;
yRange=[yMin,yMax];
%plot(ts1.getsamples(1:4032));
%clear ts
count=1;
ax(1)=gca;
    for j=1:length(ts)
        ts1=ts(j);
        ax(count) = axes('position',get(ax(1),'position'));
        count=count+1;
        ts1.TimeInfo.StartDate = '00-Jan-0000';
        ts1.TimeInfo.Units='days';
        ts1.Name = 'Energy Used (Wats)';
        m=mean(ts1.Data);
        ts1.Data=ts1.Data/m;
        plot(ts1);
        title(j);
        ylim(yRange);
        f = gcf;
        set(findobj(ax(count-1)),'Visible','off');
        set(f,'WindowKeyPressFcn',@scrollaxes)
    end
    
end

function scrollaxes(src,evt)

allax = findobj(src,'Type','Axes');

currax = findobj(src,'Type','Axes','Visible','on');

nextdownkey = allax([2:end 1]);

nextupkey = allax([end 1:end-1]);

if strcmp(evt.Key,'downarrow')

      set(findobj(currax),'Visible','off')

      set(findobj(nextdownkey(currax==allax)),'Visible','on');

elseif strcmp(evt.Key,'uparrow')

      set(findobj(currax),'Visible','off')

      set(findobj(nextupkey(currax==allax)),'Visible','on');

end
end