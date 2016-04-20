function [ N ] = deformata_pr(x, V, ak, wk, fk )
%deformata_pr
%
%
%conoscendo i parametri random della deformata calcola il valore
%del difetto in corrispondenza delle 4 ruote
%
%

for i = 1:4;
 N(i,1) = ak'*sin(wk*(x(i,1)/V)+fk);
end