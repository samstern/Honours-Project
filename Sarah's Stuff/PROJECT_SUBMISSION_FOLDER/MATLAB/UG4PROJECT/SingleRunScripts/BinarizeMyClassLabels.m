function [BinaryClassVector] = BinarizeMyClassLabels(InputClassLabels)

[a,b] = size(InputClassLabels);
NewBinClassLabels = zeros(a,b);

% Class labels have to be positive integers for Feature Selection Methods
% In class 1 if there are 2 or less people in the house.
% In class 2 if there are 3 or more people in the house
for i =1:a
    if InputClassLabels(i) < 3
        NewBinClassLabels(i) = 1;
    else
        NewBinClassLabels(i) = 2;
    end
end

BinaryClassVector = NewBinClassLabels;
end
