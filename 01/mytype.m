function mytype(filename)

fid = fopen(filename, 'r');
 while 1
    line = fgetl(fid);
    if ~ischar(line)
        break;
    end
    fprintf(1, [line '\n']); 
end
