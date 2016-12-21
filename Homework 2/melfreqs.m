function [ edges ] = melfreqs( fmin, fmax, k )
%MELFREQS Returns k+2 points in linear scale that are equally spaced on 
% mel-scale

%   Function computes k+2 points in the linear frequency domain that are
%   equally spaced on the mel- scale. fmin and fmax are the lowest 
%   and respectively highest frequency in the signal. k corresponds to the
%   number of auditory critical bands, i.e., 24.


%% Step 1: Transform fmax and fmin value into mel-frequency domain
mel_fmin = 2595 * log10(1+(fmin/700));
mel_fmax = 2595 * log10(1+(fmax/700));

%% Step 2: Compute a vector of equally spaced values in the mel-frequency domain ranging from the mel-fmin to the mel-fmax.
mel_freqs = linspace(mel_fmin, mel_fmax, k+2);


%% Step 3: Transform the values into the linear frequency domain.

% Set size of results array
edges = zeros(size(mel_freqs),1);

for i=1:size(mel_freqs)
    % TODO: correct the formula???
    edges(i) = 700 * (10.^(mel_freqs(i)/2595));
end


end

