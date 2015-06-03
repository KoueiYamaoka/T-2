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

%IVAの実装
%stft分析
%s1,s2:混合信号, y1,y2:分離信号
o = 2; % オーバーラップ幅
p = 2^(nextpow2(length(imp11))); % フレーム長、インパルス応答以上の大きさに
w = 4; % 窓関数、今は箱形窓
sl = length(s1);

% stft
[X1, countX1] = stft(s1, 1/o, p, w);
[X2, countX2] = stft(s2, 1/o, p, w);
[g,r] = size(X1);
X = zeros(2,r,g); % 2行, 周波集インデックス列, フレーム数
X(1,:,:) = X1';
X(2,:,:) = X2';

% 分離行列Wの生成
W = zeros(size(X));

