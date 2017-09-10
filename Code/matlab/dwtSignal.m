function ecgsigTransf = dwtSignal(ecgsig, scale)

% usage: ecgsigTransf = dwtSignal(ecgsig, scale)
%
% This function implements read the MODWT to filter and remove noises
% due to the chosen scale. After that, it implements the inverse wavelet transform
% to get the final signal transformed.
%

% Last version
% dwtSignal.m           D. Kawasaki			16 June 2017
% 		      Davi Kawasaki	       16 June 2017 version 1.0

% Maximal overlap discrete wavelet transform
wt = modwt(ecgsig,scale);
wtrec = zeros(size(wt));
wtrec(3:4,:) = wt(3:4,:);
% Inverse maximal overlap discrete wavelet transform
ecgsigTransf = imodwt(wtrec,'sym4');
    
end