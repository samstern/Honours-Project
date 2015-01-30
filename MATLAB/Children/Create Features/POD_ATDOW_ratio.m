%% Part_of_Day/average total daily usage ratio

function pod_atd_ratio=POD_ATDOW_ratio(numhouse,x_POD,numPOD,dayAverages)
    pod_atd_ratio = zeros(size(x_POD));
    for i=1:numhouse
        divNum=1;
        pod_atd_ratio(i,1:3)=x_POD(i,1:3)/dayAverages(i,divNum);
        divNum=divNum+1;
        for j=4:4:numPOD
            pod_atd_ratio(i,(j:j+3))=x_POD(i,(j:j+3))/dayAverages(i,divNum);
            if divNum<7
                divNum=divNum+1;
            else
                divNum=1;
            end
        end
    end
end