function [ swaps ] = bubble( the_list, varargin )
%BUBBLE sample input: bubble(randi([0 10000],1,25))
%outputs number of swaps required

ordered=0; %ordered is indicator for whether or not the entire array is in order
swaps=0; %swaps tracks number of swaps performed
t=[1:length(the_list)]; %plotting purposes

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
    if nargin > 1 && varargin{1}
        scatter(t,the_list) %plots
        drawnow %neccessary command for updating plot in real time
    end
end
if sorted==0 %if no sorts were made
    ordered=1; %array is in order
end
end

end

