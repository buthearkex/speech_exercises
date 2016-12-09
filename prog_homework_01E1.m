clear variables; %deletes all variables in the workspace
close all; %closes all plots
clc; %clears the command window

% Let's read the audio file.
% y includes the samples, while Fs is the sample rate
[y, Fs] = audioread('13ZZ637A.wav');

% Let's calculate samples 100 ms
nbr_samples_in_hundred_ms = Fs * 0.1;

% voiced_parts = unvoivoi(y,0.1*Fs,0.005,0.95); % not sure what the threshold values shold be
% 
% % Multiply the result of the unvoivoi function with your speech data 
% % to set unvoiced parts to zero
% voiced_signal = y.* voiced_parts;


% Let's calculate ACF
autocorrelated_signal = autocorrelation(y,nbr_samples_in_hundred_ms);%y,nbr_samples_in_hundred_ms);

% Matlab implementation for reference
%r = xcorr(y, y);

% Let's plot the autocorreltaed signal
x1 = linspace(0,0.1,nbr_samples_in_hundred_ms);
figure();
%subplot(2,1,1);
plot(x1,autocorrelated_signal');

% The fundamental frequency can be seen from the second maximum, which
% indicates the period of the fundamental frequency. Visually the second
% maximum is approximately at 0.008 seconds, which would mean that the
% fundmental frequency would be 125 Hz.

% Let's find the mean value for the period
findpeaks(autocorrelated_signal,x1,'MinPeakDistance',0.007);

[peak,location] = findpeaks(autocorrelated_signal,x1,'MinPeakDistance',0.007);
meanPeriod = mean(diff(location));
% accomodate for NaN here

meanFre = round(1/meanPeriod);
fprintf('The mean fundamental frequency is %d Hz', meanFre);

% The mean fundamental frequency is around 125 Hz, so it is a male voice.

