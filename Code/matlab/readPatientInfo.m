function [age, sex, medicine] = readPatientInfo(Name)

% USAGE: [age, sex, medicine] = readPatientInfo('../data/200m')
% This function read an info file (RECORDm.info) from a PhysioBank record,
% which contains details of signal and patient info data, such as age,
% sex and medicine prescribed.

% Last version
% readPatientInfo.m     D. Kawasaki			14 October 2017
% 		      Davi Kawasaki	       14 October 2017 version 1.0

% Read the file
info = strcat(Name, '.hea');
fid = fopen(info, 'rt');

% Iterate through lines of the file, associating two lines:
% age/sex (line 2) and medicine prescribed (line 3)
line = fgetl(fid);
cont = 0;
while(ischar(line))
    line = fgetl(fid);
    if cont == 2
        fc1 = strrep(line,'# ','');
    end
    if cont == 3
        fc2 = strrep(line,'# ','');
    end
    cont = cont + 1;
end
fclose(fid);

% Get age, sex and medication prescription
data = textscan(fc1, '%d %c %d %d %s')
age = data{1};
sex = data{2};
if strcmp(fc2, 'None')
    medicine = 'No';
else
    medicine = 'Yes';
end

end