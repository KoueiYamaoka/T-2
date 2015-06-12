function tmpY = calcm(Y1, Y2, normY1, normY2, fi, k, i)


mu = 1;
ganma = 1;
ty1 = ganma * conj(Y1);
ty2 = ganma * conj(Y2);
tmpY = [sum((Y1.*ty1)./normY1), sum((Y1.*ty2)./normY1); ...
        sum((Y2.*ty1)./normY2), sum((Y2.*ty2)./normY2)];
tmpY = eye(2) + mu * (eye(2) - (1/fi) * tmpY);

if isnan(ty1) == 1
1
k
i
keyboard
end

if isnan(ty2) == 1
2
k
i
keyboard
end

if isnan(tmpY) == 1
3
k
i
keyboard
end

if isinf(ty1) == 1
4
k
i
keyboard
end

if isinf(ty2) == 1
5
k
i
keyboard
end

if isinf(tmpY) == 1
6
k
i
keyboard
end
