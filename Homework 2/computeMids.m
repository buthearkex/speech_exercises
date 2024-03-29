% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Sudarson Selvaraj - 387649
% %% Mikko Honkanen - 387608
% %% PROGRAMMING HOMEWORK II
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ mids ] = computeMids( freqs, edges )
%COMPUTEMIDS Computes the k mid-frequencies of the triangular filters
%  The function computeMids finds the closest frequency support point in
%  the linear frequency domain. It compares the frequency support points
%  in the vector freqs with the edges of the triangular filter in the 
%  vector edges.

% Output vector has same dimensions as vector 'edges'
mids = zeros(size(edges));

%% Calculate the closest value of 'freqs' to each value in 'edges'

for i=1:size(edges,2)

    % Calculate difference between edge and frequencies
    difference = abs(freqs-edges(i));
    % Take the index of the smallest difference
    [~, id] = min(difference);
    % Set the value with the smallest difference to the result array
    mids(i) = freqs(id);
    
end

%% Set defined values
mids(1) = 1;
mids(1,end) = edges(1,end);


end

