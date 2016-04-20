%calcolo il carico efficace
if i == 1
    Feff =  Fs;
else
    Feff =  Fs + Ms*(C0*Us+C2*Us1+C3*Us2)+Cs*(C1*Us+C4*Us1+C5*Us2);
    
% %     senza tenere conto dello smorzamento
%     Feff = Fs + Ms*(C0*Us+C2*Us1+C3*Us2);

end

%risolvo il sistema Keff*Usk(i+1)=Feff

% % risolvo con fattorizzazione LU
% y=L\Feff;
% Us_i=U\y;

% % risolvo con fattorizzazione LDLt
% Us_i=solveLDLT(Keff,Feff);

% risolvo con fattorizzazione di Cholesky
y    = Rtrasp\Feff;
Us_i = R\y;

% if i == 1
%     y    = Rtrasp_INIT\Feff;
%     Us_i = R_INIT\y;
% end

%calcolo i valori di velocit� e accelerazione all'istante successivo
Us2_i = C0*(Us_i-Us) - C2*Us1 - C3*Us2;
Us1_i = Us1 + C6*Us2 + C7*Us2_i;


