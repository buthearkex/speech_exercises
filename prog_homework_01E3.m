clear variables; %deletes all variables in the workspace
close all; %closes all plots
clc; %clears the command window

[y, Fs] = audioread('13ZZ637A.wav');

% use the unvoivoi function to detect voiced and unvoiced speech segments
voiced_parts = unvoivoi(y,0.1*Fs,0.015,0.90); % not sure what the threshold values shold be

% Multiply the result of the unvoivoi function with your speech data 
% to set unvoiced parts to zero
voiced_signal = y.* voiced_parts;

% Plot the audio signal and mark in the same plot the detected voiced speech
% segments
sound_length = size(y,1)/Fs;
x = linspace(0, sound_length, size(y,1));
figure();

last_unvoiced = 1;
first_unvoiced = 1;

hold on;

plot(x,y, 'color', 'r');
plot(x,voiced_signal,'color','b');

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

% Use the autocorrelation function on segments of the signal (windowsize: 100ms) and compute the
% fundamental frequency. Use a window shift of 25ms.

% Convert 25ms and 100ms to samples
samples_in_25ms = Fs * 0.025;
samples_in_100ms = Fs * 0.1;

peak_space = linspace(0,0.1,samples_in_100ms);

% divide signal into 25ms pieces
amount_of_sliding_windows = floor(size(y)/samples_in_25ms);

%x2 = linspace(0,10, 10);

% Create a fundamental frequency vector and plot your pitch contour
% Calculating the autocorrelation of signal with window size 100ms with a shift of 25ms
pitch_contour = zeros(amount_of_sliding_windows(1),1);
count = 1;

for i = 1:samples_in_25ms : size(voiced_signal,1)
    %disp(i);
    if (i + samples_in_100ms) <= size(voiced_signal,1)
    autocorrelated_signal = autocorrelation(voiced_signal(i:i+samples_in_100ms), samples_in_100ms); 
    %autocorrelated_signal = autocorrelation(voiced_signal(i:end), samples_in_100ms); 
    [peak,location] = findpeaks(autocorrelated_signal,peak_space,'MinPeakDistance',0.007);
    meanPeriod = mean(diff(location));
    if isnan(meanPeriod)
       pitch_contour(count) = 0;
    else
        pitch_contour(count) = 1/meanPeriod;
        %disp(pitch_contour(i));
    end
    end
    count = count+1;
end

figure();
% Now the last 45466 - 45201 samples at the end are left out.
x2 = linspace(0,sound_length,amount_of_sliding_windows(1));
plot(x2,pitch_contour);
