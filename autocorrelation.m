% Speech Communication WS2016/WS2017
% Programming Homework I
% Sudarson Selvaraj - 0387649
% Mikko Honkanen - 0387608

function [ r_ss ] = autocorrelation( signal, max_time_lag )
%AUTOCORRELATION  Computes the ACF.
%   The ACF is computed for all time shifts from 0 until max_time_lag. 
%   max_time_lag defines the maximum shift of the signal in samples (100
%   ms).

% initialize result array
r_ss = zeros(max_time_lag,1);

% max_time_lag in number of samples
for tau=1:max_time_lag
    sum = 0;
    for k=1+tau:size(signal) 
        sum = sum + signal(k) * signal (k-tau);
    end
    r_ss(tau) = (1/size(signal,1)) * sum;
end

end

