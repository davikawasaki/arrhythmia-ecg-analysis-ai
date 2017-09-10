function arrhythmiaPeriods = readArrythmiaPeriods(type, filename) 

% usage: arrhythmiaPeriods = readArrythmiaPeriods(VT, '../data/200m') 
%
% This function read the annotations file and extract the respective arrhythmia periods.
%
% arrhythmiaPeriods{i,1} equals to minutes sample
% arrhythmiaPeriods{i,2} equals to seconds sample
% arrhythmiaPeriods{i,3} equals to period sample
% arrhythmiaPeriods{i,4} equals to arrhythmia type sample
%

% Last version
% readArrythmiaPeriods.m           D. Kawasaki			16 June 2017
% 		      Davi Kawasaki	       16 June 2017 version 1.0

type = strcat('(', type);
annotationsEcg = readAnnotations(filename);
arrhythmiaPeriods = {};
for i = 1:size(annotationsEcg{1})
    % Force normal sinus rhythm label on empty labels when a '(N'
    % extraction case is demanded
    if(strcmp(annotationsEcg{1,4}(i),'') && strcmp(type,'(N'))
        annotationsEcg{1,4}(i) = {type};
    end
    
    if(strcmp(annotationsEcg{1,4}(i),type))
        inst = {annotationsEcg{1,1}(i) annotationsEcg{1,2}(i) annotationsEcg{1,3}(i) annotationsEcg{1,4}(i)};
        arrhythmiaPeriods(end+1,:) = inst;
    end
end

end