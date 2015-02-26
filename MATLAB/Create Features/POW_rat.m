%part of week ratio

function x=POW_rat(numhouse,monthSum,dayAverages,children_filtered,social_grade)
    weeklyAve=monthSum.all/4;
    for i=1:numhouse
       pow(i,:)=[sum(dayAverages.all(i,2:5)),dayAverages.all(i,6),dayAverages.all(i,1)]; 
       %x.all(i,:)=[pow(i,:)/weeklyAve(i),pow(i,2)/pow(i,1),pow(i,3)/pow(i,1)]; %x(i,1) is weekday/week_mean, x(i,2) is saturday.week_mean, x(i,3) is sunday/week_mean, x(i,4) is sat/week, x(i,5) is sun/week 
        x.all(i,:)=[pow(i,2)/pow(i,1),pow(i,3)/pow(i,1)];
    end
    
    [x.child,x.noChild]=split_children(numhouse,x,children_filtered);
    [x.a,x.b,x.c1,x.c2,x.d,x.e]=split_se(numhouse,x,social_grade);
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