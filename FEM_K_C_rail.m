function [K_rail, C_rail] = FEM_K_C_rail(K_rail, C_rail, EI, beams, Pbeams, Kp, Cp, interasse, f, fp, l , lp, s, w1, w2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


C_rail_p = zeros(s,s);
%SE SI VOGLIONO TRASCURARE GLI EFFETTI DATI DAL TAGLIO
% %Kij: matrice di rigidezza dell'elemento ij tra due traverse (nodi liberi)
% Kij = zeros(4,4);
%
% Kij(1,1)=12*EI/(l^3);
% Kij(1,2)=6*EI/(l^2);
% Kij(1,3)=-12*EI/(l^3);
% Kij(1,4)=6*EI/(l^2);
%
% Kij(2,2)=4*EI/(l);
% Kij(2,3)=-6*EI/(l^2);
% Kij(2,4)=2*EI/(l);
%
% Kij(3,3)=12*EI/(l^3);
% Kij(3,4)=-6*EI/(l^2);
%
% Kij(4,4)=4*EI/(l);
%
% Kij = Kij+triu(Kij,1)';


%NON TRASCURANDO GLI EFFETTI DATI DA TAGLIO
% %Kij: matrice di rigidezza dell'elemento ij tra due traverse (nodi
% liberi) di lunghezza l

Kij = zeros(4,4);

Kij(1,1)= w1;
Kij(1,2)= w1*l/2;
Kij(1,3)= -w1;
Kij(1,4)= w1*l/2;

Kij(2,2)= w1*l^2/3 + EI/l;
Kij(2,3)= -w1*l/2;
Kij(2,4)= w1*l^2/6 - EI/l;

Kij(3,3)= w1;
Kij(3,4)= -w1*l/2;

Kij(4,4)= w1*l^2/3 + EI/l;

Kij = Kij+triu(Kij,1)';

% %Kijp: matrice di rigidezza dell'elemento ij tra due traverse (nodi
% liberi) di lunghezza lp

Kijp = zeros(4,4);

Kijp(1,1)= w2;
Kijp(1,2)= w2*lp/2;
Kijp(1,3)= -w2;
Kijp(1,4)= w2*lp/2;

Kijp(2,2)= w2*lp^2/3 + EI/lp;
Kijp(2,3)= -w2*lp/2;
Kijp(2,4)= w2*lp^2/6 - EI/lp;

Kijp(3,3)= w2;
Kijp(3,4)= -w2*lp/2;

Kijp(4,4)= w2*lp^2/3 + EI/lp;

Kijp = Kijp+triu(Kijp,1)';

% % Kis e Ksj: matrici di rigidezza degli elementi ij di lunghezza l connessi
% % all inizio o alla fine della discretizzazione FEM della rotaia in 
% %corrispondenza della traversa
% Kis = Kij + [0, 0, 0, 0; 0, 0, 0, 0; 0, 0, Kp/2, 0; 0, 0, 0, 0];
% Ksj = Kij + [Kp/2, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0];
% 
% %Kss: matrice di rigidezza dell'elemento ij di lunghezza lp degli elementi
% %della roataia posizionati in corrispondenza della traversa
% Kss = Kijp + [Kp/2, 0, 0, 0; 0, 0, 0, 0; 0, 0, Kp/2, 0; 0, 0, 0, 0];

%Kint: matrice assemblata che si ripete ogni interasse
Kint = zeros(2*(beams+2*Pbeams+1));
Kint = sparse(Kint);

%assemblo
i = 1; 

for i = 1:Pbeams
    Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Kijp;
end

i = i + 1;

Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Kij;

i = i + 1;
j = i;

for i = j:j + beams - 3
    Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Kij;
end

i = i + 1;

Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Kij;

i = i + 1;
j = i;

for i = j:j + Pbeams - 1
    Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Kijp;
end
    
%ora assemblo tutta la matrice

i = 1;
while i <= s-size(Kint)+1
    K_rail(i:i+size(Kint)-1,i:i+size(Kint)-1) = K_rail(i:i+size(Kint)-1,i:i+size(Kint)-1) + Kint;
    i = i + size(Kint,1)-2;
end
 



% C_rail = 0.00009*K_rail;
K_rail = zeros(s,s);
K_rail = sparse(K_rail);

%ora aggiungo i vari cp di ogni grado di libertà

