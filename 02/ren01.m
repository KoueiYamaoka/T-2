[y, fs, bits] = wavread('sample1.wav');
t = 0 : 1/44100 : 5;
Y = fft(y);
Y = Y(1 : length(y) / 2 + 1);
%f1 = linspace(0, 22050, length(Y));
f1 = linspace(0, 220050, length(Y));
%f2 = linspace(0 + 500, 22050 + 500, length(Y));

plot(f1, abs(Y), 'r');
%hold on;
%loglog(f2, abs(Y), 'b');
%hold off;
