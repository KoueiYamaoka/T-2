function Y =  istft(X, o, p, w, sl, countX)
% Y:stftされた音源信号, o:オーバーラップ幅, p:]フレーム長, w:窓関数,
% sl:音源の長さ, countX:切り出した回数を保存している配列

o = 1 / o;
ol = ceil(p/o);

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
    fprintf('窓関数はstft時と同じものを指定してください\n');
    fprintf('w=1: ハミング窓\n');
    fprintf('w=2: 三角窓\n');
    fprintf('w=3: ガウス窓\n');
    fprintf('w=4:箱形窓\n');
    fprintf(['の4つ、もしくはフレーム長と同じ長さのベクトルです。\' ...
             'n']);
end

[al, foo] = size(X);
Y = zeros(1,sl);  % istft後、格納するためのベクトル  
for k = 1:al
    % 窓をかける
    Y(1 + ol*(k-1) : p + ol*(k-1)) = Y(1 + ol*(k-1) : p + ol*(k-1)) ...
        + real(ifft(X(k,:))) ./ w';
end

Y = Y ./ countX;
[r,c,Y] = find(Y);