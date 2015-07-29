miny = max(abs(y1)) / 20;
testy = zeros(size(y1));
testy = y1;

for k=1:length(y2)
    if abs(y1(k)) < miny
        testy(k) = y1(k) / 10;
end
end
        
