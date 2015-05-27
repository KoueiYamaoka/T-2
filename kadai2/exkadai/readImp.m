fid11 = fopen('IR2_S1 to M1.dbl','rb');
fid12 = fopen('IR2_S1 to M2.dbl','rb');
fid21 = fopen('IR2_S2 to M1.dbl','rb');
fid22 = fopen('IR2_S2 to M2.dbl','rb');

imp11 = fread(fid11, 'double');
imp12 = fread(fid12, 'double');
imp21 = fread(fid21, 'double');
imp22 = fread(fid22, 'double');

imp11 = resample(imp11, 44100, 48000);
imp12 = resample(imp12, 44100, 48000);
imp21 = resample(imp21, 44100, 48000);
imp22 = resample(imp22, 44100, 48000);
