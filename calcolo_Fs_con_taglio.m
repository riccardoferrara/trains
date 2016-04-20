%le forze esterne applicate alla sovrastruttura
%
%
%il vettore dei carichi nodali per la rotaia FEM, consiste di due aliquote
%una prima data dal carico distribuito (massa dell'elemento)
%una seconda data dal carico concetrato (ove presente) che è la forza di
%contatto ruota rotaia
%
%
%
%calcolo il carico distribuito per unità di lunghezza dato dalla massa
qv = mr*9.8; %N/m

%calcolo la lunghezza di un elemento BEAM:
% l = Lsimulazione/beams;

%dimensiono il vettore delle forze
Fs = zeros(s+2*n,1);



% 
% % CARICHI NODALI EQUIVALENTI PER CARICO DISTRIBUITO (FORZA PESO) 1:s
% Fs(1:s,1) = (qv)*vettore1;
% 
% Fs(1,1) = qv*lp/2;
% Fs(2,1) = qv*(lp^2)/12*(1+1/(4*w));
% Fs(s-1,1)= qv*lp/2;
% Fs(s,1) = -qv*(lp^2)/12*(1+1/(4*w)) ;
% 
% %CARICHI APPLICATI A TRAVERSE E BALLAST (FORZA PESO)
%  Fs(s+1:s+n,1) = ms*9.8*ones(n,1);
%  Fs(s+n+1:s+2*n,1)=mb*9.8*ones(n,1);

 
 
%CARICHI NODALI EQUIVALENTI PER CARICO CONCENTRATO (ove presente
%rappresenta la forza di contatto)


%il vettore posizione(4,1) mi indica in quali beam si trova il carico


for j = (1:4)
    if campo(j,1) == 1 | campo(j,1) ==3
        %sommo tali componenti ai contributi precedenti
        Fs((posizione(j,1)*2-1),1)   = Fs((posizione(j,1)*2-1),1)   + (1 - mu(j,1)) * Rst(6+j);
        Fs((posizione(j,1)*2-1)+1,1) = Fs((posizione(j,1)*2-1)+1,1) + (X(j,1) - X(j,1)^2/2/lp - mu(j,1)*lp/2) * Rst(6+j);
        Fs((posizione(j,1)*2-1)+2,1) = Fs((posizione(j,1)*2-1)+2,1) + mu(j,1) * Rst(6+j);
        Fs((posizione(j,1)*2-1)+3,1) = Fs((posizione(j,1)*2-1)+3,1) + (X(j,1)^2/2/lp - mu(j,1)*lp/2) * Rst(6+j);
    end
    
    if campo(j,1) == 2 
        %sommo tali componenti ai contributi precedenti
        Fs((posizione(j,1)*2-1),1)   = Fs((posizione(j,1)*2-1),1)   + (1 - mu(j,1)) * Rst(6+j);
        Fs((posizione(j,1)*2-1)+1,1) = Fs((posizione(j,1)*2-1)+1,1) + (X(j,1) - X(j,1)^2/2/l - mu(j,1)*l/2) * Rst(6+j);
        Fs((posizione(j,1)*2-1)+2,1) = Fs((posizione(j,1)*2-1)+2,1) + mu(j,1) * Rst(6+j);
        Fs((posizione(j,1)*2-1)+3,1) = Fs((posizione(j,1)*2-1)+3,1) + (X(j,1)^2/2/l - mu(j,1)*l/2) * Rst(6+j);
    end    
end

Fs = -Fs;

%applicando le condizioni al contorno devo eliminare:
% - 2^ riga
% - s^ riga
Fs(s) = [];
Fs(2) = [];













