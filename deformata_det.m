function N = deformata_det(x,Acorta,Am,Al,Lc,Lm,Ll)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% calcola la deformata della rotaia in corrispondenza delle ruote
% alla fine restituisce un vettore di 4 componenti
% deformazioni lungo zeta della rotaia in 4 punti
% 
%
%
% parametri di ingresso:
% 
% x: ascissa della prima ruota in metri
%
% Ac,Am,Al,Lc,Lm,Ls: parametri di usura in mm
%
%
% parametri di uscita:
%
% matrice N (1 to 4) in m

N = zeros(4,1);
for i = 1:4
    
    
    N(i,1)= Acorta * sin(2 * pi * x(i,1)/ Lc); %corta
    N(i,1) = N(i,1) + Am * sin(2 * pi * x(i,1)/ Lm); %media
    N(i,1) = N(i,1) + Al * sin(2 * pi *x(i,1)/ Ll); %lunga
 
end
