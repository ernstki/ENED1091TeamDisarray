%% InsertionSort.m: Insertion sort implemented in MATLAB
%  Source:     http://rosettacode.org/wiki/Insertion_sort#MATLAB_.2F_Octave
%              (lightly modified by Kevin Ernst)
%  Date:       17 April 2013
%  Course:     ENED1091
%  Professor:  Dr. Bucks

function [ list ] = InsertionSort(list, varargin)
% 13SS_ENED1091 Team Disarray - InsertionSort (Rosetta Code)
%
%   Sample usage: InsertionSort(randi([0 10000],1,25), true)
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

for i = (2:numel(list))

    value = list(i);
    j = i - 1;

    while (j >= 1) && (list(j) > value)
        list(j+1) = list(j);
        j = j-1;
    end

    list(j+1) = value;

    % Hand off the plotting to an external function:
    if nargin > 1 && varargin{1}
        AlgoPlot(list, varargin{:});
    end

    
end %for

end % function [ list ] = InsertionSort(list, varargin)
% end InsertionSort.m
% vim: tw=78 ts=4 sw=4 expandtab
