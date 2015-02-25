function plotChildTS(x_filtered,children,arg1,outliers)
load('/Users/samstern/Uni/Honours_Project/MATLAB/data/ts.mat');
ts(outliers)=[];
ts1.TimeInfo.StartDate = '00-Jan-0000';
ts1.TimeInfo.Units='days';
ts1.Name = 'Energy Used (Wats)';
yMax=20000;
yMin=0;
yRange=[yMin,yMax];
figure;
%plot(ts1.getsamples(1:4032));
%clear ts
count=1;
ax(1)=gca;
    for j=1:length(ts)
        if children(j)==arg1
            ts1=ts(j);
            ax(count) = axes('position',get(ax(1),'position'));
            count=count+1;
            ts1.TimeInfo.StartDate = '00-Jan-0000';
            ts1.TimeInfo.Units='days';
            ts1.Name = 'Energy Used (Wats)';
            ts1.Data=ts1.Data;
            plot(ts1);
            title([j,arg1]);
            ylim(yRange);
            f = gcf;
            set(findobj(ax(count-1)),'Visible','off');
            set(f,'WindowKeyPressFcn',@scrollaxes)
        end
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