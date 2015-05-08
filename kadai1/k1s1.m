y1 = wavread('sample1.wav');
y2 = wavread('sample2.wav');
y1 = y1';
y2 = y2';
l1 = length(y1);
l2 = length(y2);
if l1 > l2
    append0 = zeros(1, l1 - l2);
    y2 = [y2, append0];
else
    append0 = zeros(1, l2 - l1);
    y1 = [y1, append0];
end
H = [0.9, 0.4; -0.3, 1];
s = [y1; y2];
x = H * s;

wavwrite(x(1,:), 44100, 16, 'kongou1.wav');
wavwrite(x(2,:), 44100, 16, 'kongou2.wav');
