rm  clear all

% 混合音声の読み込み-----------------------------
[Mic1, Fs] = wavread('Mic_Ch1.wav');
Mic2 = wavread('Mic_Ch2.wav');
s1 = Mic1';
s2 = Mic2';
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
[fi,fs] = size(X1);

% 分離行列Wの生成-------------------------------------------------------
% 分離行列Wの更新の事前準備-----------------------
% Wとその他諸々
L2 = ceil(fs/2);         % 総フレーム数 / 2
rng(509);                % seed値
W = rand(2,2,L2) - 0.5 + (rand(2,2,L2) - 0.5)*j;        % 分離行列
compW = zeros(size(W));  % 反復終了判定の比較用
maxloop = 300;          % 最大反復回数10000回

% X, Yについて
X = zeros(2,fi,L2); % 2行, 周波集インデックス列, フレーム数
X1 = X1(:,1:L2).';
X2 = X2(:,1:L2).';
X1 = reshape(X1,1,fi,L2);
X2 = reshape(X2,1,fi,L2);
X(1,:,:) = X1;
X(2,:,:) = X2;
Y = zeros(size(X));
tmp = zeros(size(W));
XX = zeros(2,2,L2); % ループのmを先に計算したもの

% 準備完了-----------------------------------------

% warning
% 収束せずにむしろ発散してる
% Wの更新がうまくいってない可能性
% 反復回数が大きくなると少しだけ収束する

% 反復計算開始-------------------------------------
for k=1:maxloop
    k
    % Y = W * X 普通より0.2sec程度速い
    % 間違っていないことを確認
    for l = 1:fi
        Y(:,l,:) = sum(W .* repmat(permute(X(:,l,:),[2,1,3]), 2, 1), 2);
    end
    %Yの計算終了----------------------------------------------------

    % Wの更新------------------------------------------------
    % ここもあっていることを確認
    % 準備
    Y1 = squeeze(Y(1,:,:)).';
    Y2 = squeeze(Y(2,:,:)).';
    normY1 = sqrt(sum(abs(Y1).^2));
    normY2 = sqrt(sum(abs(Y2).^2));
    
    % 本体
    % 普通に計算した場合より6秒ぐらい速い
    for i = 1:L2
        XX(:,:,i) = calcm(Y1(i,:), Y2(i,:), normY1, normY2, fi);
    end
    compW = W; % 反復終了判定用にWを保存

    % W = XX * W
    W(:,1,:) = sum(XX .* repmat(permute(W(:,1,:),[2,1,3]), 2,1), 2); 
    W(:,2,:) = sum(XX .* repmat(permute(W(:,2,:),[2,1,3]), 2,1), 2); 
    W(:,:,100) % 確認のため適当なWを表示

    % Wの更新終了----------------------------------------------------
    % 反復終了判定. tは収束したWの要素の数
    tmp = abs(compW - W);
    t = numel(find(tmp < 10e-4))
    if  t == 4 * L2
        break;
    end  
end
    
% 最後の積計算
for l = 1:fi
    Y(:,l,:) = sum(W .* repmat(permute(X(:,l,:),[2,1,3]), 2, 1), 2);
end

% istft
% 半分にした周波数を復元する
y1 = [squeeze(Y(1,:,:))];
y2 = [squeeze(Y(2,:,:))];
y1 = [y1, conj(fliplr(y1))];
y2 = [y2, conj(fliplr(y2))];
y1 = istft(y1, o, fs, sl, countX1);
y2 = istft(y2, o, fs, sl, countX2);
    
