function [N] = deformata_ruota(x, diametro_ruota, V, gg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% calcola la deformata della ruota in corrispondenza del punto di contatto
% il difetto viene aggiunto soltanto alla prima ruota
% 
% 
%
%
% parametri di ingresso:
% 
% x: ascissa della prima ruota in metri
%
% a: profondità del difetto
%
% d: diametro della ruota
%
% parametri di uscita:
%
% matrice N (1 to 4) in m




% DEFORMATA NELSEN
a = 0.35; %in mm
a = a/1000; %passo in m
r = diametro_ruota/2;
C = 2*pi()*r;
ld = 40/1000;
w = 2*pi()*V/ld;



% %DEFORMATA DONG
% a = 2.15; %in mm
% a = a/1000; %passo in m
% r = diametro_ruota/2;
% C = 2*pi()*r;
% ld = 150/1000;
% w = 2*pi()*V/ld;




N = zeros(4,1);

% if x(1) > C
    if x(1) >= floor((x(1))/C)*C + C - ld
        if x(1) <= floor((x(1))/C)*C + C
            f = x(1) - (floor((x(1))/C)*C + C -ld);
            N(1,1) = a*(1-cos(2*pi()*f/ld))/2;
        end
    end
% end
