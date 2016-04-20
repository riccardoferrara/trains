function [Rst,D] = hertz(dt, U, Kh, V, N, D0, Ch)

%calcolo la costante Ch secondo Ambrosio
% Ch = 3*Kh*(1-0.7303^2)/4;

%calcolo la compenetrazione d
D = U - V - N;

%calcolo della velocità di compenetrazione
D1 = (D-D0)/dt;

%calcolo la componente statica
Fh = Kh*abs(D)^1.5;

%calcolo la componente viscosa
% Fd = min(Kv*abs(D1),Fh*(1-0.7303^2)*3/4);
% Fd = Ch*abs(D1);
Fd = 0;
% Fd = Ch*abs(D)^1.5;

%calcolo la reazione totale
Rst = (Fh + Fd*(sign(-D1)+1)/2)*(sign(-D)+1)/2;
% Rst = Fh*(sign(-D)+1)/2 + Fd;
% Rst = (Fh + Fd)*(sign(-D)+1)/2;