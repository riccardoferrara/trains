% function [Vxi,Vxik] = abbassamento_ruote(i, posizione, steps, dt, Us, V, TOTbeams, stepsPRELOAD, gg, Vxik, x, INTbeams, Xtot, interasse, Lsimulazione, l, lp, Xinterp, campo)
function [Vxi,Vxik] = abbassamento_ruote(i, posizione, Us, gg, Vxik, X, lp, campo, l, Nf)

%calolo l'abbassamento della rotaia in corrispondenza delle ruote è da
%notare che sia la posizione delle ruote, sia la deformata sono in realtà
%dell'istante precedente rispetto quello usato nel modello veicolo - PRIMA
%- adesso cerco di reinserirli nel modello veicolo ma nello stesso istante
%temporale

Vxi = zeros(4,1);

%INTERPOLAZIONE CON FUNZIONI DI FORMA
for j = (1:4)
    Vxi(j,1) = Nf(:,j)'*Us(posizione(j,1)*2-2:posizione(j,1)*2+1);
end




% INTERPOLAZIONE LINEARE
% Vxi = zeros(4,1);

% if i>1
%     for j = (1:4)
%         %se sono nel 1°beam viste le condizioni al contorno
%         %devo inserire una condizione
%         if posizione(j,1) == 1
%             Vxi(j,1) = (Us(posizione(j,1)*2-1)+(Us(posizione(j,1)*2)-Us(posizione(j,1)*2-1))*X(j,1)/lp);
%         else
%             if campo(j,1) == 1 | campo(j,1) == 3
%                 Vxi(j,1) = (Us(posizione(j,1)*2-2)+(Us(posizione(j,1)*2)-Us(posizione(j,1)*2-2))*X(j,1)/lp);
%             end
%             if campo(j,1) == 2
%                  Vxi(j,1) = (Us(posizione(j,1)*2-2)+(Us(posizione(j,1)*2)-Us(posizione(j,1)*2-2))*X(j,1)/l);
%             end 
%         end
%     end
% end
% 
% %INTERPOLAZIONE SPLINE
% Vxi = zeros(4,1);
% for j = (1:4)
%     %controllo che l'ultima ruota abbia abbastanza nodi davanti per fare
%     %l'interpolazione
%     if Lsimulazione-x(j,1)>interasse/2
%         XinterpSP = Xtot(posizione(j,1)-floor(INTbeams/2):posizione(j,1)+floor(INTbeams/2),1);
%         YinterpSP = Us((posizione(j,1)-floor(INTbeams/2))*2:2:(posizione(j,1)+floor(INTbeams/2))*2);
%         Vxi(j,1) = spline(XinterpSP,YinterpSP,x(j,1));
%     else
%         %se non ci sono abbastanza nodi solo la 4^ruota la interpolo coi
%         %nodi dell'ultimo interasse
%         XinterpSP = Xtot((TOTbeams+1)-(INTbeams+1)+1:(TOTbeams+1),1);
%         YinterpSP = Us(2*(TOTbeams+1)-2-2*(INTbeams):2:2*(TOTbeams+1)-2);
%         Vxi(j,1) = spline(XinterpSP,YinterpSP,x(j,1));
%     end
% end


