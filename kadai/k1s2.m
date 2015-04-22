run k1s1.m

S = inv(H) * x;
S1 = S(1,:);
S2 = S(2,:);

if l1 > l2
    S2 = S2(1 : length(S2) - length(append0));
else
    S1 = S1(1 : length(S1) - length(append0));
end

wavwrite(S1, 44100, 16, 'bunri1.wav');
wavwrite(S2, 44100, 16, 'bunri2.wav');
