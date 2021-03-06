[y, fs, bits] = wavread('sample2.wav');
y1 = y(1 * fs + (0 : 4095));
w = hanning(length(y1));
y1 = w .* y1;
Y1 = fft(y1);
Y1 = Y1(1 : length(y1) / 2 + 1);
f = linspace(0, fs/2, length(Y1));
semilogx(f, abs(Y1), 'r');
%hold on;
%loglog(f2, abs(Y), 'b');
%hold off;
