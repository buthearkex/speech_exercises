% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Speech Communication                                                 
% %% PROGRAMMING HOMEWORK II
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Updated by Falk Schiffner  08.12.2016

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Sudarson Selvaraj - 387649
% %% Mikko Honkanen - 387608


%% Head
clear variables; close all; clc;
addpath src

%% Read the audio
audiofile = ('13ZZ637A.wav');
[audiodata, fs] = audioread(audiofile);

%% compute the spectrogram
timeofdata = size(audiodata,1) / fs;
samples_10ms = round(0.01 * size(audiodata,1) / timeofdata); %number of samples in 10ms
[spec,freqs,times] = spectrogram(audiodata, hann(2*samples_10ms),samples_10ms, [], fs);

%% plot the spectrogram of audiofile
figure('Name',['Spectrogram of "',audiofile '"'])
imagesc(times,freqs,20*log(abs(spec)));
set(gca,'YDir', 'normal')
xlabel('Time [s]')
ylabel('Frequency [Hz]')
colorbar
title(['Spectrogram of "',audiofile '"'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% E1 Computation of equally spaced points on the mel-scale
% call the function melfreqs
% should we call this with k = 22 or k = 24 ???
mel_to_lin_edges = melfreqs(min(freqs), max(freqs), 24);

%% E2 Computation of the mids of the triangular filters
% call the function computeMids
mids = computeMids(freqs, mel_to_lin_edges);

%% E3 Computation of the mel-filter bank
% call the function computeFilter
filters = computeFilter(mids,freqs);

%% E4 Computation of the mel-filtered spectrum
% call the function melFilter
melSpec = melFilter(spec, filters);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot of the mel-filtered spectrum
figure('Name',['mel-filtered Spectrogram of "',audiofile '"'])
imagesc(times, freqs, melSpec);
set(gca,'YDir', 'normal')
xlabel('Time [s]')
ylabel('Frequency [Hz]')
colorbar


%% E O F







