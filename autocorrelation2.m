function [ r_ss ] = autocorrelation2( signal, max_time_lag )
%AUTOCORRELATION  Computes the ACF.
%   The ACF is computed for all time shifts from 0 until max_time_lag. 
%   max_time_lag defines the maximum shift of the signal in samples (100
%   ms).


r_ss = zeros(max_time_lag,1);

% max_time_lag in number of samples
for tau=1:max_time_lag
    sum = 0;
    for k=1+tau:size(signal) - max_time_lag
        sum = sum + signal(k) * signal (k-tau);
    end
    
    r_ss(tau) = (1/max_time_lag) * sum; 
end

end

