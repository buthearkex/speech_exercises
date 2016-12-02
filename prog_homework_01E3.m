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


hold on;
for i = 1:size(y)
   if voiced_signal(i) ~= 0
      if voiced_signal(i-1) == 0 || voiced_signal(i+1) == 0
          line([x(i) x(i)], [0 1],'color','r');
      end
   end
end

plot(x,y);
hold off;

% Use the autocorrelation function on segments of the signal (windowsize: 100ms) and compute the
% fundamental frequency. Use a window shift of 25ms.

% Convert 25ms and 100ms to samples
samples_in_25ms = Fs * 0.025;
samples_in_100ms = Fs * 0.1;

% divide signal into 25ms pieces
amount_of_sliding_windows = floor(size(y)/samples_in_25ms);

x2 = linspace(0,size(y)/Fs, amount_of_sliding_windows);

pitch_contour = zeros(amount_of_sliding_windows);

for i = 1:size(y):samples_in_25ms
    pitch_contour(i) = autocorrelation2(signal(i:end), samples_in_100ms);
end

% Create a fundamental frequency vector and plot your pitch contour
