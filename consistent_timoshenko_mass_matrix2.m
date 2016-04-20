%Ms - matrice delle masse
Ms = zeros(s+2*n,s+2*n);
Ms = sparse(Ms);


% matrice delle masse dell'elemento di lunghezza l
Mij = zeros(4,4);

Mij(1,1) = 13*l/35 + 7*l*f/10 + l*f^2/3;
Mij(1,2) = 11*l^2/210 + 11*l^2*f/120 + l^2*f^2/24;
Mij(1,3) = 9*l/70 + 3*l*f/10 + l*f^2/6;
Mij(1,4) = -13*l^2/420 - 3*l^2*f/40 - l^2*f^2/24;

Mij(2,2) = l^3/105 + l^3*f/60 + l^3*f^2/120;
Mij(2,3) = 13*l^2/420 + 3*l^2*f/40 + l^2*f^2/24;
Mij(2,4) = -l^3/140 - l^3*f/60 - l^3*f^2/120;

Mij(3,3) = 13*l/35 + 7*l*f/10 + l*f^2/3;
Mij(3,4) = -11*l^2/210 - 11*l^2*f/120 - l^2*f^2/24;

Mij(4,4) = l^3/105 + l^3*f/60 + l^3*f^2/120;

% Mij(1,2) = -Mij(1,2);
% Mij(1,4) = -Mij(1,4);
% Mij(2,3) = -Mij(2,3);
% Mij(3,4) = -Mij(3,4);

Mij = Mij + triu(Mij,1)';
Mij = Mij*(mr/(1+f)^2);

%l'altra parte
Mij2 = zeros(4,4);

Mij2(1,1) = 6/5/l;
Mij2(1,2) = 1/10 - f/2;
Mij2(1,3) = -6/5/l;
Mij2(1,4) = 1/10 - f/2;

Mij2(2,2) = 2*l/15 + l*f/6 + l*f^2/3;
Mij2(2,3) = -1/10 + f/2;
Mij2(2,4) = -l/30 - l*f/6 + l*f^2/6;

Mij2(3,3) = 6/5/l;
Mij2(3,4) = -1/10 + f/2;

Mij2(4,4) = 2*l/15 + l*f/6 + l*f^2/3;

% Mij2(1,2) = -Mij2(1,2);
% Mij2(1,4) = -Mij2(1,4);
% Mij2(2,3) = -Mij2(2,3);
% Mij2(3,4) = -Mij2(3,4);

Mij2 = Mij2 + triu(Mij2,1)';
Mij2 = Mij2*(mr/S*I/(1+f)^2);

Mij = Mij + Mij2;

% matrice delle masse dell'elemento di lunghezza lp
Mijp = zeros(4,4);

Mijp(1,1) = 13*lp/35 + 7*lp*fp/10 + lp*fp^2/3;
Mijp(1,2) = 11*lp^2/210 + 11*lp^2*fp/120 + lp^2*fp^2/24;
Mijp(1,3) = 9*lp/70 + 3*lp*fp/10 + lp*fp^2/6;
Mijp(1,4) = -13*lp^2/420 - 3*lp^2*fp/40 - lp^2*fp^2/24;

Mijp(2,2) = lp^3/105 + lp^3*fp/60 + lp^3*fp^2/120;
Mijp(2,3) = 13*lp^2/420 + 3*lp^2*fp/40 + lp^2*fp^2/24;
Mijp(2,4) = -lp^3/140 - lp^3*fp/60 - lp^3*fp^2/120;

Mijp(3,3) = 13*lp/35 + 7*lp*fp/10 + lp*fp^2/3;
Mijp(3,4) = -11*lp^2/210 - 11*lp^2*fp/120 - lp^2*fp^2/24;

Mijp(4,4) = lp^3/105 + lp^3*fp/60 + lp^3*fp^2/120;

% Mijp(1,2) = -Mijp(1,2);
% Mijp(1,4) = -Mijp(1,4);
% Mijp(2,3) = -Mijp(2,3);
% Mijp(3,4) = -Mijp(3,4);

Mijp = Mijp + triu(Mijp,1)';
Mijp = Mijp*(mr/(1+fp)^2);

%l'altra parte
Mijp2 = zeros(4,4);

Mijp2(1,1) = 6/5/lp;
Mijp2(1,2) = 1/10 - fp/2;
Mijp2(1,3) = -6/5/lp;
Mijp2(1,4) = 1/10 - fp/2;

Mijp2(2,2) = 2*lp/15 + lp*fp/6 + lp*fp^2/3;
Mijp2(2,3) = -1/10 + fp/2;
Mijp2(2,4) = -lp/30 - lp*fp/6 + lp*fp^2/6;

Mijp2(3,3) = 6/5/lp;
Mijp2(3,4) = -1/10 + fp/2;

Mijp2(4,4) = 2*lp/15 + lp*fp/6 + lp*fp^2/3;

Mijp2 = Mijp2 + triu(Mijp2,1)';
Mijp2 = Mijp2*(mr/S*I/(1+fp)^2);

% Mijp2(1,2) = -Mijp2(1,2);
% Mijp2(1,4) = -Mijp2(1,4);
% Mijp2(2,3) = -Mijp2(2,3);
% Mijp2(3,4) = -Mijp2(3,4);

Mijp = Mijp + Mijp2;


%Mint: matrice assemblata che si ripete ogni interasse
Mint = zeros(2*(beams+2*Pbeams+1));
Mint = sparse(Mint);

%assemblo
i = 1; 

for i = 1:Pbeams
    Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Mijp;
end

i = i + 1;

Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Mij;

i = i + 1;
j = i;

for i = j:j + beams - 3
    Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Mij;
end

i = i + 1;

Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Mij;

i = i + 1;
j = i;

for i = j:j + Pbeams - 1
    Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) = Mint((2*i-1):(2*i-1)+3,(2*i-1):(2*i-1)+3) + Mijp;
end
    
%ora assemblo tutta la matrice

i = 1;
while i <= s-size(Mint)+1
    Ms(i:i+size(Mint)-1,i:i+size(Mint)-1) = Ms(i:i+size(Mint)-1,i:i+size(Mint)-1) + Mint;
    i = i + size(Mint,1)-2;
end


%elementi traverse e ballast
Ms(s+1:s+n,s+1:s+n)=ms*eye(n,n);
Ms(s+1+n:s+2*n,s+1+n:s+2*n)=mb*eye(n,n);

clear Mint
clear Mijp
clear Mij
clear Mij2
clear Mijp2