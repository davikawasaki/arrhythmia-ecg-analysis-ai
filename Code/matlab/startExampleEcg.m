function [tm,ecgsig,Fs,annotationsEcg] = startExampleEcg()
    [tm,ecgsig,Fs] = loadEcgSignal('../data/200m');
    annotationsEcg = readAnnotations('../data/200m');
end