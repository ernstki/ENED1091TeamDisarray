%% AlgoPlot: Take a list (from one of the sorting algorithms) and plot it
%  Author:     Kevin Ernst
%  Date:       17 April 2013
%  Course:     ENED1091
%  Professor:  Dr. Bucks

function [] = AlgoPlot(the_list, varargin)
% Switched to using a variable 'stop_plotting' in the global 'handles'
% structure instead. Both work equally well.
%global STOP_PLOTTING BAR_OR_SCATTER;

handles = guidata(gcf);
%if STOP_PLOTTING
if handles.STOP_PLOTTING
    return
end

% Changed this to use the 'handles' structure instead, too.
%BAR_OR_SCATTER = 'bar';  % default plot format (unset to use scatter)

t = 1:length(the_list); % plotting purposes

% FIXME: This test runs for every iteration. Would be faster to test
% /once/ at invocation and choose between two (virtually identical)
% 'while' loops: one that plots and one that doesn't
if nargin == 3 && ishandle(varargin{2})
    % Set the axes we're about to draw on to the current axes of
    % the figure handle we were given.
    axes_h = varargin{2};
    %axes_h = get(fig_h, 'CurrentAxes')
    axes(axes_h);
end % three arguments
% Otherwise, just create a new figure (useful for testing)
switch handles.BAR_OR_SCATTER 
    case 'bar'
        bar(t, the_list) %plots
    otherwise % 'scatter' or anything else:
        scatter(t, the_list) %plots
end %switch
drawnow %neccessary command for updating plot in real time

end % function [] = AlgoPlot(the_list, varargin)
% end ERNST_LabX.m
% vim: tw=78 ts=4 sw=4 expandtab
