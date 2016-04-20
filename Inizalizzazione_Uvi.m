Uv = zeros(10,1);
Uv1 = zeros(10,1);
Uv2 = zeros(10,1);

%inizializzazione di Uv (calcolo statico)

% %prendo il vettore della deformata
% if opzione_deterministica == 1
%  N = deformata_det(x,Acorta,Am,Al,Lc,Lm,Ll);
% else
%  N = deformata_pr(x, V, ak, wk, fk );
% end



%carrelli
%contributo forza statica
Uv(3,1) = -((Fv(1,1)/2)+Fv(3,1))/(2*k1);
Uv(5,1) = Uv(3,1);

%cassa
%contributo forza statica
Uv(1,1) = Uv(3,1)-(Fv(1,1)/(2*k2));