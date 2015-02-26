function x=APOD(numhouse,x_POD,children_filtered,social_grade)
    
    vec_len=28;
    x.all=zeros(numhouse,vec_len);
    for i=1:numhouse
        x.all(i,:)= sumPOD(x_POD(i,:),vec_len);
    end
    
    means=mean(x.all);
    three_std=3*std(x.all);
    for i=1:numhouse
        for j=1:vec_len
            if x.all(i,j)>three_std(j)
               % x.all(i,j)=NaN;%means(j);
            end
        end
    end
   
    [x.child,x.noChild]=split_children(numhouse,x,children_filtered,vec_len);
    [x.a,x.b,x.c1,x.c2,x.d,x.e]=split_se(numhouse,x,social_grade);
 
end

function sums=sumPOD(vec,vec_len)
    sums=zeros(1,vec_len);
    counter=1;
    for i=1:length(vec)
        sums(counter)=sums(counter)+vec(i);
        if counter==vec_len
            counter=1;
        else 
            counter=counter+1;
        end
    end
end

function [xc,xnc]=split_children(numhouse,x,children_filtered,vec_len)
    xc=zeros(children_filtered.numChild,vec_len);
    xnc=zeros(children_filtered.numNoChild,vec_len);
    j=1;
    k=1;
    for i= 1:numhouse
        if children_filtered.all(i)==0
            xnc(j,:)=x.all(i,:);
            j=j+1;
        elseif children_filtered.all(i)==1
            xc(k,:)=x.all(i,:);
            k=k+1;
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
    