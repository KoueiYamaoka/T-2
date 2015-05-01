k1s3

yl = length(y);
Z = zeros(2, 2, yl);
for k = 1:yl;
    Z(:,:,k) = inv(W) * diag(y(:,k));
end
z1 = zeros(1,yl);
z2 = zeros(1,yl);
z3 = zeros(1,yl);
z4 = zeros(1,yl);
z1(1,:) = Z(1,1,:);
z2(1,:) = Z(2,1,:);  % y1 -> z1 = z2
z3(1,:) = Z(1,2,:);
z4(1,:) = Z(1,2,:);  % y2 -> z2 = z4
