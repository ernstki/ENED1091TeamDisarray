%% Quicksort.m: Quicksort sort implemented in MATLAB
%  Source:     http://rosettacode.org/wiki/Quicksort#MATLAB
%              (lightly modified by Kevin Ernst)
%  Date:       19 April 2013
%  Course:     ENED1091
%  Professor:  Dr. Bucks

function the_sorted_list = QuicksortVectorized(the_list, varargin)
 % 13SS_ENED1091 Team Disarray - Quicksort (Rosetta Code)
%
%   Sample usage: Quicksort(randi([0 10000],1,25), true)
%
% INPUT ARGUMENTS:
%        the_list - an array to be sorted
%     varargin{1} - if true or non-zero, plot on the axes handle given by
%                   varargin{2}
%     varargin{2} - axes handle to plot results on (optional)
%                   if omitted, plots on a new set of axes
%
% OUTPUTS:
% the_sorted_list - the sorted input array
    if numel(the_list) <= 1 %If the array has 1 element then it can't be sorted       
        the_sorted_list = the_list;
        return
    end
 
    pivot = the_list(end);
    the_list(end) = [];
 
    the_sorted_list = [QuicksortVectorized(the_list(the_list <= pivot)), ...
                       pivot, QuicksortVectorized(the_list(the_list > pivot))];
   
    % Hand off the plotting to an external function:
    % (note that this doesn't look too pretty for a recursive function)
    if nargin > 1 && varargin{1}
        AlgoPlot(the_list, varargin{:});
    end
 
end % function the_sorted_list = QuicksortVectorized(the_list, varargin)