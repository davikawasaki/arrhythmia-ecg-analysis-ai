function compareWaveletQRS(qrsEx)

% usage: compareWaveletQRS(qrsEx)

% Last version
% compareWaveletQRS.m           D. Kawasaki			15 June 2017
% 		      Davi Kawasaki	       15 June 2017 version 1.0

[mpdict,~,~,longs] = wmpdictionary(numel(qrsEx),'lstcpt',{{'sym4',3}});
figure
plot(qrsEx)
hold on
plot(2*circshift(mpdict(:,13),[-2 0]),'r')
axis tight
legend('QRS Complex','Sym4 Wavelet')
title('Comparison of Sym4 Wavelet and QRS Complex')

end