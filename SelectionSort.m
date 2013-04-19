%% SelectionSort.m: Selection sort implemented in MATLAB
%  Source:     http://rosettacode.org/wiki/Selection_sort#MATLAB_.2F_Octave
%              (lightly modified by Kevin Ernst)
%  Date:       17 April 2013
%  Course:     ENED1091
%  Professor:  Dr. Bucks

function [ list ] = SelectionSort(list, varargin)
% 13SS_ENED1091 Team Disarray - SelectionSort (Rosetta Code)
%
%   Sample usage: SelectionSort(randi([0 10000],1,25), true)
%
% INPUT ARGUMENTS:
%            list - an array to be sorted
%     varargin{1} - if true or non-zero, plot on the axes handle given by
%                   varargin{2}
%     varargin{2} - axes handle to plot results on (optional)
%                   if omitted, plots on a new set of axes
%
% OUTPUTS:
%            list - the sorted input array

listSize = numel(list);

for i = (1:listSize-1)

    minElem = list(i);
    minIndex = i;

    %This for loop can be vectorized, but there will be no significant
    %increase in sorting efficiency.
    for j = (i:listSize)    
        if list(j) <= minElem
            minElem = list(j);
            minIndex = j;
        end                              
    end

    if i ~= minIndex
        list([minIndex i]) = list([i minIndex]); %Swap
    end

    % Hand off the plotting to an external function:
    if nargin > 1 && varargin{1}
        AlgoPlot(list, varargin{:});
    end

end %for

end % function [ list ] = SelectionSort(list, varargin)
% end SelectionSort.m
% vim: tw=78 ts=4 sw=4 expandtab
