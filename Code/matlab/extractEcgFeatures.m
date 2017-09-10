function features = extractEcgFeatures(DWTsignalPeaks, fileName) 

% usage: extractEcgFeatures(DWTsignalPeaks, '../data/exported/vt-200m')
%
% This function extract physiological ECG features from DWT peaks.
%
% features{i,1} equals to R peak amplitude in mV
% features{i,2} equals to R-R peak time delay
% features{i,3} equals to wave arrhythmia type
%

% Last version
% extractEcgFeatures.m           D. Kawasaki			17 June 2017
% 		      Davi Kawasaki	       17 June 2017 version 1.0

features = {};

for i = 1:size(DWTsignalPeaks,1)
    % Check if peaks amplitude and locs aren't empty
    if(~isempty(DWTsignalPeaks{i,1}) && ~isempty(DWTsignalPeaks{i,2}))
        % Check if at least 2 peaks were found
        if(length(DWTsignalPeaks{i,1}) >= 2 && length(DWTsignalPeaks{i,2}) >= 2)
            % Extraction for VT and B arrhythmia
            %if(strcmp(DWTsignalPeaks{i,3},'(VT') || strcmp(DWTsignalPeaks{i,3},'(B') || strcmp(DWTsignalPeaks{i,3},'(T') || strcmp(DWTsignalPeaks{i,3},'(N'))
            if(strcmp(DWTsignalPeaks{i,3},'(VT'))
                peakAmpR = DWTsignalPeaks{i,1}(end);
                if(length(DWTsignalPeaks{i,1}) > 3)
                    peakIntervalRR = DWTsignalPeaks{i,2}(end-1) - DWTsignalPeaks{i,2}(1); 
                else 
                    peakIntervalRR = DWTsignalPeaks{i,2}(end) - DWTsignalPeaks{i,2}(1); 
                end
                inst = {peakAmpR peakIntervalRR DWTsignalPeaks{i,3}};
                features(end+1,:) = inst;
                
            % Other types of arrhythmia
            else
                peakAmpR = DWTsignalPeaks{i,1}(end);
                if(length(DWTsignalPeaks{i,1}) > 3)
                    peakIntervalRR = DWTsignalPeaks{i,2}(end-1) - DWTsignalPeaks{i,2}(1); 
                else 
                    peakIntervalRR = DWTsignalPeaks{i,2}(end) - DWTsignalPeaks{i,2}(1); 
                end
                inst = {peakAmpR peakIntervalRR DWTsignalPeaks{i,3}};
                features(end+1,:) = inst;
            end
        else
            continue;
        end
    else
        continue;
    end
end

featuresExtr = strcat(fileName, '.csv');
features
featuresTable = cell2table(features, 'VariableNames',{'Amplitude','RR','Arritmia'});
writetable(featuresTable, featuresExtr);

end