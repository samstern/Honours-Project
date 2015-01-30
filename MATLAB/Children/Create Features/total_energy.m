%% Total energy used each household in 4 week period

function [monthSum]=total_energy(numhouse,x_filtered,children_filtered,social_grade)
    monthSum.all=zeros(numhouse,1);
    j=1;
    k=1;
    
    monthSum.sgA=[];
    monthSum.sgB=[];
    monthSum.sgC1=[];
    monthSum.sgC2=[];
    monthSum.sgD=[];
    monthSum.sgE=[];
    for i = 1:numhouse
        monthSum.all(i)=sum(x_filtered(i,:));
        
        
        if children_filtered(i)==1
            monthSum.child(j)=monthSum.all(i);
            j=j+1;
        elseif children_filtered(i)==0
            monthSum.noChild(k)=monthSum.all(i);
            k=k+1;
        else
            'children not 1 or 0'
        end
        

        
        if social_grade(i)==1
            monthSum.sgE=[monthSum.sgE;monthSum.all(i)];
        elseif social_grade(i)==2
            monthSum.sgD=[monthSum.sgD;monthSum.all(i)];
        elseif social_grade(i)==3
            monthSum.sgC2=[monthSum.sgC2;monthSum.all(i)];
        elseif social_grade(i)==4
            monthSum.sgC1=[monthSum.sgC1;monthSum.all(i)];
        elseif social_grade(i)==5
            monthSum.sgB=[monthSum.sgB;monthSum.all(i)];
        elseif social_grade(i)==6
            monthSum.sgA=[monthSum.sgA;monthSum.all(i)];
        end
    end
end