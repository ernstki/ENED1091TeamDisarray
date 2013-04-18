%% ListFewUnique - create a vector with many non-unique values
%  Author:     Kevin Ernst
%  Date:       17 April 2013
%  Course:     ENED1091
%  Professor:  Dr. Bucks
%
% Create a "shuffled" list where the values are in evenly-spaced increments
% of a divisor of the set size 
function [list] = ListFewUnique(size)

    SET_DIVISOR = 10; % How many chunks to break up the set size
    % This line basically takes the random input values and does a mod
    % SET_DIVISOR (e.g., mod 10) on them to yield only 10 unique values,
    % then scales those values back to the set size, such that all values
    % are within 1 and 'size' in SET_DIVISOR groupings.
    %
    % There is probably a more clever way to do this. I went with something
    % readable/intelligible instead.
    list = mod(randi(size, 1, size), SET_DIVISOR) .* (size/SET_DIVISOR);
    
end % function [list] = ListFewUnique(size)

% vim: tw=78 ts=4 sw=4 expandtab