% Cis e Csj: componente delle matrici di smorzamento degli elementi ij di lunghezza l connessi
% all inizio o alla fine della discretizzazione FEM della rotaia in 
%corrispondenza della traversa
Cis = [0, 0, 0, 0; 0, 0, 0, 0; 0, 0, Cp/2, 0; 0, 0, 0, 0];
Csj = [Cp/2, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0];

%Css: componente della matrice di smorzamento dell'elemento ij di lunghezza lp degli elementi
%della roataia posizionati in corrispondenza della traversa
Css = [Cp/2, 0, 0, 0; 0, 0, 0, 0; 0, 0, Cp/2, 0; 0, 0, 0, 0];

%Cint: matrice assemblata che si ripete ogni interasse
Cint = zeros(2*(beams+2*Pbeams+1));
Cint = sparse(Cint);

%assemblo
i = 1; 

for i = 1:Pbeams
    Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Css;
end

i = i + 1;

Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Csj;

i = i + 1;
j = i;

for i = j:j + beams - 3
    Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3);
end

i = i + 1;

Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Cis;

i = i + 1;
j = i;

for i = j:j + Pbeams - 1
    Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Cint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Css;
end
    
%ora assemblo tutta la matrice

i = 1;
while i <= s-size(Cint)+1
    C_rail_p(i:i+size(Cint)-1,i:i+size(Cint)-1) = C_rail_p(i:i+size(Cint)-1,i:i+size(Cint)-1) + Cint;
    i = i + size(Cint,1)-2;
end
 




C_rail = C_rail + C_rail_p;
C_rail = sparse(C_rail);


%NON TRASCURANDO GLI EFFETTI DATI DA TAGLIO
% %Kij: matrice di rigidezza dell'elemento ij tra due traverse (nodi
% liberi) di lunghezza l

Kij = zeros(4,4);

Kij(1,1)= w1;
Kij(1,2)= w1*l/2;
Kij(1,3)= -w1;
Kij(1,4)= w1*l/2;

Kij(2,2)= w1*l^2/3 + EI/l;
Kij(2,3)= -w1*l/2;
Kij(2,4)= w1*l^2/6 - EI/l;

Kij(3,3)= w1;
Kij(3,4)= -w1*l/2;

Kij(4,4)= w1*l^2/3 + EI/l;

Kij = Kij+triu(Kij,1)';

% %Kijp: matrice di rigidezza dell'elemento ij tra due traverse (nodi
% liberi) di lunghezza lp

Kijp = zeros(4,4);

Kijp(1,1)= w2;
Kijp(1,2)= w2*lp/2;
Kijp(1,3)= -w2;
Kijp(1,4)= w2*lp/2;

Kijp(2,2)= w2*lp^2/3 + EI/lp;
Kijp(2,3)= -w2*lp/2;
Kijp(2,4)= w2*lp^2/6 - EI/lp;

Kijp(3,3)= w2;
Kijp(3,4)= -w2*lp/2;

Kijp(4,4)= w2*lp^2/3 + EI/lp;

Kijp = Kijp+triu(Kijp,1)';

% Kis e Ksj: matrici di rigidezza degli elementi ij di lunghezza l connessi
% all inizio o alla fine della discretizzazione FEM della rotaia in 
%corrispondenza della traversa
Kis = Kij + [0, 0, 0, 0; 0, 0, 0, 0; 0, 0, Kp/2, 0; 0, 0, 0, 0];
Ksj = Kij + [Kp/2, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0];

%Kss: matrice di rigidezza dell'elemento ij di lunghezza lp degli elementi
%della roataia posizionati in corrispondenza della traversa
Kss = Kijp + [Kp/2, 0, 0, 0; 0, 0, 0, 0; 0, 0, Kp/2, 0; 0, 0, 0, 0];

%Kint: matrice assemblata che si ripete ogni interasse
Kint = zeros(2*(beams+2*Pbeams+1));
% Kint = sparse(Kint);

%assemblo
i = 1; 

for i = 1:Pbeams
    Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Kss;
end

i = i + 1;

Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Ksj;

i = i + 1;
j = i;

for i = j:j + beams - 3
    Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Kij;
end

i = i + 1;

Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Kis;

i = i + 1;
j = i;

for i = j:j + Pbeams - 1
    Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Kint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Kss;
end
    
%ora assemblo tutta la matrice

i = 1;
while i <= s-size(Kint)+1
    K_rail(i:i+size(Kint)-1,i:i+size(Kint)-1) = K_rail(i:i+size(Kint)-1,i:i+size(Kint)-1) + Kint;
    i = i + size(Kint,1)-2;
end
 

end
