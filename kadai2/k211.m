run(['/home/ugrad/13/s1311403/Documents/T2/kadai2/exkadai/' ...
     'readImp.m'])
run('/home/ugrad/13/s1311403/Documents/T2/kadai2/exkadai/readWav.m')

o = 2; % オーバーラップ幅
p = 2^10; % フレーム長
w = 1; % 窓関数、ここではハミング窓
sl = length(s1);

[X, countX] = stft(s1, 1/o, p, w);
Y1 = istft(X, 1/o, p, w, sl, countX);

[X, countX] = stft(s2, 1/o, p, w);
Y2 = istft(X, 1/o, p, w, sl, countX);
