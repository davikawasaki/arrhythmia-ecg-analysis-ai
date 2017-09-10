function arrhythmiaMultipleQRS = extractMultipleQRS(arrhythmiaPeriods, sizeEcgSig, timeEcgSig, ecgsig, tmSeg, sample, arrhythmiaType)

% usage: arrhythmiaMultipleQRS = extractMultipleQRS(arrhythmiaPeriods, 650000, 1820, ecgsig, tmSeg, '200m', 'VT')
%
% This function extract multiples QRS wave,
% which may or not contain signal arrhytmias.
%
% arrhythmiaMultipleQRS{i,1} equals to the QRS extracted signal
% arrhythmiaMultipleQRS{i,2} equals to the QRS extracted time
% arrhythmiaMultipleQRS{i,3} equals to arrhythmia type sample
%

% Last version
% extractMultipleQRS.m           D. Kawasaki			16 June 2017
% 		      Davi Kawasaki	       16 June 2017 version 1.0

periodInterval = sizeEcgSig/timeEcgSig;

arrhythmiaMultipleQRS = {};
qrsScaleStart = 2;
qrsScaleEnd = 1;

% Increase the right period	in Ventricular bigeminy cases
if(arrhythmiaType == 'B')
    qrsScaleStart = 2;
    qrsScaleEnd = 2;
elseif(arrhythmiaType == 'T')
    qrsScaleStart = 1;
    qrsScaleEnd = 2.1;
end

for i = 1:size(arrhythmiaPeriods,1)-1
    period = arrhythmiaPeriods{i,3};
    if(period == -1)
        %tmPeriod = arrhythmiaPeriods{i,3} * interval;
        tmTotal = arrhythmiaPeriods{i,1} * 60;
        tmTotal = tmTotal + arrhythmiaPeriods{i,2};
        period = (tmTotal*sizeEcgSig)/timeEcgSig;
    end
    
    %i == size(arrhythmiaPeriods,1)
    % Arrhythmia detected in signal start
    if(period - periodInterval/2 <= 0)
        qrsExtracted = ecgsig(1:round(period + periodInterval));
        tmExtracted = tmSeg(1:round(period + periodInterval)); 
    % Arrhythmia detected in signal end for arrhythmiaType normal
    elseif(~strcmp(arrhythmiaType,'N') && (i == size(arrhythmiaPeriods,1)))
        qrsExtracted = ecgsig(round(period - periodInterval/qrsScaleStart):size(arrhythmiaPeriods,1));
        tmExtracted = tmSeg(round(period - periodInterval/qrsScaleStart):size(arrhythmiaPeriods,1)); 
    % Arrhythmia detected in signal end for arrhythmiaTypes
    elseif(strcmp(arrhythmiaType,'N') && i == size(arrhythmiaPeriods,1)-1)
        qrsExtracted = ecgsig(round(period - periodInterval/qrsScaleStart):size(arrhythmiaPeriods,1));
        tmExtracted = tmSeg(round(period - periodInterval/qrsScaleStart):size(arrhythmiaPeriods,1)); 
    else
        qrsExtracted = ecgsig(round(period - periodInterval/qrsScaleStart):round(period + periodInterval*qrsScaleEnd));
        tmExtracted = tmSeg(round(period - periodInterval/qrsScaleStart):round(period + periodInterval*qrsScaleEnd)); 
    end
    inst = {qrsExtracted tmExtracted arrhythmiaPeriods{i,4}};
    arrhythmiaMultipleQRS(end+1,:) = inst;
    
    %if(arrhythmiaType ~= 'N')
        % Plot QRS to check the waves
        figure
        plot(tmExtracted, qrsExtracted);
        xlabel('Time (sec)');
        ylabel('Amplitude (mV)');
        str = sprintf('Extracted QRS signal %d - %s %s', i, sample, arrhythmiaType);
        title(str);
        strExport = sprintf('%s-example%d-%s', arrhythmiaType, i, sample);
        print(strExport,'-dpng');
    %end
end

end
