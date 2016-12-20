% Speech Communication WS2016/WS2017
% Programming Homework I
% Sudarson Selvaraj - 387649
% Mikko Honkanen - 387608


clear variables; %deletes all variables in the workspace
close all; %closes all plots
clc; %clears the command window

% Let's read the audio file.
% y includes the samples, while Fs is the sample rate
[y, Fs] = audioread('13ZZ637A.wav');

% Let's calculate samples 100 ms
nbr_samples_in_hundred_ms = Fs * 0.1;

% Let's calculate ACF
autocorrelated_signal = autocorrelation(y,nbr_samples_in_hundred_ms);

% Let's plot the autocorrelated signal
figure();
x1 = linspace(0,0.1,nbr_samples_in_hundred_ms);
hold on;
xlabel('tau in seconds');
ylabel('rss');
title('ACF');
plot(x1,autocorrelated_signal');
hold off;

% The fundamental frequency can be seen from the second maximum, which
% indicates the period of the fundamental frequency. Visually seen, the second
% maximum is approximately at 0.008 seconds, which would mean that the
% fundmental frequency would be 125 Hz.

% Let's draw the graph with the maxima marked.
% We use 0.007 seconds as minPeakDistance, since it correlates to around
% 140Hz, which is close to the upper limit of the fundamental frequency of
% a male voice (which the sound file is).
figure();
hold on;
xlabel('tau in seconds');
ylabel('rss');
title('ACF with peaks');
findpeaks(autocorrelated_signal,x1,'MinPeakDistance',0.007);
hold off;

% calculate the mean fundamental frequency
[peak,location] = findpeaks(autocorrelated_signal,x1,'MinPeakDistance',0.007);
meanPeriod = mean(diff(location));

% Round the answer
meanFre = round(1/meanPeriod);
fprintf('The mean fundamental frequency is %d Hz, so its a male voice', meanFre);

% The mean fundamental frequency is around 122 Hz, so it is a male voice.

