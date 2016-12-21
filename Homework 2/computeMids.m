function [ mids ] = computeMids( freqs, edges )
%COMPUTEMIDS Computes the k mid-frequencies of the triangular filters
%  The function computeMids finds the closest frequency support point in
%  the linear frequency domain. It compares the frequency support points
%  in the vector freqs with the edges of the triangular filter in the 
%  vector edges.

% define the output vector mids which has the same dimensions as the vector
% edges.

mids = zeros(size(edges));

%% TODO



%% Set defined values
mids(1) = 1;
mids(1,end) = edges(1,end);


end

