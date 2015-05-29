clear all;

%畳み込み混合信号の生成
run('/home/ugrad/13/s1311403/Documents/T2/kadai2/exkadai/readImp.m')
run('/home/ugrad/13/s1311403/Documents/T2/kadai2/exkadai/readWav2.m')


N = length(s1);    %音源の長さ
R = length(imp11); %インパルス応答の長さ
K = N + R - 1;

S1 = fft(s1, K);
S2 = fft(s2, K);
I11 = fft(imp11, K);
I21 = fft(imp21, K);
I12 = fft(imp12, K);
I22 = fft(imp22, K);

X = zeros(2, K);
X(1,:) = S1 .* I11.' + S2 .* I21.';
X(2,:) = S1 .* I12.' + S2 .* I22.';

s1 = real(ifft(X(1,:), K));
s2 = real(ifft(X(2,:), K));
%生成完了

%stft分析
%s1,s2:混合信号, y1,y2:分離信号
o = 2; % オーバーラップ幅
p = 2^(nextpow2(length(imp11))); % フレーム長、インパルス応答以上の大きさに
w = 4; % 窓関数、今は箱形窓
sl = length(s1);

% stft
[X1, countX1] = stft(s1, 1/o, p, w);
[X2, countX2] = stft(s2, 1/o, p, w);

% H
H = zeros(2,2,p);
H(1,1,:) = fft(imp11,p);
H(1,2,:) = fft(imp21,p);
H(2,1,:) = fft(imp12,p);
H(2,2,:) = fft(imp22,p);

% W = inv(H)
W = zeros(2,2,p);
for k=1:p
    W(:,:,k) = inv(H(:,:,k));
end

% Y = W * X
[Xg, Xr] = size(X1); % Xg:行数(165), Xr:列数(2^13)
Y1 = zeros(Xg,Xr);
Y2 = zeros(Xg,Xr);

for i=1:Xg
    for k=1:Xr
        Y1(i,k) = W(1,1,k) * X1(i,k) + W(1,2,k) * X2(i,k);
        Y2(i,k) = W(2,1,k) * X1(i,k) + W(2,2,k) * X2(i,k);
    end
end

% istft
y1 = istft(Y1, 1/o, p, w, sl, countX1);
y2 = istft(Y2, 1/o, p, w, sl, countX2);
