%Correlation between weekdays
function x=WC(numhouse,x_filtered,children_filtered,social_grade)
    xH=toHours(x_filtered);
    xW=weeksplits(xH);
    x.all=calcCor(xW);
   [x.child,x.nchild]=split_children(numhouse,x,children_filtered);
   [x.a,x.b,x.c1,x.c2,x.d,x.e]=split_se(numhouse,x,social_grade);
    
end

function out=toHours(x_in)
    hourLen=6;
    out=cell2mat(arrayfun(@(x)sum(x_in(:,x:x+hourLen-1),2), 1:hourLen:size(x_in,2),'un',0));
end

function out=weeksplits(x)
    [numhouse,numpts]=size(x);
    dayLen=24;
    workdays=4;
    numweeks=4;
    %out=zeros(numhouse,workdays,dayLen);
    for i=1:numhouse
        weeksplit=reshape(x(i,:),numweeks,numpts/numweeks);
        weekdays=weeksplit(:,dayLen+1:(numpts/4)-dayLen);
        for week=1:numweeks
            out{i}{week}=reshape(weekdays(week,:),5,24);
        
        end
    end
end

function out=calcCor(x)
    for i=1:size(x,2)
       household=x{i};
       for j=1:size(household,2)
           a=corr(household{j}');
           b=arrayfun(@(m)(arrayfun(@(n)a(m,n),m+1:length(a))),1:length(a)-1,'uni',0);
           houseCorr(j,:)=[b{:}];
       end
       out(i,:)=mean(houseCorr);
    end
end

function [xc,xnc]=split_children(numhouse,x,children_filtered)
    xc=[];
    xnc=[];
    for i= 1:numhouse
        if children_filtered.all(i)==0
            xnc=[xnc;x.all(i,:)];
        elseif children_filtered.all(i)==1
            xc=[xc;x.all(i,:)];
        end
    end
end

function [xa,xb,xc1,xc2,xd,xe]=split_se(numhouse,x,social_grade)
    xa=[];
    xb=[];
    xc1=[];
    xc2=[];
    xd=[];
    xe=[];
    
    for i=1:numhouse
        if social_grade.all(i)==1
            xe=[xe;x.all(i,:)];
        elseif social_grade.all(i)==2
            xd=[xd;x.all(i,:)];
        elseif social_grade.all(i)==3
            xc2=[xc2;x.all(i,:)];
        elseif social_grade.all(i)==4
            xc1=[xc1;x.all(i,:)];
        elseif social_grade.all(i)==5
            xb=[xb;x.all(i,:)];
        elseif social_grade.all(i)==6
            xa=[xa;x.all(i,:)];
        end
    end
    
end