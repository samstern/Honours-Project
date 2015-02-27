function scatterPlots(cx,ncx)
numpts=size(cx,2);


count=1;
ax(1)=gca;
for i=1:numpts
    for j=i:numpts
        ax(count) = axes('position',get(ax(1),'position'));
        count=count+1;
        scatter(cx(:,i),cx(:,j));
        hold on
        scatter(ncx(:,i),ncx(:,j));
        f = gcf;
        set(findobj(ax(count-1)),'Visible','off');
        set(f,'WindowKeyPressFcn',@scrollaxes)
        xlabel(i);
        ylabel(j);
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

