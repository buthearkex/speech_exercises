% Speech Communication WS2016/WS2017
% Programming Homework I
% Sudarson Selvaraj - 387649
% Mikko Honkanen - 387608

clear variables; %deletes all variables in the workspace
close all; %closes all plots
clc; %clears the command window

% read in file
[y, Fs] = audioread('13ZZ637A.wav');

% use the unvoivoi function to detect voiced and unvoiced speech segments
voiced_parts = unvoivoi(y,0.1*Fs,0.01,0.9);

% Multiply the result of the unvoivoi function with your speech data 
% to set unvoiced parts to zero
voiced_signal = y.* voiced_parts;

% Plot the audio signal and mark in the same plot the detected voiced speech
% segments
sound_length = size(y,1)/Fs;
x = linspace(0, sound_length, size(y,1));
figure();

% variables for marking unvoiced segments
last_unvoiced = 1; % sample number of last unvoiced sample in last unvoised segment
first_unvoiced = 1; % sample number of first unvoiced sample in the last unvoised segment

% unvoiced is plotted with different color as well(red)
hold on;
xlabel('Time in seconds');
ylabel('Amplitude');
title('Original Signal + voiced segments');
plot(x,y, 'color', 'r');
plot(x,voiced_signal,'color','b');

% drawing vertical bars at end and beginning of voiced parts
for i = 1:size(y)
   if voiced_signal(i) ~= 0
      if voiced_signal(i-1) == 0 || voiced_signal(i+1) == 0
           line([x(i) x(i)], [0 1],'color','r');
          
          if voiced_signal(i-1) == 0
              % we're at the beginning of the voiced part
              last_unvoiced = i-1;
              line([x(first_unvoiced) x(last_unvoiced)], [0 0],'color','r');
          else
              % we're at end of the voiced part
              first_unvoiced = i+1;
          end
      end
   end
end

hold off;


% Convert 25ms and 100ms to samples
samples_in_25ms = Fs * 0.025;
samples_in_100ms = Fs * 0.1;

% space for calculating pitch contour
peak_space = linspace(0,0.1,samples_in_100ms);

% divide signal into 25ms pieces
amount_of_sliding_windows = floor(size(y)/samples_in_25ms);

% Create a vector for the pitch
pitch_contour = zeros(amount_of_sliding_windows(1),1);

% Calculating the autocorrelation of signal with window size 100ms with a shift of 25ms
% This loop doesn't go through the last 45466 - 45201 = 265 samples at the
% end of the sound signal.
count = 1;
for i = 1:samples_in_25ms : size(voiced_signal,1)
    % check window fits into remaining samples
    if (i + samples_in_100ms) <= size(voiced_signal,1)
        autocorrelated_signal = autocorrelation(voiced_signal(i:i+samples_in_100ms), samples_in_100ms);  
        % We use the same parameters for findpeaks() as in E1. We found
        % this to be optimal, although it might influence the result in a
        % some windows.
        [peak,location] = findpeaks(autocorrelated_signal,peak_space,'MinPeakDistance',0.007);
        meanPeriod = mean(diff(location));
        % make sure unvoiced parts are plotted as zero (autocorrelation might return NaN)
        if isnan(meanPeriod)
           pitch_contour(count) = 0;
        else
            pitch_contour(count) = 1/meanPeriod;
        end
    end
    count = count+1;
end

% plot the pitch contour
figure();
x2 = linspace(0,sound_length,amount_of_sliding_windows(1));
hold on;
xlabel('Time');
ylabel('Frequency');
title('Pitch Contour');
plot(x2,pitch_contour);
hold off;
