function [ output_args ] = MergeSort( input_args )
%Sample Sorting Algorithm
%MERGE SORT

%eventually make input the list that is wanted to be sorted

%right now only good for even numbered lists

list = [1,9,5,7,2,6]
%number list

n = length(list)/2
%gets the number in each sublist

sl1 = list(1:1:n)
%sets up first sublist

sl2 = list(n+1:1:length(list))
%sets up second sublist

sl1 = sort(sl1)
%sorts in ascending order
%NOW to do withOUT sort help

sl2 = sort(sl2)
%agains sorts
%NEED to do withOUT sort help

final_list = [sl1 + sl2]
%NOW to merge and then sort again. HELP

end

