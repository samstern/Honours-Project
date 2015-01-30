function [NewX,NewY] = EvenMyBinaryClasses(InputX,InputY)

%In particular when working with the binary classes
% the classes are much too unbalanced

% Need to reduce the imbalance

[a,b] = size(InputY);


UniqueElements = unique(InputY);

Ones = histc(InputY,UniqueElements(1));

Twos = histc(InputY,UniqueElements(2));


OnesBigger = Ones - Twos;

TwosBigger = Twos - Ones;

if (OnesBigger) > 0

    Final_Number_Of_elements = floor(Twos /(0.4));

    Final_Number_Of_Ones = floor(Final_Number_Of_elements*0.6);

    while Ones > Final_Number_Of_Ones
    
        elements_index = find(InputY == 1);
        
        the_index = randi(length(elements_index),1);
        
        InputX(elements_index(the_index),:) = [];
        InputY(elements_index(the_index),:) = [];
            
        Ones = histc(InputY,1);
        
    end



elseif (TwosBigger) > 0

    Final_Number_Of_elements = floor(Ones /(0.4));

    Final_Number_Of_Class2 = floor(Final_Number_Of_elements*0.6);

    while Twos > Final_Number_Of_Class2
    
       
        elements_index = find(InputY == 2);
        
        the_index = randi(length(elements_index),1);
        
        InputX(elements_index(the_index),:) = [];
        InputY(elements_index(the_index),:) = [];
            
        Twos = histc(InputY,2);
        
        
    end
end

NewX = InputX;
NewY = InputY;
    

end