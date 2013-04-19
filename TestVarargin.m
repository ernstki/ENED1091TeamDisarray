function [ output_args ] = TestVarargin( varargin )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Solution: "Passing varargin on to another function in MATLAB"
%           http://mem.bio.pitt.edu/node/70

disp(varargin)
TestVarargin( varargin{:} )

end

