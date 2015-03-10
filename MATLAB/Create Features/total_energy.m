%% Total energy used each household in 4 week period

function [monthSum]=total_energy(numhouse,x_filtered,children_filtered,social_grade)
    monthSum.all=zeros(numhouse,1);
  
    j=1;
    k=1;
    
    monthSum.a=[];
    monthSum.b=[];
    monthSum.c1=[];
    monthSum.c2=[];
    monthSum.d=[];
    monthSum.e=[];
    monthSum.child=[];
    monthSum.noChild=[];
    for i = 1:numhouse
        monthSum.all(i)=sum(x_filtered(i,:));
        
        
        if children_filtered(i)==1
            monthSum.child=[monthSum.child;monthSum.all(i)];
            j=j+1;
        elseif children_filtered(i)==0
            monthSum.noChild=[monthSum.noChild;monthSum.all(i)];
            k=k+1;
        else
            'children not 1 or 0'
        end
        

        
        if social_grade(i)==1
            monthSum.e=[monthSum.e;monthSum.all(i)];
        elseif social_grade(i)==2
            monthSum.d=[monthSum.d;monthSum.all(i)];
        elseif social_grade(i)==3
            monthSum.c2=[monthSum.c2;monthSum.all(i)];
        elseif social_grade(i)==4
            monthSum.c1=[monthSum.c1;monthSum.all(i)];
        elseif social_grade(i)==5
            monthSum.b=[monthSum.b;monthSum.all(i)];
        elseif social_grade(i)==6
            monthSum.a=[monthSum.a;monthSum.all(i)];
        end
    end
end