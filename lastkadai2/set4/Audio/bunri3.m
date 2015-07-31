%function [y1, y2] = k221(mu, ganma)

mu = 0.1;
ganma = 0.05;

% 混合音声の読み込み-----------------------------
[Mic1, Fs] = wavread('Mic_Ch1.wav');
Mic2 = wavread('Mic_Ch2.wav');
Mic3 = wavread('Mic_Ch3.wav');
s1 = Mic1(1:Fs*10)';
s2 = Mic2(1:Fs*10)';
s3 = Mic3(1:Fs*10)';
snum = 3; % 音源の数, マイクの数と一致していることが条件
% 読み込み完了-----------------------------------

% IVAの実装
% stft分析
% s1,s2:混合信号, y1,y2:分離信号
o = 1/2; % オーバーラップ幅
p = 2^(10); % フレーム長
w = 1; % 窓関数、今はハミング
sl = length(s1);

% stft
[X1, countX1] = stft(s1, o, p, w);
[X2, countX2] = stft(s2, o, p, w);
[X3, countX3] = stft(s3, o, p, w);
[fi,fs] = size(X1);

% 分離行列Wの生成-------------------------------------------------------
% 分離行列Wの更新の事前準備-----------------------
% Wとその他諸々
L2 = ceil(fs/2) + 1;         % 総フレーム数 / 2
rng(509);                % seed値
W = rand(snum,snum,L2) - 0.5; % 分離行列
loop = 500;          % 反復回数500回ぐらいが良さそう。300でも十分だと思う

% X, Yについて
% あっていることを確認
X = zeros(snum,fi,L2); % snum行, 周波集インデックス列, 周波数フレーム/2 +1
% X = [X1; X2]となるように整形
X(1,:,:) = reshape(X1(:,1:L2), 1, fi, L2);
X(2,:,:) = reshape(X2(:,1:L2), 1, fi, L2);
X(3,:,:) = reshape(X3(:,1:L2), 1, fi, L2);
Y = zeros(size(X));
XX = zeros(snum,snum,L2); % ループのmを先に計算したものを格納する

% 準備完了-----------------------------------------

for k=1:loop
    k
    % Y = W * X 普通より0.2sec程度速い
    for l = 1:fi
        Y(:,l,:) = sum(W .* repmat(permute(X(:,l,:),[2,1,3]), snum, 1), 2);
    end
    %Yの計算終了----------------------------------------------------
    % Wの更新------------------------------------------------
    % ここもあっていることを確認
    % 準備
    Y1 = squeeze(Y(1,:,:)).';
    Y2 = squeeze(Y(2,:,:)).';
    Y3 = squeeze(Y(3,:,:)).';
    normY1 = sqrt(sum(abs(Y1).^2));
    normY2 = sqrt(sum(abs(Y2).^2));
    normY3 = sqrt(sum(abs(Y3).^2));
    
    % 本体
    % p=2^10のとき、普通に計算した場合より6秒ぐらい速い
    for i = 1:L2
        XX(:,:,i) = calcm3(Y1(i,:), Y2(i,:), Y3(i,:), normY1, normY2, normY3, fi, mu, ...
                          ganma);
    end

    % W = XX * W
    W(:,1,:) = sum(XX .* repmat(permute(W(:,1,:),[2,1,3]), snum ,1), 2); 
    W(:,2,:) = sum(XX .* repmat(permute(W(:,2,:),[2,1,3]), snum ,1), 2); 
    W(:,3,:) = sum(XX .* repmat(permute(W(:,3,:),[2,1,3]), snum ,1), 2); 
    W(:,:,100) % 確認のため適当なWを表示

    % Wの更新終了----------------------------------------------------
end
    
% 最後の積計算
for l = 1:fi
    Y(:,l,:) = sum(W .* repmat(permute(X(:,l,:),[2,1,3]), snum, 1), 2);
end

% スケーリング
% 時間があればfor文撤去
Z = zeros(snum,snum,fi,L2);
for s=1:L2
    invW = inv(W(:,:,s));
    for i=1:fi
        Z(:,:,i,s) = invW * diag(Y(:,i,s));
    end
end
Y(1,:,:) = squeeze(Z(1,1,:,:));
Y(2,:,:) = squeeze(Z(2,2,:,:));
Y(3,:,:) = squeeze(Z(3,3,:,:));

% istft
% 半分にした周波数を復元する
Y1 = [squeeze(Y(1,:,:))];
Y2 = [squeeze(Y(2,:,:))];
Y3 = [squeeze(Y(3,:,:))];
Y1 = [Y1, conj(fliplr(Y1(:,2:end-1)))];
Y2 = [Y2, conj(fliplr(Y2(:,2:end-1)))];
Y3 = [Y3, conj(fliplr(Y3(:,2:end-1)))];
y1 = istft(Y1, o, fs, sl, countX1);
y2 = istft(Y2, o, fs, sl, countX2);
y3 = istft(Y3, o, fs, sl, countX3);
