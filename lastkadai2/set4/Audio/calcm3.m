function tmpY = calcm3(Y1, Y2, Y3, normY1, normY2, normY3, fi, mu, ganma)

ty1 = ganma * conj(Y1);
ty2 = ganma * conj(Y2);
ty3 = ganma * conj(Y3);
tmpY = [sum((Y1.*ty1)./normY1), sum((Y1.*ty2)./normY1), sum((Y1.*ty3)./normY1); ...
        sum((Y2.*ty1)./normY2), sum((Y2.*ty2)./normY2), sum((Y2.*ty3)./normY2); ...
        sum((Y3.*ty1)./normY3), sum((Y3.*ty2)./normY3), sum((Y3.*ty3)./normY3)];
tmpY = eye(3) + mu * (eye(3) - (1/fi) * tmpY);
