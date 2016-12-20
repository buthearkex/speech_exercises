function w = hann(varargin)
%HANN   Hann window.
%   HANN(N) returns the N-point symmetric Hann window in a column vector.
% 
%   HANN(N,SFLAG) generates the N-point Hann window using SFLAG window sampling.
%   SFLAG may be either 'symmetric' or 'periodic'. By default, a symmetric
%   window is returned. 
%
%   See also BLACKMAN, HAMMING, WINDOW.

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.10.4.3 $  $Date: 2011/05/13 18:07:56 $ 

% Check number of inputs
error(nargchk(1,2,nargin,'struct'));

[w,msg,msgobj] = gencoswin('hann',varargin{:});
if ~isempty(msg), error(msgobj); end

    
% [EOF] hann.m
