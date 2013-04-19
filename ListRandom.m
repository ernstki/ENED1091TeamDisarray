%% ListRandom - return a vector of pseudo-random values
%  Author:     Kevin Ernst
%  Date:       17 April 2013
%  Course:     ENED1091
%  Professor:  Dr. Bucks
%
% Return a list of length 'size' that's filled with random integers from 1
% to the set size (e.g., if size = 50, return 50 values between 1 and 50).
function [list] = ListRandom(size)
    
    list = randi(size, 1, size);
       
end % function [list] = ListRandom(size)

% vim: tw=78 ts=4 sw=4 expandtab