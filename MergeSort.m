%% 13SS_ENED1091 Team Disarray - MergeSort by ipachra
%
%   Sample usage: MergeSort(randi([0 10000],1,25), true)
%
% INPUT ARGUMENTS:
%
%            list - an array to be sorted
%     varargin{1} - if true or non-zero, plot on the axes handle given by
%                   varargin{2}
%     varargin{2} - axes handle to plot results on
%
% OUTPUTS:
%
%          result - the sorted input array
%

function [ result ] = MergeSort( list, varargin )

%eventually make input the list that is wanted to be sorted

if length(list) == 1
    result = list;
    return  %Returns the list and doesn't sort if there's only 1 value
end

middle     = floor(length(list)/2); %gets the number in each sublist
%sets up first sublist
left_list  = MergeSort(list(1:middle), varargin{1});
%sets up second sublist
right_list = MergeSort(list(middle+1:length(list)), varargin{1});

% Left and right list indices
li = 1;
ri = 1;
% Result: initialize as empty array
result = [];
t=[1:length(list)]; % plotting purposes

% While
while li <= length(left_list) || ri <= length(right_list)
    % If neither list index has reached the end, compare the item at the
    % current index in both lists. Put the lesser of the two at the end of
    % the 'result' vector.
    if li <= length(left_list) && ri <= length(right_list)
        if left_list(li) < right_list(ri)
            result(length(result) + 1 ) = left_list(li);
            li = li + 1;
        else
            result(length(result) + 1 ) = right_list(ri);
            ri = ri + 1;
        end
    elseif li <= length(left_list)
        % If there are some items remaining in the left list:
        result(length(result) + 1 ) = left_list(li);
        li = li + 1;
    else %if ri <= length(right_list)
        % There must be some items remaining in the right list:
        result(length(result) + 1 ) = right_list(ri);
        ri = ri + 1;
    end
    
    
    % Note: plotting doesn't work too well for a recursive function. Try the
    % iterative version instead.
    
    % Plot the results:
    % FIXME: This test runs for every iteration. Would be faster to test
    % /once/ at invocation and choose between two (virtually identical)
    % 'while' loops: one that plots and one that doesn't
    %if nargin > 1 && varargin{1}
    %    % If the second argument is a truthy value, then make a plot
    %    % If the third argument is a handle to a set of axes:
    %    if nargin == 3 && ishandle(varargin{2})
    %        % Set the axes we're about to draw on to the current axes of
    %        % the figure handle we were given.
    %        axes_h = varargin{2};
    %        %axes_h = get(fig_h, 'CurrentAxes')
    %        axes(axes_h);
    %    end
    %    % Otherwise, just create a new figure (useful for testing)
    %    bar(t, list) %plots
    %    drawnow %neccessary command for updating plot in real time
    %end
end %while

end % function MergeSort
% vim: tw=78 ts=4 sw=4 expandtab
