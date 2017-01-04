% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Sudarson Selvaraj - 387649
% %% Mikko Honkanen - 387608
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ melSpec ] = melFilter( spec, filter )
%Computing speech features in the mel-scaled spectral domain
%Computing a matrix multiplication between the triangular filter 
% and the absolute values of the spectrum of the signal spec.

%disp(size(filter))
%disp(size(spec))
%% Compute matrix multiplication
melSpec = filter * abs(spec);

end

