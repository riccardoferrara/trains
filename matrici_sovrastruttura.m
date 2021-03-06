%Compilo Ms, Ks, Cs
%
%
%

% %lunghezza di un elemento beam 
% l = Lsimulazione/beams;

% %vettore fittizio che mi serve per la matrice delle masse vettore4= 1, 0, 1, 0,...
% j = 1;
% vettore4 = zeros(s,1);
% while j<s
%     vettore4(j)=1;
%     j = j + 2;
% end

consistent_timoshenko_mass_matrix2

%sottomatrici preliminari per Ks e Cs
%
%
%per costruire la matrice delle rigidezze/smorzamenti costruisco 
%prima delle matrici ausiliarie A(nxn),B(nxs),C(nxn), D(nxn)

%SCRITTURA DELLE MATRICE AK E AC 
Ak = (Kb + (2*Pbeams+1)*Kp)*eye(n,n);
Ac = (Cb + (2*Pbeams+1)*Cp)*eye(n,n);

%SCRITTURA DELLA MATRICE BK e BC
Bk = zeros(n,s);
Bc = zeros(n,s);

j = 1;
for i = (1:n)
        Bk(i,j)= -Kp;
        Bc(i,j)= -Cp;
       
        for h = 1:Pbeams
            if i ~= n 
                Bk(i,j+2*h) = -Kp;
                Bc(i,j+2*h) = -Cp;
            end
            if i ~= 1
                Bk(i,j-2*h) = -Kp;
                Bc(i,j-2*h) = -Cp;
            end
        end
        
        j = j + 2*(beams+2*Pbeams);      
end

%reinizializzo la variabile "i" (presa in prestito)
i = 1;

%SCRITTURA DELLA MATRICE CK e CC
Ck = (2*Kw+Kb+Kf)*eye(n,n);
Cc = (2*Cw+Cb+Cf)*eye(n,n);

%condizioni al contorno
Ck(1,1) = (Kw+Kb+Kf);
Cc(n,n) = (Cw+Cb+Cf);

for j =(1:n)
    for h =(1:n)

        if h == j + 1
            Ck(j, h) = -Kw;
        end

        if h == j - 1
            Ck(j, h) = -Kw;
        end

        if h == j + 1
            Cc(j, h) = -Cw;
        end

        if h == j - 1
            Cc(j, h) = -Cw;
        end
    
    end
end


%SCRITTURA DELLA MATRICE DK e DC
Dk = -Kb*eye(n);
Dc = -Cb*eye(n);



%Ks e Cs - matrici delle rigidezze e degli smorzamenti
Ks = zeros(s+2*n,s+2*n);
Cs = zeros(s+2*n,s+2*n);
Ks = sparse(Ks);
Cs = sparse(Cs);


%compilo la matrice nel seguente ordine:

%      |       |   |   |
%      |   1   | 6 | 0 |
%      |       |   |   |
%      |_______|___|___|
%  K = |       |   |   |
%      |___7___|_2_|_4_|
%      |       |   |   |
%      |   0   | 5 | 3 |
%   

Ks = [K_rail, Bk', zeros(s,n); Bk, Ak, Dk; zeros(n, s), Dk', Ck];
% Cs = [0.00009*K_rail+0.000001*Ms(1:s,1:s), Bc', zeros(s,n); Bc, Ac, Dc; zeros(n, s), Dc', Cc];
Cs = [C_rail, Bc', zeros(s,n); Bc, Ac, Dc; zeros(n, s), Dc', Cc];

% Ms = Ms;
% Ks = Ks;
% Cs = Cs;


%applicando le condizioni al contorno devo eliminare:
% - la 2^ riga e 2^ colonna (rotazione primo beam rotaia)
% - la s^ riga e n^ colonna (rotazione ultimo beam rotaia)
%con il seguente comando le matrici diventeranno di dimensione (s+2n-2)

Ks(s,:) = [];
Ks(:,s) = [];
Ks(2,:) = [];
Ks(:,2) = [];


Cs(s,:) = [];
Cs(:,s) = [];
Cs(2,:) = [];
Cs(:,2) = [];

Ms(s,:) = [];
Ms(:,s) = [];
Ms(2,:) = [];
Ms(:,2) = [];

%calcolo la Keff per la risoluzione con Newmark
Keff = zeros(s+2*n-2,s+2*n-2);
Keff = sparse(Keff);

%calcolo la K efficace
Keff = Ks + C0*Ms + C1*Cs;

%fattorizzo e traspongo per chol
R = chol(Keff);
Rtrasp = R';
% 
% %fattorizzo e traspongo per LU
% [L,U]=lu(Keff);

clear Keff

% %DATI PER L'INIZIALIZZAZIONE
% Ms_INIT = zeros(s+2*n,s+2*n);
% Ms_INIT = sparse(Ms_INIT);
% 
% Ms_INIT(s,:) = [];
% Ms_INIT(:,s) = [];
% Ms_INIT(2,:) = [];
% Ms_INIT(:,2) = [];
% 
% Keff_INIT = zeros(s+2*n-2,s+2*n-2);
% Keff_INIT= sparse(Keff_INIT);
% 
% Keff_INIT = Ks  + C0*Ms_INIT + C1*Cs;
% R_INIT = chol(Keff_INIT);
% 
% Rtrasp_INIT = R_INIT';
% 
% clear Ms_INIT
% clear Keff_INIT
