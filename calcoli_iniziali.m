%inserisco il modulo elastico dell'acciaio in N/m2
E = 2.07*10^11;

% inserisco il modulo a taglio della rotaia in N/m2
G = 8.1*10^10;
G = E/2/1.3;


%calcolo l'intervallo di tempo per la simulazione
dt = Lc/V/d;
set(handles.intervallo, 'string', dt);

%calcolo della costante hertziana
% Gh = 4.57*(diametro_ruota/2)^(-0.149)*10^(-8);
raggio_rotaia = 0.3;
diametro_ruota = 0.4575*2; %tgv
% diametro_ruota = 0.39*2; %x2000

% Kh = (4*G*((diametro_ruota/2*raggio_rotaia)^1/4)/3/(1-(E/2/G-1)));
Gh = 4.57*(diametro_ruota/2)^(-0.149)*10^(-8);
Kh = Gh^(-3/2);
% Gh = 6.04*10^-8;
% Gh = 7*10^-7;
% Gh = (10^11)^(-2/3);
% Ch = 0.87*10^11;
% Kh = 0.90*10^11;
Kh = 0.87*10^11;
% Kh = 0.3*10^10;
% Ch =9*10^4;
% Ch =3*10^4;
% Ch = 155*10^3;
Ch = 0;


%calcolo quanti step eseguire in preload
stepsPRELOAD = round(T_preload/dt);

%calcolo quanti step eseguire senza difetti
stepsNODIFETTI = round(Lnodifetti/V/dt)+round(T_preload/dt);
    
%cambio la lunghezza della simulazione in modo che sia multiplo
%dell'interasse
Lsimulazione = round(Lsimulazione/interasse)*interasse;

%calcolo il numero di elementi traverse/ballast presenti
n = round(Lsimulazione/interasse) + 1;

%numero beams presenti in un interasse
INTbeams = beams + 2*Pbeams;

%calcolo il numero di elementi beams ed il numero di nodi FEM rotaia
TOTbeams = (n-1)*INTbeams;

%numero gdl rotaia FEM
s = ((TOTbeams+1)*2);

%calcolo il numero di iterazioni necessarie
steps = round((Lsimulazione-distanze_ruote(4)-0.5)/V/dt)+round(T_preload/dt);
set(handles.STEPS,'string',steps)

%predimensiono la matrice FEM rotaia
K_rail = zeros(s,s);
K_rail = sparse(K_rail);
C_rail = zeros(s,s);
C_rail = sparse(C_rail);

%calcolo la lunghezza di un elemento beam ij o is o js
l = (interasse-Pw)/beams;

%calcolo la lunghezza di un elemento beam ss
lp = Pw/(2*Pbeams);

%calcolo del modulo di rigidezza flessionale
EI = E*I;

%calcolo il coefficiente fi per le matrici di rigidezza
f = 12*EI/(G*S*chi*l^2);
fp = 12*EI/(G*S*chi*lp^2);

%calcolo di un coefficiente semplificativo per il calcolo del vettore dei
%carichi nodali equivalenti
w = EI/(G*S*chi);

%coefficiente per le matrici di rigidezza fem
w1 = G*S/chi/l;
w2 = G*S/chi/lp;

%vettore1a vettore3a ausiliari per la costruzione del vettore1 e vettore3
vettore1a = zeros(2*(INTbeams+1),1);
vettore3a = zeros(2*(INTbeams+1),1);

for j = 1:2:2*Pbeams
    vettore1a(j) = lp;
    vettore3a(j+1) = lp^3;
end
vettore1a(j+2) = lp/2 + l/2;
vettore3a(j+2+1) = (lp^3+l^3)/2;
for j = 2*Pbeams+3:2:2*(beams + Pbeams)
    vettore1a(j) = l;
    vettore3a(j+1) = l^3;
end
vettore1a(j+2) = lp/2 + l/2;
vettore3a(j+2+1) = (lp^3+l^3)/2;
for j = 2*(beams + Pbeams)+3:2:2*(INTbeams+1)
    vettore1a(j) = lp;
    vettore3a(j+1) = lp^3;
end

%creo un vettore che mi serve in seguito per la costruzione delle matrici
vettore1 = zeros(s,1);
vettore3 = zeros(s,1);

j = 1;
while j+2<s
    vettore1(j:j+size(vettore1a,1)-1)= vettore1a;
    vettore3(j:j+size(vettore3a,1)-1) = vettore3a;
    j = j + size(vettore1a,1)-2;
    
end


%grado di libert� totali del sistema
gdl = s+2*n+10;