function gousei(Hz, vec)

t = 0 : 1/44100 : 5;
y = 0;
for i=1:10
    y = y + vec(i) * sin(2 * pi * i * Hz * t);
end
wavwrite(y, 44100, 16, 'test5.wav');
