readImp;
readWav;

N = length(s1);    %音源の長さ
R = length(imp11); %インパルス応答の長さ
K = N + R - 1;

S1 = fft(s1, K);
S2 = fft(s2, K);
I11 = fft(imp11, K);
I21 = fft(imp21, K);
I12 = fft(imp12, K);
I22 = fft(imp22, K);

S = [S1; S2];
H = zeros(2, 2, K);
H(1,1,:) = I11;
H(2,1,:) = I12;
H(1,2,:) = I21;
H(2,2,:) = I22;

X = zeros(2, K);
for k = 1:K
    X(:,k) = H(:,:,k) * S(:,k);
end

x1 = real(ifft(X(1,:), K));
x2 = real(ifft(X(2,:), K));







% 音源sをK点DFTで周波数領域表現に
% インパルス応答の行列を同様にDFT
% X = H * S
% XをK点逆DFTで時間領域に戻して完成
