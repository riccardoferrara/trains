% type exp.txt
% 0.00 1.00000000
% 0.10 1.10517092
% 0.20 1.22140276
% 0.30 1.34985881
% 0.40 1.49182470
% 0.50 1.64872127
% 0.60 1.82211880
% 0.70 2.01375271
% 0.80 2.22554093
% 0.90 2.45960311
% 1.00 2.71828183
f1 = fopen('exp.txt');
B = fscanf(f1,'%g %g',[2 inf]); % il file ha 2 colonne
% legge per righe 2 elementi sino alla fine del file
% B sara` una matrice di dimensione 2 righe x 11 colonne
fclose(f1)