function [ the_sorted_list, swaps ] = bubbleSort( the_list, varargin )
% 13SS_ENED1091 Team Disarray - bubbleSort by ipachra
%
%   Sample usage: bubble(randi([0 10000],1,25))
%
% INPUT ARGUMENTS:
%
%        the_list - an array to be sorted
%     varargin{1} - if true or non-zero, plot on the axes handle given by
%                   varargin{2}
%     varargin{2} - axes handle to plot results on
%
% OUTPUTS:
%
% the_sorted_list - the sorted input array
%           swaps - the number of swaps required
%

ordered=0;              % ordered is indicator for whether or not the entire
                        % array is in order
swaps=0;                % swaps tracks number of swaps performed
t=[1:length(the_list)]; % plotting purposes

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
        % FIXME: this will get tested for every iteration. Implement as a
        % completely separate (mostly duplicate) while loop, so that the
        % test is only performed once on invocation.
        if nargin > 1 && varargin{1}
            % If the second argument is a truthy value, then make a plot
            % If the third argument is a handle to a set of axes:
            if ishandle(varargin{1})
                fig_h = varargin{1}
                axes_h = get(fig_h, 'CurrentAxes')
                % Set the axes we're about to draw on to the current axes of
                % the figure handle we were given.
                axes(axes_h)
            end
            % Otherwise, just create a new figure (useful for testing)
            scatter(t,the_list) %plots
            drawnow %neccessary command for updating plot in real time
        end
    end
    if sorted==0 %if no sorts were made
        ordered=1; %array is in order
    end
end
the_sorted_list = the_list;

end % fuction bubble

