function [ the_sorted_list, swaps ] = BubbleSort( the_list, varargin )
% 13SS_ENED1091 Team Disarray - bubbleSort by ipachra
%
%   Sample usage: BubbleSort(randi([0 10000],1,25), true)
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
%           swaps - the number of swaps required
%
global STOP_PLOTTING;
ordered=0;              % ordered is indicator for whether or not the entire
                        % array is in order
swaps=0;                % swaps tracks number of swaps performed
    
% Test to see if the user wants to stop plotting.
if STOP_PLOTTING
    return
end

while ordered==0 %while array is not in order
    sorted=0; %tracks number of sorts per k
    for k=1:(length(the_list)-1)
        if the_list(k)>the_list(k+1)
            temp=the_list(k);
            the_list(k)=the_list(k+1);
            the_list(k+1)=temp;
            sorted=sorted+1;
            swaps=swaps+1;
        end
    end % for

    % Hand off the plotting to an external function:
    if nargin > 1 && varargin{1}
        AlgoPlot(the_list, varargin{:});
    end

    if sorted==0 %if no sorts were made
        ordered=1; %array is in order
    end
end
the_sorted_list = the_list;

end % fuction BubbbleSort

