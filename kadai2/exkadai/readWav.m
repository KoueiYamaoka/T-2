[s1, Fs] = wavread('~/Documents/T2/kadai2/wavFiles/kongou1.wav');
s2 = wavread('~/Documents/T2/kadai2/wavFiles/kongou2.wav');
sample2 = wavread('~/Documents/T2/kadai2/wavFiles/sample2.wav');
sample1 = wavread('~/Documents/T2/kadai2/wavFiles/sample1.wav');
s1 = s1';
s2 = s2';
l1 = length(s1);
l2 = length(s2);

if l1 > l2
    append0 = zeros(1, l1 - l2);
    s2 = [s2, append0];
else
    append0 = zeros(1, l2 - l1);
    s1 = [s1, append0];
end
