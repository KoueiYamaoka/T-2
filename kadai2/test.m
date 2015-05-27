clear all;

run('/home/ugrad/13/s1311403/Documents/T2/kadai2/exkadai/readImp.m')
run('/home/ugrad/13/s1311403/Documents/T2/kadai2/exkadai/readWav.m')

o = 2; % オーバーラップ幅
p = 2^nextpow2(8000); % フレーム長、インパルス応答を8000まで使用
w = 1; % 窓関数、ここではハミング窓
sl = length(s1);

% Y = inv(H) * X
% X
[X1, countX1] = stft(s1, 1/o, p, w);
[X2, countX2] = stft(s2, 1/o, p, w);

% istft
y1 = istft(X1, 1/o, p, w, sl, countX1);
y2 = istft(X2, 1/o, p, w, sl, countX2);
