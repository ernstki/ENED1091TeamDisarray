function [ the_list ] = quicksort( the_list )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
pivotselect = [ the_list(1),
                the_list(length(the_list)),
                the_list(floor(length(the_list)/2)) ];
pivot = median(pivotselect);
%pivot_store = pivot;

while sum(the_list==pivot)>1
    pivot=randsample(the_list,1)
end

partition=1;

%While length from start to pivot >2
while partition==1
    flag_left=1;
    flag_right=1;
    while flag_left==1
        for n=1:length(the_list)
            if the_list(n)>=pivot
                more = the_list(n);
                more_pos = n;
                flag_left = 0;
                break;
            end
        end
    end
    
    while flag_right==1
        for m=0:(length(the_list)-1)
            if the_list(length(the_list)-m)<=pivot
                less = the_list(length(the_list) - m);
                less_pos = length(the_list)-m;
                flag_right = 0;
                break;
            end
        end
    end
    
        
    if more_pos>=less_pos
        partition = 0;
    end
    
    temp = the_list(more_pos);
    
    the_list(more_pos) = the_list(less_pos);
    
    the_list(less_pos) = temp;
end %while
%pivot_pos = find(the_list==pivot);

%     for each 'x' in 'array'
%        if 'x' ? 'pivot' then append 'x' to 'less'
%       else append 'x' to 'greater'
%  return concatenate(quicksort('less'), 'pivot', quicksort('greater')) // two recursive calls

end %function [ the_list ] = quicksort( the_list )


