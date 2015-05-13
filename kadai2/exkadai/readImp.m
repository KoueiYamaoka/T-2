fid11 = fopen('imp11.dbl');
fid12 = fopen('imp12.dbl');
fid21 = fopen('imp21.dbl');
fid22 = fopen('imp22.dbl');

imp11 = fread(fid11, 'double');
imp12 = fread(fid12, 'double');
imp21 = fread(fid21, 'double');
imp22 = fread(fid22, 'double');

resample(imp11, 44100, 48000);
resample(imp12, 44100, 48000);
resample(imp21, 44100, 48000);
resample(imp22, 44100, 48000);
