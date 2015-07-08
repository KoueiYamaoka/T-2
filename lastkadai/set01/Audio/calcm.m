function tmpY = calcm(Y1, Y2, normY1, normY2, fi)

mu = 0.05;
ganma = 0.1;
ty1 = ganma * conj(Y1);
ty2 = ganma * conj(Y2);

tmpY = [sum((Y1.*ty1)./normY1), sum((Y1.*ty2)./normY1); ...
        sum((Y2.*ty1)./normY2), sum((Y2.*ty2)./normY2)];
tmpY = eye(2) + mu * (eye(2) - (1/fi) * tmpY);
