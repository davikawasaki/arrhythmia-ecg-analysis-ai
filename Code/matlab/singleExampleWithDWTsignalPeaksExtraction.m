function [tmSeg,ecgsig,Fs,sizeEcgSig,timeEcgSig,annotationsEcg,qrsExtracted,tmExtracted,ecgsigTransf,qrsPeaks,locs] = singleExampleWithDWTsignalPeaksExtraction(filename, filepath, arrhythmiaType, minutes, seconds, period, scale, minPeakHeight, minPeakDistance) 

% Usage: function [tmSeg,ecgsig,Fs,sizeEcgSig,timeEcgSig
%                  annotationsEcg,qrsExtracted,tmExtracted
%                  ecgsigTransf,qrsPeaks,locs] =
%                  singleExampleWithDWTsignalPeaksExtraction('200m', '../data/200m',
%                                                            'VT', 0, 7.517, 2706,
%                                                            3, 0.5, 0.150);
%
% This function plots and extracts QRS peaks example.
%

% Last version
% singleExampleWithDWTsignalPeaksExtraction.m           D. Kawasaki			18 June 2017
% 		      Davi Kawasaki	       18 June 2017 version 1.0

[tmSeg,ecgsig,Fs,sizeEcgSig,timeEcgSig] = loadEcgSignal(filepath);
annotationsEcg = readAnnotations(filepath);
[qrsExtracted, tmExtracted] = plotExtractSingleQRS(minute, seconds, period, sizeEcgSig, timeEcgSig, ecgsig, tmSeg, filename, arrhythmiaType);
ecgsigTransf = dwtSignal(qrsExtracted, scale);
[qrsPeaks,locs] = plotDWTsignalPeaks(ecgsigTransf, tmExtracted, minPeakHeight, minPeakDistance);

end