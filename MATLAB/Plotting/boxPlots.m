function boxPlots(varargin)
    numFeatures=size(varargin{1},2);
    %% Children
    if length(varargin)==3
        c_x=varargin{1};
        nc_x=varargin{2};
        meanC=mean(c_x);
        while size(c_x,1)<size(nc_x,1)
            c_x=[c_x;NaN(1,size(c_x,2))];
        end
        size(nc_x);
        x=[];
        for i=1:size(c_x,2)
            x=[x,c_x(:,i),nc_x(:,i)];
        end
        %monthSum
        if strcmp(varargin{3},'monthSum')
            H=boxplot(x,{'children','no children'});
            set(H(6,2),'color','g','linewidth',1)
            ylabel('Power (Watts)')
            title('Total Electricity Used in 4 Week Period')
            %dayAverages
        elseif strcmp(varargin{3},'dayAverages')
            intervals={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            intervals=[intervals;intervals];
            intervals=intervals(:);
            lables=repmat({'c','nc'},1,size(c_x,2));
            figure;
            %boxplot(x,{intervals,lables},'color',colors,'factorgap',[5,2]);
            H=boxplot(x,{intervals,lables});
            set(H(6,[2:2:size(x,2)]),'color','g','linewidth',1)
            title('Average Daily Electricity Consumption')
            xtix = {'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            xtixloc = [1.5:2:27.5];
            set(gca,'XTickMode','auto','XTickLabel',xtix,'XTick',xtixloc);
            hLegend = legend(findall(gca,'Tag','Box'), {'Children','No Children'},'Orientation','Horizontal');
            hChildren = findall(get(hLegend,'Children'), 'Type','Line');
            set(hChildren(2),'Color','r')
            set(hChildren(4),'Color','g')
            %ylabel('Power (Watts)')
            %POW_ratio
        elseif strcmp(varargin{3},'POW_ratio')
            lables=repmat({'child','no child'},1,2);
            intervals={'Satint','Sunint'};
            intervals=[intervals;intervals];
            intervals=intervals(:);
            H=boxplot(x,{intervals,lables});
            set(H(6,[2:2:size(x,2)]),'color','g','linewidth',1)
            xtix = {'Sat÷Weekday','Sun÷Weekday'};
            xtixloc = [1.5:2:27.5];
            set(gca,'XTickMode','auto','XTickLabel',xtix,'XTick',xtixloc);
            title('Average Weekend to Weekday Ratio')
            hLegend = legend(findall(gca,'Tag','Box'), {'Children','No Children'});
            hChildren = findall(get(hLegend,'Children'), 'Type','Line');
            set(hChildren(4),'Color','r')
            set(hChildren(2),'Color','g')
            %APOD
        elseif strcmp(varargin{3},'APOD')
            yMax=2.6*(10^5);
            yMin=0;
            yRange=[yMin,yMax];
            dow={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            tod={'M','D','E','N'};
            tod=[tod;tod];
            tod=tod(:);
            lables=repmat({'Child','No Child'},1,4);
            j=1;
            for i=1:length(dow)
                p=x(:,j:j+7);
                j=j+8;
                subplot(3,3,i)
                H=boxplot(p,{tod,lables});
                set(H(6,[2:2:size(p,2)]),'color','g','linewidth',1)
                xtix = {'M','D','E','N'};
                xtixloc = [1.5:2:8.5];
                set(gca,'XTickMode','auto','XTickLabel',xtix,'XTick',xtixloc);
                %ylim(yRange);
                %ylabel('Power (Watts)')
                title(dow(i))
            end
            hLegend = legend(findall(gca,'Tag','Box'), {'Children','No Children'},'orientation','horizontal');
            hChildren = findall(get(hLegend,'Children'), 'Type','Line');
            sh=subplot(3,3,(length(dow)+1));
            sp=get(sh,'position');
            set(hLegend,'position',sp);
            delete(sh);
            set(hChildren(4),'Color','r')
            set(hChildren(2),'Color','g')
            %ADV
        elseif strcmp(varargin{3},'ADV')
            x(find(isnan(x)))=0;
            %isnan(x).*x
            m=mean(std(x));
            %x=x.*(x<(3*m));
            nulify=find(or((x>3*m),x==0));
            x(nulify)=NaN;
            intervals={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            intervals=[intervals;intervals];
            intervals=intervals(:);
            lables=repmat({'child','no child'},1,size(c_x,2));
            %H=boxplot(x,{intervals,lables},'factorgap',[5,2]);
            H=boxplot(x,{intervals,lables});
            set(H(6,[2:2:size(x,2)]),'color','g','linewidth',1)
            xtix = {'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            xtixloc = [1.5:2:27.5];
            set(gca,'XTickMode','auto','XTickLabel',xtix,'XTick',xtixloc);
            title('Average Daily Standard Deviation');
            ylabel('$\sigma$','interpreter','latex','fontsize',15)
            set(gca,'XTickMode','auto','XTickLabel',xtix,'XTick',xtixloc);
            hLegend = legend(findall(gca,'Tag','Box'), {'Children','No Children'},'Location','Southeast');
            hChildren = findall(get(hLegend,'Children'), 'Type','Line');
            set(hChildren(2),'Color','r')
            set(hChildren(4),'Color','g')
            %log ADV
        elseif strcmp(varargin{3},'log ADV')
            x=log(x);
            x(find(isnan(x)))=0;
            %isnan(x).*x
            m=mean(std(x));
            %x=x.*(x<(3*m));
            nulify=find(or((x>3*m),x==0));
            x(nulify)=NaN;
            intervals={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            intervals=[intervals;intervals];
            intervals=intervals(:);
            lables=repmat({'child','no child'},1,size(c_x,2));
            boxplot(x,{intervals,lables},'factorgap',[5,2]);
            title('Average Daily Variance');
            ylabel('log($\sigma$)','interpreter','latex','fontsize',15)
            %corr
        elseif strcmp(varargin{3},'corr')
            t={'(Mon,Tue)','(Mon,Wed)','(Mon,Thu)','(Mon,Fri)','(Tue,Wed)','(Tue,Thu)','(Tue,Fri)','(Wed,Thu)','(Wed,Fri)','(Thu,Fri)'};
            for i=1:numFeatures
                p=x(:,i:numFeatures:numFeatures*2);
                subplot(2,5,i)
                H=boxplot(p,'labels',{'Child','No Child'});
                set(H(6,[2:2:size(p,2)]),'color','g','linewidth',1)
                set(gca,'XTickMode','auto','XTickLabel',' ');
                title(t(i));
                ylim([-1,1])
                annotation('textbox', [0.4 0.9 0.9 0.1], 'String', 'Correlation between Weekdays ($\rho$)','EdgeColor', 'none','interpreter','latex')
                %ylabel('Correlation ($\rho$)','interpreter','latex')%,'fontsize',5)
                
            end
             hLegend = legend(findall(gca,'Tag','Box'), {'Children','No Children'},'Location','Southoutside','Orientation','horizontal');
            hChildren = findall(get(hLegend,'Children'), 'Type','Line');
            set(hChildren(2),'Color','r')
            set(hChildren(4),'Color','g')
            %fourier
        elseif strcmp(varargin{3},'fourier')
            intervals={'c1','c2','c3','c4','c5'};
            intervals=[intervals;intervals];
            intervals=intervals(:);
            lables=repmat({'child','no child'},1,size(c_x,2));
            boxplot(x,{intervals,lables},'factorgap',[5,2]);
            title('Frequancy Domain Features')
            ylabel('Amplitude')
        end
        %% social grade
    elseif length(varargin)==7
        maxLen=max([length(varargin{1}),length(varargin{2}),length(varargin{3}),length(varargin{4}),length(varargin{5}),length(varargin{6})]);
        x=nan(maxLen,6*numFeatures);
        count=1;
        for i=1:6
            x(1:length(varargin{i}),count:count+numFeatures-1)=varargin{i};
            count=count+numFeatures;
        end
        %monthSum
        if strcmp(varargin{7},'monthSum')
            H=boxplot(x,'labels',{'E','D','C1','C2','B','A'});
            set(H(6,2),'color','g','linewidth',1)
            set(H(6,3),'color','b','linewidth',1)
            set(H(6,4),'color','k','linewidth',1)
            set(H(6,5),'color','y','linewidth',1)
            set(H(6,6),'color','m','linewidth',1)
            title('Total Electricity Used in 4 Week Period')
            ylabel('Power (Watts)')
            xlabel('Socio-Economic Class')
            %dayAverages
        elseif strcmp(varargin{7},'dayAverages')
            dow={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            for i=1:numFeatures
                p=x(:,i:numFeatures:numFeatures*6);
                subplot(3,3,i)
                H=boxplot(p,'labels',{'E','D','C1','C2','B','A'});
                set(H(6,2),'color','g','linewidth',1)
                set(H(6,3),'color','b','linewidth',1)
                set(H(6,4),'color','k','linewidth',1)
                set(H(6,5),'color','y','linewidth',1)
                set(H(6,6),'color','m','linewidth',1)
                t=sprintf(dow{i});
                title(t)
                %ylabel('Power (Watts)')
            end
            hLegend = legend(findall(gca,'Tag','Box'), {'E','D','C1','C2','B','A'},'Orientation','Horizontal');
            hChildren = findall(get(hLegend,'Children'), 'Type','Line');
            sh=subplot(3,3,(numFeatures+1));
            sp=get(sh,'position');
            set(hLegend,'position',sp);
            delete(sh);
            set(hChildren(12),'Color','r')
            set(hChildren(10),'Color','g')
            set(hChildren(8),'Color','b')
            set(hChildren(6),'Color','k')
            set(hChildren(4),'Color','y')
            set(hChildren(2),'Color','m')
            
            
            % POW_rtaio
        elseif strcmp(varargin{7},'POW_ratio')
            lab={'E','D','C1','C2','B','A'};
            lab=repmat(lab',2)
            lab=lab(:,1)
            intervals={'Sat','Sun'};
            intervals=[intervals;intervals;intervals;intervals;intervals;intervals];
            intervals=intervals(:);
            p1=x(:,1:2:numFeatures*6);
            p2=x(:,2:2:numFeatures*6);
            p=[p1 p2];
            size(p);
            H=boxplot(p,{intervals,lab});
            set(H(6,[2,8]),'color','g','linewidth',1)
                set(H(6,[3,9]),'color','b','linewidth',1)
                set(H(6,[4,10]),'color','k','linewidth',1)
                set(H(6,[5,11]),'color','y','linewidth',1)
                set(H(6,[6,12]),'color','m','linewidth',1)
            title('Average Weekend to Weekday Ratio')
            xtix = {'Sat÷Weekday','Sun÷Weekday'};
            xtixloc = [3.6,9.5];
            set(gca,'XTickMode','auto','XTickLabel',xtix,'XTick',xtixloc);
            hLegend = legend(findall(gca,'Tag','Box'), {'E','D','C1','C2','B','A'},'Orientation','Horizontal');
            hChildren = findall(get(hLegend,'Children'), 'Type','Line');
            set(hChildren(12),'Color','r')
            set(hChildren(10),'Color','g')
            set(hChildren(8),'Color','b')
            set(hChildren(6),'Color','k')
            set(hChildren(4),'Color','y')
            set(hChildren(2),'Color','m')
            
            %xlabel('$\frac{Consumption of Day}{Average Weekday Use}$','interpreter','latex','fontsize',15)
            %APOD
        elseif strcmp(varargin{7},'APOD')
            size(x(:,1))
            figure;
            yMax=2.6*(10^5);
            yMin=0;
            yRange=[yMin,yMax];
            dow={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            tod={'Morning','Afternoon','Evening','Night'};
            lables={'E','D','C1','C2','B','A'};
            j=1;
            k=1;
            for i=1:numFeatures
                subplot(7,4,i)
                p=x(:,j:numFeatures:numFeatures*6);
                H=boxplot(p,lables);
                %ylim(yRange);
                annotation('textbox', [0.4 0.9 0.9 0.1], 'String', 'Average Power for Each Part of Day','EdgeColor', 'none','fontweight','bold')
                j=j+1;
                if sum(i==([1:4:28]))==1
                    ylabel(dow{k});
                    k=k+1;
                end
                if sum(i==([1:4]))==1
                    title(tod{i});
                end
                set(H(6,2),'color','g','linewidth',1)
                set(H(6,3),'color','b','linewidth',1)
                set(H(6,4),'color','k','linewidth',1)
                set(H(6,5),'color','y','linewidth',1)
                set(H(6,6),'color','m','linewidth',1)
            end
            %ADV
        elseif strcmp(varargin{7},'ADV')
            x(find(isnan(x)))=0;
            %isnan(x).*x
            m=mean(std(x));
            %x=x.*(x<(3*m));
            nulify=find(or((x>3*m),x==0));
            x(nulify)=NaN;
            dow={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            for i=1:numFeatures
                p=x(:,i:numFeatures:numFeatures*6);
                subplot(3,3,i)
                H=boxplot(p,'labels',{'E','D','C1','C2','B','A'});
                set(H(6,2),'color','g','linewidth',1)
                set(H(6,3),'color','b','linewidth',1)
                set(H(6,4),'color','k','linewidth',1)
                set(H(6,5),'color','y','linewidth',1)
                set(H(6,6),'color','m','linewidth',1)
                t=sprintf('Average Variance on %s', dow{i});
                title(t)
                ylabel('$\sigma$','interpreter','latex','fontsize',15)
            end
            hLegend = legend(findall(gca,'Tag','Box'), {'E','D','C1','C2','B','A'},'orientation','horizontal');
            hChildren = findall(get(hLegend,'Children'), 'Type','Line');
            sh=subplot(3,3,(numFeatures+1));
            sp=get(sh,'position');
            set(hLegend,'position',sp);
            delete(sh);
            set(hChildren(12),'Color','r')
            set(hChildren(10),'Color','g')
            set(hChildren(8),'Color','b')
            set(hChildren(6),'Color','k')
            set(hChildren(4),'Color','y')
            set(hChildren(2),'Color','m')
            
            
            %log ADV
        elseif strcmp(varargin{7},'log ADV')
            x=log(x);
            x(find(isnan(x)))=0;
            %isnan(x).*x
            m=mean(std(x));
            %x=x.*(x<(3*m));
            nulify=find(or((x>3*m),x==0));
            x(nulify)=NaN;
            dow={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            for i=1:numFeatures
                p=x(:,i:numFeatures:numFeatures*6);
                subplot(3,3,i)
                
                boxplot(p,'labels',{'E','D','C1','C2','B','A'})
                t=sprintf('Average Variance on %s', dow{i});
                title(t)
                ylabel('log($\sigma$)','interpreter','latex','fontsize',15)
            end
            %corr
        elseif strcmp(varargin{7},'corr')
            t={'(Mon,Tue)','(Mon,Wed)','(Mon,Thu)','(Mon,Fri)','(Tue,Wed)','(Tue,Thu)','(Tue,Fri)','(Wed,Thu)','(Wed,Fri)','(Thu,Fri)'};
            for i=1:numFeatures
                p=x(:,i:numFeatures:numFeatures*6);
                subplot(2,5,i)
                H=boxplot(p,'labels',{'E','D','C1','C2','B','A'});
            set(H(6,2),'color','g','linewidth',1)
            set(H(6,3),'color','b','linewidth',1)
            set(H(6,4),'color','k','linewidth',1)
            set(H(6,5),'color','y','linewidth',1)
            set(H(6,6),'color','m','linewidth',1)
            set(gca,'XTickMode','auto','XTickLabel',' ');
                %ylim([-1,1])
                title(t(i));
                annotation('textbox', [0.4 0.9 0.9 0.1], 'String', 'Correlation between Weekdays ($\rho$)','EdgeColor', 'none','interpreter','latex')
                %ylabel('Correlation ($\rho$)','interpreter','latex')%,'fontsize',5)
            end
            
            hLegend = legend(findall(gca,'Tag','Box'), {'E','D','C1','C2','B','A'},'orientation','horizontal');
            hChildren = findall(get(hLegend,'Children'), 'Type','Line');
            %sh=subplot(3,3,(numFeatures+1));
            %sp=get(sh,'position');
            %set(hLegend,'position',sp);
            %delete(sh);
            set(hChildren(12),'Color','r')
            set(hChildren(10),'Color','g')
            set(hChildren(8),'Color','b')
            set(hChildren(6),'Color','k')
            set(hChildren(4),'Color','y')
            set(hChildren(2),'Color','m')
            %fourier
        elseif strcmp(varargin{7},'fourier')
            for i=1:numFeatures
                p=x(:,i:numFeatures:numFeatures*6);
                subplot(1,5,i)
                boxplot(p,'labels',{'E','D','C1','C2','B','A'})
            end
        end
    end
    %ylabel('Energy (Watts)')
end
