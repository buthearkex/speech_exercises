clear variables; %deletes all variables in the workspace
close all; %closes all plots
clc; %clears the command window

[y, Fs] = audioread('13ZZ637A.wav');

% use the unvoivoi function to detect voiced and unvoiced speech segments

voiced_parts = unvoivoi(y,25e-3*Fs,0.005,0.95); % not sure what the threshold values shold be

% Multiply the result of the unvoivoi function with your speech data 
% to set unvoiced parts to zero

voiced_signal = y.* voiced_parts;

% Plot the audio signal and mark in the same plot the detected voiced speech
% segments
sound_length = size(y,1)/Fs;
x = linspace(0, sound_length, size(y,1));
figure();
plot(x,voiced_signal);

% Use the autocorrelation function on segments of the signal (windowsize: 100ms) and compute the
% fundamental frequency. Use a window shift of 25ms.



% Create a fundamental frequency vector and plot your pitch contour
