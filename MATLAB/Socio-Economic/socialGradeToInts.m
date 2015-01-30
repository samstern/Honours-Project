
%Converts Social Grade to integers in order to be used for higherarchial
%classification
function ints=socialGradeToInts(sg)
    sg=char(sg);
    ints = zeros(length(sg),1);
    for i=1:length(sg)
        if sg(i)=='E'
            ints(i,:)=1;
        elseif sg(i)=='D'
            ints(i,:)=2;
        elseif strcmp(sg(i,1:2),'C2')==1
            ints(i)=3;
        elseif strcmp(sg(i,1:2),'C1')==1
            ints(i)=4;
        elseif sg(i)=='B'
            ints(i)=5;
        elseif sg(i)=='A'
            ints(i)=6;
        else
            ints(i)=0;
        end
    end
end