function Y =  istft(X, o, p, sl, countX)
% X:stftされた音源信号, o:オーバーラップ幅, p:フレーム長, 
% sl:音源の長さ, countX:切り出した回数を保存している配列

ol = floor(p*o);

[al, foo] = size(X);
Y = zeros(1,sl);  % istft後、格納するためのベクトル
for k = 1:al
    Y(1 + ol*(k-1) : ol*(k-1) + p) = Y(1 + ol*(k-1) : ol*(k-1) + p) ...
        + ifft(X(k,:));
end
Y = real(Y);

% Y = Y ./ countX;
[foo,foo2,Y] = find(Y);
clear foo foo2