% %INTERPOLAZIONE PARABOLICA
% Vxi = zeros(4,1);
% if i>1
%     for j = (1:4)
%         %se sono nel 1°beam viste le condizioni al contorno
%         %devo inserire una condizione
%         if posizione(j,1) == 1
%             Vxi(j,1) = (Us(posizione(j,1)*2-1)+(Us(posizione(j,1)*2)-Us(posizione(j,1)*2-1))*X(j,1)/lp);
%         else
%             if campo(j,1) == 1 | campo(j,1) == 3
%                 a = (Us(posizione(j,1)*2+1)-Us(posizione(j,1)*2-1))/(2*lp);
%                 B = Us(posizione(j,1)*2-1);
%                 %componente parabolica
%                 Vxi(j,1) = abs(a*lp*X(j,1)-a*X(j,1)^2)/((a*lp+B)^2+1)^0.5;
%                 %sommo la componente lineare (+ se "a" è negativo -
%                 %concavità verso l'alto con y verso il basso)
%                 Vxi(j,1) = Vxi(j,1) -a/abs(a)*(Us(posizione(j,1)*2-2)+(Us(posizione(j,1)*2)-Us(posizione(j,1)*2-2))*X(j,1)/lp);
%             end
%             if campo(j,1) == 2
%                 a = (Us(posizione(j,1)*2+1)-Us(posizione(j,1)*2-1))/(2*l);
%                 B = Us(posizione(j,1)*2-1);
%                 %componente parabolica
%                 Vxi(j,1) = abs(a*l*X(j,1)-a*X(j,1)^2)/((a*l+B)^2+1)^0.5;
%                 %sommo la componente lineare (+ se "a" è negativo -
%                 %concavità verso l'alto con y verso il basso)
%                 Vxi(j,1) = Vxi(j,1) - a/abs(a)*(Us(posizione(j,1)*2-2)+(Us(posizione(j,1)*2)-Us(posizione(j,1)*2-2))*X(j,1)/l);
%             end 
%         end
%     end
% end


% % INTERPOLAZIONE HERMITIANA
% 
% if i>1
%     for j = (1:4)
%         %se sono nel 1°beam viste le condizioni al contorno
%         %devo inserire una condizione
%         if posizione(j,1) == 1
%             Vxi(j,1) = (Us(posizione(j,1)*2-1)+(Us(posizione(j,1)*2)-Us(posizione(j,1)*2-1))*X(j,1)/lp);
%         else
%             if campo(j,1) == 1 | campo(j,1) == 3
%                hermit(1,1) = lp - 3*(X(j,1)/lp)^2+2*(X(j,1)/lp)^3;
%                hermit(2,1) = X(j,1) - 2*(X(j,1)^2/lp)+X(j,1)^3/lp^2;
%                hermit(3,1) =3*(X(j,1)/lp)^2-2*(X(j,1)/lp)^3;
%                hermit(4,1) = -(X(j,1)^2/lp)+X(j,1)^3/lp^2;
%                Vxi(j,1) = hermit(:,1)'*Us(posizione(j,1)*2-2:posizione(j,1)*2+1);
%             end
%             if campo(j,1) == 2
%                hermit(1,1) = l - 3*(X(j,1)/l)^2+2*(X(j,1)/l)^3;
%                hermit(2,1) = X(j,1) - 2*(X(j,1)^2/l)+X(j,1)^3/l^2;
%                hermit(3,1) =3*(X(j,1)/l)^2-2*(X(j,1)/l)^3;
%                hermit(4,1) = -(X(j,1)^2/l)+X(j,1)^3/l^2;
%                Vxi(j,1) = hermit(:,1)'*Us(posizione(j,1)*2-2:posizione(j,1)*2+1);
% 
%             end 
%         end
%     end
% end
% 
% %INTERPOLAZIONE POLINOMIALE
% Vxi = zeros(4,1);
% for j = (1:4)
%     %controllo che l'ultima ruota abbia abbastanza nodi davanti per fare
%     %l'interpolazione
%     %il polinomio interpolante considera un numero di nodi uguale a quelli
%     %dell'interasse se il numero di nodi di un interasse è pari altrimenti
%     %prende un numero uguale al pari più grande
%     if Lsimulazione-x(j,1)>interasse/4+max(l,lp)
% %         Yinterp = Us((posizione(j,1)-floor(INTbeams/4))*2-1:2:(posizione(j,1)+floor(INTbeams/4))*2+1);
%         Yinterp = Us((posizione(j,1)-3)*2-1:2:(posizione(j,1)+4)*2-1);
%         ws = warning('off','all');  % Turn off warning
%         p = polyfit(Xinterp(:,j), Yinterp, size(Xinterp(:,j),1)-1);
%         
%         Vxi(j,1) = polyval(p,x(j,1));
%     else
%         %se non ci sono abbastanza nodi solo la 4^ruota la interpolo coi
%         %nodi dell'ultimo interasse
%         Yinterp = Us(2*(TOTbeams+1)-1-2*(INTbeams):2:2*(TOTbeams+1)-1);
%         p = polyfit(Xinterp(:,j), Yinterp, size(Xinterp(:,j),1)-1);
%         
%         Vxi(j,1) = polyval(p,x(j,1));
%     end
% end
% 
% Vxik(:,gg)=Vxi;

end