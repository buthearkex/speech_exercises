function [ mids ] = computeMids( freqs, edges )
%COMPUTEMIDS Computes the k mid-frequencies of the triangular filters
%  The function computeMids finds the closest frequency support point in
%  the linear frequency domain. It compares the frequency support points
%  in the vector freqs with the edges of the triangular filter in the 
%  vector edges.

% define the output vector mids which has the same dimensions as the vector
% edges.

% Output vector has same dimensions as vector 'edges'
mids = zeros(size(edges));

%% Calculate the closest value of 'freqs' to each value in 'edges'

for i=1:size(edges)
    % Check if the frequency exists in the linear scale
    if edges(i) < min(freqs) || edges(i) > max(freqs)
        % skip the round
        continue;
    end
   
    diff = abs(freqs-edges(i))
    [id id] = min(diff) 
    mids(i) = freqs(id)
    
end

%% Set defined values
mids(1) = 1;
mids(1,end) = edges(1,end);


end

