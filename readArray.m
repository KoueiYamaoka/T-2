function[Array] = readArray(filename)

i = 1;
ll = 0;                  % line length
init = 0;
fid = fopen(filename, 'r');
while 1
    line = fgetl(fid);
    if ~ischar(line)
        break;
    end

    %init
    if init == 0
        %calc line length
        tmpLine = line;
        while 1
            [token, tmpLine] = strtok(tmpLine);
            ll = ll + 1;
            if isempty(tmpLine)
                break;
            end
        end
        % set vector and array size
        v = zeros(1, ll);
        Array = zeros(1, ll);
        init = 1;
    end

    % read vector
    for j = 1 : ll
        [token, line] = strtok(line);
        v(j) = str2num(token);
    end

    %make Array
    Array(i,:) = v; 
    i = i + 1;
end
    
