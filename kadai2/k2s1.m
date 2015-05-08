function y =  k2s1(s, w, o, n)
% s:音源, w:窓, o:オーバーラップ幅, n:窓の長さ

l = length(s);    % 音源の長さ

Y(1:n) = s(1:n) * w;


