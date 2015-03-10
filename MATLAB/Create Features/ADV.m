%% Average total varianceeach day of the week for each household
function dayStd = ADV(numhouse,daylength,numpts,x_filtered,children_filtered,social_grade)

    dayStd.all = zeros(numhouse,7);
    for i = 1:numhouse
        k=1;
        for j=1:daylength:numpts
        dayStd.all(i,k)=dayStd.all(i,k)+var(x_filtered(i,j:j+daylength-1));
        k=k+1;
            if k==8
                k=1;
            end
        end
    end
    
    
    dayStd.all=dayStd.all/daylength;
    dayStd.child = zeros(children_filtered.numChild,7);
    dayStd.noChild = zeros(children_filtered.numNoChild,7);
    j=1;
    k=1;
    
    dayStd.a=[];
    dayStd.b=[];
    dayStd.c1=[];
    dayStd.c2=[];
    dayStd.d=[];
    dayStd.e=[];
    
    for i= 1:numhouse
        if children_filtered.all(i)==0
            dayStd.noChild(j,:)=dayStd.all(i,:);
            j=j+1;
        elseif children_filtered.all(i)==1
            dayStd.child(k,:)=dayStd.all(i,:);
            k=k+1;
        end
        
        if social_grade.all(i)==1
            dayStd.e=[dayStd.e;dayStd.all(i,:)];
        elseif social_grade.all(i)==2
            dayStd.d=[dayStd.d;dayStd.all(i,:)];
        elseif social_grade.all(i)==3
            dayStd.c2=[dayStd.c2;dayStd.all(i,:)];
        elseif social_grade.all(i)==4
            dayStd.c1=[dayStd.c1;dayStd.all(i,:)];
        elseif social_grade.all(i)==5
            dayStd.b=[dayStd.b;dayStd.all(i,:)];
        elseif social_grade.all(i)==6
            dayStd.a=[dayStd.a;dayStd.all(i,:)];
        end
    end
end