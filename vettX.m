%vettore delle ascisse del primo interasse
Xint=zeros(INTbeams+1,1);
%vettore delle ascisse
Xtot=zeros((n-1)*(INTbeams)+1,1);

%campo1: sommo la lunghezza dei Pbeams
for g = 1:Pbeams
    Xint(g+1,1) = Xint(g,1)+lp;
end

%campo2:sommo la lunghezza dei beams
for g = Pbeams+1:(Pbeams+beams)
    Xint(g+1,1) = Xint(g,1)+l;
end

%campo3:sommo la lunghezza dei Pbeams
for g = (Pbeams+beams)+1:INTbeams
    Xint(g+1,1) = Xint(g,1)+lp;
end

%costruisco il vettore totale delle ascisse
for g = 1:n-1
    Xtot([(g-1)*INTbeams+1:(g)*INTbeams+1],1)=Xint + interasse*(g-1)*ones(size(Xint,1),1);
end