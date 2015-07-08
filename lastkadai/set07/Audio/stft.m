function [X, countX] =  stft(s, o, p, w)
% s:音源, o:オーバーラップ幅, p:フレーム長, w:窓関数

sl = length(s);    % 音源の長さ
ol = floor(p*o);
al = floor(((sl-p)/ol) + 1);  % 総フレーム数
X = zeros(al,p);  % stft分析後、格納するための行列
countX = zeros(1, sl);  % 切り出した回数を保存する配列

% 窓
if w == 1
    w = hamming(p);   
elseif w == 2
    w = triang(p);
elseif w == 3
    w = gausswin(p);
elseif w == 4
    w = rectwin(p);
elseif length(w) == p
    w = w;
else
    fprintf('指定できる窓関数は\n');
    fprintf('w=1: ハミング窓\n');
    fprintf('w=2: 三角窓\n');
    fprintf('w=3: ガウス窓\n');
    fprintf('w=4:箱形窓\n');
    fprintf(['の4つ、もしくはフレーム長と同じ長さのベクトルです。\' ...
             'n']);
end

for k = 1:al
    % 窓をかけ、fft
    X(k,:) = s(1 + ol*(k-1) : p + ol*(k-1)) .* w';
    X(k,:) = fft(X(k,:));
    % 今のインデックスに1加算 
    countX(1 + ol*(k-1) : p + ol*(k-1)) = ...
    countX(1 + ol*(k-1) : p + ol*(k-1)) + 1;
end

% 0除算を防ぐための処理
tmp =  length(find(countX));
countX(tmp+1:sl) = countX(tmp+1:sl) + 1;
