function plotATM(Name)

% usage: plotATM('RECORDm')
%
% This function reads a pair of files (RECORDm.mat and RECORDm.info) generated
% by 'wfdb2mat' from a PhysioBank record, baseline-corrects and scales the time
% series contained in the .mat file, and plots them.  The baseline-corrected
% and scaled time series are the rows of matrix 'val', and each
% column contains simultaneous samples of each time series.
%
% 'wfdb2mat' is part of the open-source WFDB Software Package available at
%    http://physionet.org/physiotools/wfdb.shtml
% If you have installed a working copy of 'wfdb2mat', run a shell command
% such as
%    wfdb2mat -r 100s -f 0 -t 10 >100sm.info
% to create a pair of files ('100sm.mat', '100sm.info') that can be read
% by this function.
%
% The files needed by this function can also be produced by the
% PhysioBank ATM, at
%    http://physionet.org/cgi-bin/ATM
%

% plotATM.m           O. Abdala			16 March 2009
% 		      James Hislop	       27 January 2014	version 1.1

infoName = strcat(Name, '.info');
matName = strcat(Name, '.mat');
Octave = exist('OCTAVE_VERSION');
load(matName);
fid = fopen(infoName, 'rt');
fgetl(fid);
fgetl(fid);
fgetl(fid);
[freqint] = sscanf(fgetl(fid), 'Sampling frequency: %f Hz  Sampling interval: %f sec');
interval = freqint(2);
fgetl(fid);

if(Octave)
    for i = 1:size(val, 1)
       R = strsplit(fgetl(fid), char(9));
       signal{i} = R{2};
       gain(i) = str2num(R{3});
       base(i) = str2num(R{4});
       units{i} = R{5};
    end
else
    for i = 1:size(val, 1)
      [row(i), signal(i), gain(i), base(i), units(i)]=strread(fgetl(fid),'%d%s%f%f%s','delimiter','\t');
    end
end

fclose(fid);
val(val==-32768) = NaN;

for i = 1:size(val, 1)
    val(i, :) = (val(i, :) - base(i)) / gain(i);
end

x = (1:size(val, 2)) * interval;
size(val, 2)
interval
size(val, 2) * interval
plot(x', val');

for i = 1:length(signal)
    labels{i} = strcat(signal{i}, ' (', units{i}, ')'); 
end

legend(labels);
xlabel('Time (sec)');
% grid on

end
