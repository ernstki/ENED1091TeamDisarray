%% TestUpdateAxes: Test of passing figure handles to a function
%  Author:       Kevin Ernst
%  Date:         5 April 2013
%  Course:       ENED1091
%  Professor:    Dr. Bucks
%
%  Description:  Simple experiment to demonstrate how to create a figure and
%                pass its handle to a sort function.

function [] = TestUpdateAxes()

    % call bubblesort.m, passing a handle to a set of axes
    
    figh = figure();
    set(figh, 'DoubleBuffer', 'off')
    bubble(randi(100, 1, 25), true, figh);
    set(figh, 'DockControls', 'off');
    close(figh);

end % function [] = TestUpdateAxes()
% end TestUpdateAxes.m
% vim: tw=78 ts=4 sw=4 expandtab
