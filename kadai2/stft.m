function [X, countX, Y] =  stft(s, o, p)
% s:音源, o:オーバーラップ幅, n:窓の長さ, p:フレーム長

o = 1 / o;
sl = length(s);    % 音源の長さ
w = hamming(p);   % 窓
ol = p/o;
al = floor(((sl-p)/ol) + 1);  % 総フレーム数
X = zeros(al,p);  % stft分析後、格納するための行列  
countX = zeros(1, sl);  % 切り出した回数を保存する配列

for k = 1:al
    % 窓をかける
    X(k,:) = fft(s(1 + ol*(k-1) : p + ol*(k-1)) .* w');
    % 今のインデックスに1加算 
    countX(1 + ol*(k-1) : p + ol*(k-1)) = ...
    countX(1 + ol*(k-1) : p + ol*(k-1)) + 1;
end

Y = zeros(1,sl);  % stft分析後、格納するための行列  
for k = 1:al
    % 窓をかける
    Y(1 + ol*(k-1) : p + ol*(k-1)) = Y(1 + ol*(k-1) : p + ol*(k-1)) ...
        + ifft(X(k,:)) ./ w';
end

Y = Y ./ countX;

subplot(2,1,1)
plot(s(1:100))

subplot(2,1,2)
plot(Y(1:100))
