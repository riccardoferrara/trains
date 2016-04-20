clear all

%legge di compressione Nathalie Guerin
alfa = 1.437e-6;
beta = 2.51;



%curva di compressione treni senza alettoni
d_norm = 5.1e-1;
delta_norm = alfa*d_norm^beta;

i = 1;
for N = 1:10^4:30000000
    dh_norm(i,1) = delta_norm*N;
    i = i+1
end


%curva di compressione treni con alettoni
d_mod = 4.1e-1;
delta_mod = alfa*d_mod^beta;

i = 1;
for N = 1:10^4:30000000
    dh_mod(i,1) = delta_mod*N;
    i = i+1
end


figure
plot(1:10^4:N,dh_norm)
ylabel('dh [mm]')
xlabel('cycles')
hold on
plot(1:10^4:N,dh_mod)
hold off