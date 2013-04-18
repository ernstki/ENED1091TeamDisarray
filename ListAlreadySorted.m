%% ListAlreadySorted - return a vector of 'size' that's already sorted
%  Author:     Kevin Ernst
%  Date:       17 April 2013
%  Course:     ENED1091
%  Professor:  Dr. Bucks
%
% Return a list of length 'size', already sorted by MATLAB's internal
% sort() funtion, in ascending (second parameter 'ascend') or descending
% (second parameter 'descend') order.
function [list] = ListAlreadySorted(size, varargin)
    
    if nargin > 1
        switch varargin{1}
            case { 'ascend', 'descend' } % either one matches
                order = varargin{1}
            otherwise
                order = 'ascend'
        end % switch
        list = sort(randi(size, 1, size), order);
    end
    
end % function [list] = ListAlreadySorted(size, varargin)

% vim: tw=78 ts=4 sw=4 expandtab