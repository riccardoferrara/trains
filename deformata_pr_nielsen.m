function [ N ] = deformata_pr_nielsen(x, i, NN, stepsPRELOAD)
%deformata_pr
%
%
%conoscendo i parametri random della deformata calcola il valore
%del difetto in corrispondenza delle 4 ruote
%
%
if i < stepsPRELOAD+1
    i = 1;
else
    i = i - stepsPRELOAD;
end


for k = 1:4;
    %inizializzazione variabile
    N(k,1) = NN(i,k);
end