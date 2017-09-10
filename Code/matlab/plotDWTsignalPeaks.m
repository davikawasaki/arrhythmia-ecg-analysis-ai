function [qrsPeaks,locs] = plotDWTsignalPeaks(ecgsigTransf, tmTransf, minPeakHeight, minPeakDistance, sample, arrhythmiaType) 
        
% usage: [qrsPeaks,locs] = plotDWTsignalPeaks(ecgsigTransf, tmTransf, 0.5, 0.150, '200m', 'VT')
%
% This function extract from a given QRS extracted signal its respective
% amplitude and location peaks. In the end a plot of the signal with the
% peaks is shown.
%

% Last version
% plotDWTsignalPeaks.m           D. Kawasaki			16 June 2017
% 		      Davi Kawasaki	       16 June 2017 version 1.0

%ecgsigTransf = abs(ecgsigTransf).^2;
[qrsPeaks,locs] = findpeaks(ecgsigTransf,tmTransf,...
                            'MinPeakHeight',minPeakHeight,...
                            'MinPeakDistance',minPeakDistance);
figure;
plot(tmTransf,ecgsigTransf)
hold on
plot(locs,qrsPeaks,'ro')
xlabel('Time (sec)');
ylabel('Amplitude (mV)');
str = sprintf('R Peaks Localized by Wavelet Transform with Automatic Annotations - %s %s',sample,arrhythmiaType);
title(str)

end