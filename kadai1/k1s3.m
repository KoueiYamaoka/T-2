x1 =  wavread('kongou1.wav');  % 列ベクトル
x2 =  wavread('kongou2.wav');
X = [x1,x2];         % n行2列
N = length(x1);      % ベクトルサイズ
W = zeros(2, 2);   % 2行2列
J = 2;               % 音源数
I = eye(J);

mu = 0.1;            % ステップサイズ
gamma = 0.5;         % 適当な正の数
W = [0.3, 0.7; 0.5, 1];    % 分離行列

for k = 1:10000
    y = W * X';
    tmp = W;
    t = tanh(gamma * y) * y';
    W = W + mu * (I - (1 / N) * t) * W;    % 勾配法
    if abs(W - tmp) < 10e-5
        break;
    end
end

