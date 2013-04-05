function [ result ] = MergeSort( list )
%Sample Sorting Algorithm
%MERGE SORT

%eventually make input the list that is wanted to be sorted

if length(list) == 1
    result = list;
    return  %Returns the list and doesn't sort if there's only 1 value 
end

middle     = floor(length(list)/2); %gets the number in each sublist
left_list  = MergeSort(list(1:middle));              %sets up first sublist
right_list = MergeSort(list(middle+1:length(list))); %sets up second sublist

% Left and right list indices
li = 1;
ri = 1;
% Result: initialize as empty array
result = []; 

% While 
while li <= length(left_list) || ri <= length(right_list)
    if li <= length(left_list) && ri <= length(right_list)
        if left_list(li) < right_list(ri)
            result(length(result) + 1 ) = left_list(li); 
            li = li + 1;
        else 
            result(length(result) + 1 ) = right_list(ri);
            ri = ri + 1;
        end 
    elseif li <= length(left_list)
        result(length(result) + 1 ) = left_list(li);
        li = li + 1;
    elseif ri <= length(right_list)
        result(length(result) + 1 ) = right_list(ri);
        ri = ri + 1;
    end    
end %while 

return




end

