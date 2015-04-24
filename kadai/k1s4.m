k1s3

yl = length(y);
Z = zeros(2, yl);
k = 1:yl;
Z(:,k) = inv(W) * diag(y(:,k));
