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

% H
%H = zeros(2,2,p);
H(1,1,:) = fft(imp11,p);
H(1,2,:) = fft(imp21,p);
H(2,1,:) = fft(imp12,p);
H(2,2,:) = fft(imp22,p);

% W = inv(H)
W = zeros(2,2,p);
for k=1:p
    W(:,:,k) = inv(H(:,:,k));
end

% 循環畳み込みを線形畳み込みにするための0埋め処理
% ifft(W)
W(1,1,:) = real(ifft(W(1,1,:)));
W(1,2,:) = real(ifft(W(1,2,:)));
W(2,1,:) = real(ifft(W(2,1,:)));
W(2,2,:) = real(ifft(W(2,2,:)));

% W2 = fft(W,2p-1)
p2 = 2*p-1;
W2 = zeros(2,2,p2);
W2(1,1,:) = fft(W(1,1,:), p2);
W2(1,2,:) = fft(W(1,2,:), p2);
W2(2,1,:) = fft(W(2,1,:), p2);
W2(2,2,:) = fft(W(2,2,:), p2);
keyboard

% Y = W2 * X
[Xg, Xr] = size(X1); % Xg:行数(165), Xr:列数(2^13)
Y1 = zeros(Xg,Xr);
Y2 = zeros(Xg,Xr);

for i=1:Xg
    for k=1:Xr
        Y1(i,k) = W2(1,1,k) * X1(i,k) + W2(1,2,k) * X2(i,k);
        Y2(i,k) = W2(2,1,k) * X1(i,k) + W2(2,2,k) * X2(i,k);
    end
end

% istft
y1 = istft(Y1, 1/o, p, w, sl, countX1);
y2 = istft(Y2, 1/o, p, w, sl, countX2);
