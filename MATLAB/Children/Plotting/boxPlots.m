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
            boxplot(x,{'children','no children'})
            ylabel('Power (Watts)')
            title('Total Electricity Used in 4 Week Period')
        %dayAverages
        elseif strcmp(varargin{3},'dayAverages')
            intervals={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            intervals=[intervals;intervals];
            intervals=intervals(:);
            lables=repmat({'child','no child'},1,size(c_x,2));
            colors=repmat(['r','b'],1,size(c_x,2));
        
            figure;
            %boxplot(x,{intervals,lables},'color',colors,'factorgap',[5,2]);
            boxplot(x,{intervals,lables},'factorgap',[5,2]);
            title('Average Daily Electricity Consumption')
            ylabel('Power (Watts)')
         
        %POW_ratio    
        elseif strcmp(varargin{3},'POW_ratio')
            lables=repmat({'child','no child'},1,2);
            intervals={'Sat÷Weekday','Sun÷Weekday'};
            intervals=[intervals;intervals];
            intervals=intervals(:);
            boxplot(x,{intervals,lables})
            title('Average Weekend to Weekday Ratio')
            
        %APOD
        elseif strcmp(varargin{3},'APOD')
            yMax=2.6*(10^5);
            yMin=0;
            yRange=[yMin,yMax];
            dow={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            tod={'M','A','E','N'};
            tod=[tod;tod];
            tod=tod(:);
            lables=repmat({'child','no child'},1,4);
            j=1;
            for i=1:length(dow)
                p=x(:,j:j+7);
                j=j+8;
                subplot(3,3,i)
                boxplot(p,{tod,lables})
                ylim(yRange);
                ylabel('Power (Watts)')
                title(dow(i))
                
            end
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
            boxplot(x,{intervals,lables},'factorgap',[5,2]);
            title('Average Daily Variance');
            ylabel('$\sigma$','interpreter','latex','fontsize',15)

            
        %corr
        elseif strcmp(varargin{3},'corr')
            t={'(Mon,Tue)','(Mon,Wed)','(Mon,Thu)','(Mon,Fri)','(Tue,Wed)','(Tue,Thu)','(Tue,Fri)','(Wed,Thu)','(Wed,Fri)','(Thu,Fri)'};
            for i=1:numFeatures
                p=x(:,i:numFeatures:numFeatures*2);
                subplot(2,5,i)
                boxplot(p,'labels',{'chile','no child'})
                title(t(i));  
                ylim([-1,1])
                annotation('textbox', [0.4 0.9 0.9 0.1],  'String', 'Correlation between Weekdays ($\rho$)','EdgeColor', 'none','interpreter','latex')
                %ylabel('Correlation ($\rho$)','interpreter','latex')%,'fontsize',5)
            end
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
        boxplot(x,'labels',{'E','D','C1','C2','B','A'})
        title('Total Electricity Used in 4 Week Period')
        ylabel('Power (Watts)')
        xlabel('Socio-Economic Class')
        
        %dayAverages
        elseif strcmp(varargin{7},'dayAverages')
            dow={'Sun','Mon','Tue','Wed','Thur','Fri','Sat'};
            for i=1:numFeatures
                p=x(:,i:numFeatures:numFeatures*6)
                subplot(3,3,i)
                boxplot(p,'labels',{'E','D','C1','C2','B','A'});
                t=sprintf('Average Total Electricity used on %s', dow{i});
                title(t)
                ylabel('Power (Watts)')
            end
            
        % POW_rtaio
        elseif strcmp(varargin{7},'POW_ratio')
            lab={'E','D','C1','C2','B','A'};
            lab=repmat(lab',2)
            lab=lab(:,1)
            intervals={'Sat','Sun'};
            intervals=[intervals;intervals;intervals;intervals;intervals;intervals];
            intervals=intervals(:)
            boxplot(x,{lab,intervals})
            title('Average Weekend to Weekday Ratio')
            xlabel('$\frac{Consumption of Day}{Average Weekday Use}$','interpreter','latex','fontsize',15)
     
          
        %APOD
        elseif strcmp(varargin{7},'APOD')
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
                p=x(:,j:j+5);
                boxplot(p,lables)
                annotation('textbox', [0.4 0.9 0.9 0.1],  'String', 'Average Power for Each Part of Day','EdgeColor', 'none','fontweight','bold')
                j=j+6;
                if sum(i==([1:4:28]))==1
                    ylabel(dow{k});
                    k=k+1;
                end
                if sum(i==([1:4]))==1
                    title(tod{i});
                end
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
                boxplot(p,'labels',{'E','D','C1','C2','B','A'})
                t=sprintf('Average Variance on %s', dow{i});
                title(t)
                ylabel('$\sigma$','interpreter','latex','fontsize',15)
            end
        %corr
        elseif strcmp(varargin{7},'corr')
            t={'(Mon,Tue)','(Mon,Wed)','(Mon,Thu)','(Mon,Fri)','(Tue,Wed)','(Tue,Thu)','(Tue,Fri)','(Wed,Thu)','(Wed,Fri)','(Thu,Fri)'};
            for i=1:numFeatures
                p=x(:,i:numFeatures:numFeatures*6);
                subplot(2,5,i)
                boxplot(p,'labels',{'E','D','C1','C2','B','A'})
                ylim([-1,1])
                title(t(i));  
                annotation('textbox', [0.4 0.9 0.9 0.1],  'String', 'Correlation between Weekdays ($\rho$)','EdgeColor', 'none','interpreter','latex')
                %ylabel('Correlation ($\rho$)','interpreter','latex')%,'fontsize',5)
            end
        end
        
    end
    %ylabel('Energy (Watts)')
end

