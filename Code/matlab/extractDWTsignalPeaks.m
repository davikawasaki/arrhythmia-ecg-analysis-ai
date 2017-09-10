function DWTsignalPeaks = extractDWTsignalPeaks(arrhythmiaMultipleQRS, minPeakHeight, minPeakDistance, sample, arrhythmiaType) 

% usage: DWTsignalPeaks = extractDWTsignalPeaks(arrhythmiaMultipleQRS, 0.5, 0.150)
%
% This function extract multiples signal peaks from DWT - amplitudes and
% times. The scale used for DWT was 3, the minPeakHeight is 0.5 and
% the minPeakDistance is 0.150.
%
% DWTsignalPeaks{i,1} equals to QRS amplitude peaks
% DWTsignalPeaks{i,2} equals to QRS peaks locations
% DWTsignalPeaks{i,3} equals to arrhythmia type sample
%

% Last version
% extractDWTsignalPeaks.m           D. Kawasaki			17 June 2017
% 		      Davi Kawasaki	       17 June 2017 version 1.0
    
scale = 3;
DWTsignalPeaks = {};

for i = 1:size(arrhythmiaMultipleQRS,1)
    % Force minPeakDistance in normal waves
    %if(strcmp(arrhythmiaType,'N'))
    %    minPeakDistance = 0.13;
    %end
    if(i == 10)
        minPeakDistance = 0.13;
    else
        minPeakDistance = 0.15;
    end
    if(~isempty(arrhythmiaMultipleQRS{i,1}))
        ecgsigTransf = dwtSignal(arrhythmiaMultipleQRS{i,1}, scale);
        %ecgsigTransf = abs(ecgsigTransf).^2;
        [qrsPeaks,locs] = findpeaks(ecgsigTransf,arrhythmiaMultipleQRS{i,2},...
                                'MinPeakHeight',minPeakHeight,...
                                'MinPeakDistance',minPeakDistance);
        inst = {qrsPeaks locs arrhythmiaMultipleQRS{i,3}};
        DWTsignalPeaks(end+1,:) = inst;
        
        %if(arrhythmiaType ~= 'N')
            % Plot Peaks
            figure;
            plot(arrhythmiaMultipleQRS{i,2},ecgsigTransf)
            hold on
            plot(locs,qrsPeaks,'ro')
            xlabel('Time (sec)');
            ylabel('Amplitude (mV)');
            str = sprintf('R Peaks From Signal %d Localized by Wavelet Transform - %s %s', i, sample, arrhythmiaType);
            title(str)
            strExport = sprintf('%s-peaks%d-%s', arrhythmiaType, i, sample);
            print(strExport,'-dpng');
        %end
    else
        continue;
    end
end

end