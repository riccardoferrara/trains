%riaggiungo le righe sottratte per le condizioni al contorno
%sposto di 2righe la parte più bassa
Usk(s+1:s+2*n,:) = Usk(s-1:s+2*n-2,:);
Us1k(s+1:s+2*n,:) = Us1k(s-1:s+2*n-2,:);
Us2k(s+1:s+2*n,:) = Us2k(s-1:s+2*n-2,:);
%sposto di 1riga la parte di mezzo
Usk(3:s-1,:) = Usk(2:s-2,:);
Us1k(3:s-1,:) = Us1k(2:s-2,:);
Us2k(3:s-1,:) = Us2k(2:s-2,:);
%azzero la seconda riga
Usk(2,:) = zeros(1,size(Usk,2));
Us1k(2,:) = zeros(1,size(Us1k,2));
Us2k(2,:) = zeros(1,size(Us2k,2));
%azzero la riga s
Usk(s,:) = zeros(1,size(Usk,2));
Us1k(s,:) = zeros(1,size(Us1k,2));
Us2k(s,:) = zeros(1,size(Us2k,2));