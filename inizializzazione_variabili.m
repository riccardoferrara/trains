%inizializzo Us (-2 considerando le condiz. al contorno)
Us  = zeros(s+2*n-2,1);
Us_i = zeros(s+2*n-2,1);
Us1 = zeros(s+2*n-2,1);
Us2 = zeros(s+2*n-2,1);
Us_pf = Us;

% load Us_iniz.mat

%inizializzo in vettore degli spostamenti del veicolo Uv
Inizalizzazione_Uvi
Uv_i = Uv;
Uv1_i = Uv1;
Uv2_i = Uv2;

%calcolo le forze statiche di prima iterazione
Rst(7:10,1) = (Fv(1,1)+2*Fv(3,1)+4*Fv(7,1))/4;

%inizializzo la variabile per le iterazioni NR
NR = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

%inizializzazione posizione ruote
%la posizione delle ruote è determinata da più variabili:
%x(4,1) è un vettore che indica a che ascissa si trovano le ruote
x = zeros(4,1);
%campo(4,1) è un vettore che indica su che campo si trova la ruota: 1,2,o3.
campo = zeros(4,1);
%posizione(4,1) è un vettore che indica su quale beam dell'iesimo campo
%grava la ruota
posizione = zeros(4,1);
%X(4,1) è un vettore che indica l'ascissa relativa al nodo sinistro
X = zeros(4,1);
%Dsx(4,1) è un vettore che indica la distanza dalla traversa sinistra più
%prossima
Dsx = zeros(4,1);
%int(4,1) è un vettore che indica su che interasse si trova la ruota
int = zeros(4,1);
%funzioni di forma: una colonna per ruota
Nf = zeros(4,4);
%funzioni difetto, una per ogni ruota
N = zeros(4,1);
%funzione difetto di tutta la rotaia
NN = zeros(steps-stepsPRELOAD+1, 4);

%calcolo la posizione iniziale delle ruote
posizione_ruote


%inizializzazione degli Vxi
Vxi = zeros(4,1);
Vxik = zeros(4, Nsaving_steps);

%inizializzazione del vettore che registra la deformazione dello step
%precedente (per calcolarne la derivata prima
D0 = zeros(4,1);
%deformazione dello step iterante
D = zeros(4,1);

%inizializzazione temporale
i  = 1; %step simulazione
ss = 1; %saving step
gg = 1; %saving step
pp = 1; %preload step