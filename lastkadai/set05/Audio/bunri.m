
%mu = linspace(0.1,1,10);
mu = 1;
ganma = linspace(0.1,1,10);
%ganma = 1;
count=1;
Y1 = zeros(length(mu)* length(ganma), 726016);
Y2 = zeros(length(mu)* length(ganma), 726016);
for i=1:length(mu)
    for j=1:length(ganma)
        [y1, y2] = k221(mu(i), ganma(j));
        Y1(count, :) = y1;
        Y2(count, :) = y2;
        subplot(3,1,1)
        plot(y1)
        subplot(3,1,2)
        plot(y2)
        subplot(3,1,3)
        plot(abs(y1-y2))
        count = count + 1
        figure(count)

    end
end

% mu=0.9, ganma=0.6
