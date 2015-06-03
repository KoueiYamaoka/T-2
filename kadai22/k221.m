clear all

%畳み込み混合信号の生成
run('/home/ugrad/13/s1311403/Documents/T2/kadai2/exkadai/readImp.m')
run('/home/ugrad/13/s1311403/Documents/T2/kadai2/exkadai/readWav2.m')
clear fid11 fid12 fid21 fid 22

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
p = 2^(nextpow2(length(imp11)) - 5); % フレーム長、インパルス応答以上の大きさに
w = 4; % 窓関数、今は箱形窓
sl = length(s1);

% stft
[X1, countX1] = stft(s1, 1/o, p, w);
[X2, countX2] = stft(s2, 1/o, p, w);
[fs,fi] = size(X1);
X = zeros(2,fi,fs); % 2行, 周波集インデックス列, フレーム数
X(1,:,:) = X1';
X(2,:,:) = X2';

%Y初期化
Y = zeros(size(X));

% 分離行列Wの生成
W = ones(2,2,fi);
mu = 1;
ganma = 1;
M = fs; %総フレーム数

% Y = W * X
L = 1 : (p/2);
sumY = 0;

for f = 1:fi
    for l=1:5
        for m = 1:fs;
            Y(1,f,m) = W(1,1,f) * X(1,f,m) + W(1,2,f) * X(2,f,m);
            Y(2,f,m) = W(2,1,f) * X(1,f,m) + W(2,2,f) * X(2,f,m);
            Y1norm = sqrt(sum(Y(1,L,m)));
            Y2norm = sqrt(sum(Y(2,L,m)));
         
            psiY = ganma * [(Y(1,f,m) / Y1norm), (Y(2,f,m) / ...
                                                  Y2norm)]';
            sumY = sumY + psiY * Y(:,f,m)';
        end
        tmp = mu * (eye(2) - ((1 / M) * sumY)) * W(:,:,f);
        W(:,:,f) = W(:,:,f) + tmp;
        if tmp < 1e-5
            l
            break
        end
    end
end

y1 = istft(squeeze(Y(1,:,:))', 1/o, p, w, sl, countX1);
y2 = istft(squeeze(Y(2,:,:))', 1/o, p, w, sl, countX1);
