function annotationsEcg = readAnnotations(Name)

% USAGE: annotationsEcg = readAnnotations('../data/200m')
% This function read an annotation file (RECORDm.txt) from a PhysioBank record,
% which contains signal periods and auxiliary arrhytmias.

% Last version
% readAnnotations.m           D. Kawasaki			16 June 2017
% 		      Davi Kawasaki	       16 June 2017 version 1.0

annotationName = strcat(Name, '.txt');
fid = fopen(annotationName, 'rt');
annotationsEcg = textscan(fid, '%d:%f %d %*c %*d %*d %*d %s', 'HeaderLines', 1, 'CollectOutput', 1);
fclose(fid);

end
