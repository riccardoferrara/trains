%calcolo l'ascissa della prima ruota
if i > stepsPRELOAD
    x(1,1) = (i-stepsPRELOAD)*dt*V + 0.50; 
else
    x(1,1) = 0.50;
end


%calcolo l'ascissa delle altre ruote
for j=(2:4)
    x(j,1)=x(1,1)+distanze_ruote(j,1);
end

%per il primo step lancio un calcolo iterativo per capire su che beam si
%trovano le ruote ---> posizione(j,1)
for j = 1:4
    %calcolo in che interasse si trovano le ruote
    int(j,1) = floor(x(j,1)/interasse)+1;
    
    %calcolo la distanza delle ruote dalla traversa sinistra più
    %prossima
    Dsx(j,1) = x(j,1) - (int(j,1)-1)*interasse;
    
    %calcolo su che beam si trova la ruota (può essere in tre campi)
    %campo1
    if Dsx(j,1) < Pw/2
        posizione(j,1) = floor(Dsx(j,1)/lp) + 1;
        X(j,1) = Dsx(j,1) - (posizione(j,1)-1)*lp;
        campo(j,1) = 1;
        posizione(j,1) = posizione(j,1)+ (int(j,1)-1)*INTbeams;
        mu(j,1) = (-2*X(j,1)^3 + 3*lp*X(j,1)^2 + 12*w*X(j,1))/(lp^3 + 12*w*lp);
        %funzioni di forma per spostamenti  
        Nf(1,j) = 1/(1+fp) * (2*(X(j,1)/lp)^3 - 3*(X(j,1)/lp)^2 - fp*X(j,1)/lp + (1+fp));
        Nf(2,j) = lp/(1+fp) * (-(X(j,1)/lp)^3 + (4+fp)/2*(X(j,1)/lp)^2 - (2+fp)/2*(X(j,1)/lp));
        Nf(3,j) = 1/(1+fp) * (-2*(X(j,1)/lp)^3 + 3*(X(j,1)/lp)^2 + fp*(X(j,1)/lp));
        Nf(4,j) = lp/(1+fp) * (-(X(j,1)/lp)^3 + (2-fp)/2*(X(j,1)/lp)^2 + fp/2*(X(j,1)/lp));
%         %funzioni di forma per rotazioni
%         Nfp(5,j) = 6/lp/(1+fp)*(X(j,1)/lp)*(1-X(j,1)/lp);
%         Nfp(6,j) = 1/(1+fp)*(3*(X(j,1)/lp)^2 - (4+fp)*(X(j,1)/lp) + (1+fp));
%         Nfp(7,j) = -6/lp/(1+fp)*(X(j,1)/lp)*(1-X(j,1)/lp);
%         Nfp(8,j) = 1/(1+fp)*(3*(X(j,1)/lp)^2 + (-2+fp)*(X(j,1)/lp));
%         %funzioni di forma per spostamenti senza f
%         Nf(1:4,j) = [ (2*X(j,1)^3)/lp^3 - (3*X(j,1)^2)/lp^2 + 1; X(j,1)^3/lp^3 - (2*X(j,1)^2)/lp^2 + X(j,1)/lp; (3*X(j,1)^2)/lp^2 - (2*X(j,1)^3)/lp^3; X(j,1)^3/lp^3 - X(j,1)^2/lp^2];
%         Nf(2,j) = Nf(2,j)*lp;
%         Nf(4,j) = Nf(4,j)*lp;
    end
    
    %campo2
    if Dsx(j,1) >= Pw/2
        if Dsx(j,1) < Pw/2 + (interasse - Pw)
            posizione(j,1) = floor((Dsx(j,1)-lp*Pbeams)/l) + 1;
            X(j,1) = Dsx(j,1) - lp*Pbeams - (posizione(j,1)-1)*l;
            campo(j,1) = 2;
            posizione(j,1) = posizione(j,1)+ (int(j,1)-1)*INTbeams + Pbeams;
            mu(j,1) = (-2*X(j,1)^3+3*l*X(j,1)^2+12*w*X(j,1))/(l^3+12*w*l);
            %funzioni di forma per spostamenti
            Nf(1,j) = 1/(1+f) * (2*(X(j,1)/l)^3 - 3*(X(j,1)/l)^2 - f*X(j,1)/l + (1+f));
            Nf(2,j) = l/(1+f) * (-(X(j,1)/l)^3 + (4+f)/2*(X(j,1)/l)^2 - (2+f)/2*(X(j,1)/l));
            Nf(3,j) = 1/(1+f) * (-2*(X(j,1)/l)^3 + 3*(X(j,1)/l)^2 + f*(X(j,1)/l));
            Nf(4,j) = l/(1+f) * (-(X(j,1)/l)^3 + (2-f)/2*(X(j,1)/l)^2 + f/2*(X(j,1)/l));
%             %funzioni di forma fer rotazioni
%             Nf(5,j) = 6/l/(1+ff)*(X(j,1)/l)*(1-X(j,1)/l);
%             Nf(6,j) = 1/(1+ff)*(3*(X(j,1)/l)^2 - (4+ff)*(X(j,1)/l) + (1+ff));
%             Nf(7,j) = -6/l/(1+ff)*(X(j,1)/l)*(1-X(j,1)/l);
%             Nf(8,j) = 1/(1+ff)*(3*(X(j,1)/l)^2 + (-2+ff)*(X(j,1)/l));
%             %funzioni di forma per spostamenti senza f
%             Nf(1:4,j) = [ (2*X(j,1)^3)/l^3 - (3*X(j,1)^2)/l^2 + 1; X(j,1)^3/l^3 - (2*X(j,1)^2)/l^2 + X(j,1)/l; (3*X(j,1)^2)/l^2 - (2*X(j,1)^3)/l^3; X(j,1)^3/l^3 - X(j,1)^2/l^2];
%             Nf(2,j) = Nf(2,j)*l;
%             Nf(4,j) = Nf(4,j)*l;
        end
    end
    
    %campo3
    if Dsx(j,1) >= Pw/2+(interasse-Pw)
        posizione(j,1) = floor((Dsx(j,1)-lp*Pbeams-l*beams)/lp) + 1;
        X(j,1) = Dsx(j,1) - lp*Pbeams - l*beams - (posizione(j,1)-1)*lp;
        campo(j,1) = 3;
        posizione(j,1) = posizione(j,1)+ (int(j,1)-1)*INTbeams + Pbeams + beams;
        mu(j,1) = (-2*X(j,1)^3+3*lp*X(j,1)^2+12*w*X(j,1))/(lp^3+12*w*lp);
        %funzioni di forma per spostamenti  
        Nf(1,j) = 1/(1+fp) * (2*(X(j,1)/lp)^3 - 3*(X(j,1)/lp)^2 - fp*X(j,1)/lp + (1+fp));
        Nf(2,j) = lp/(1+fp) * (-(X(j,1)/lp)^3 + (4+fp)/2*(X(j,1)/lp)^2 - (2+fp)/2*(X(j,1)/lp));
        Nf(3,j) = 1/(1+fp) * (-2*(X(j,1)/lp)^3 + 3*(X(j,1)/lp)^2 + fp*(X(j,1)/lp));
        Nf(4,j) = lp/(1+fp) * (-(X(j,1)/lp)^3 + (2-fp)/2*(X(j,1)/lp)^2 + fp/2*(X(j,1)/lp));
%         %funzioni di forma per rotazioni
%         Nfp(5,j) = 6/lp/(1+fp)*(X(j,1)/lp)*(1-X(j,1)/lp);
%         Nfp(6,j) = 1/(1+fp)*(3*(X(j,1)/lp)^2 - (4+fp)*(X(j,1)/lp) + (1+fp));
%         Nfp(7,j) = -6/lp/(1+fp)*(X(j,1)/lp)*(1-X(j,1)/lp);
%         Nfp(8,j) = 1/(1+fp)*(3*(X(j,1)/lp)^2 + (-2+fp)*(X(j,1)/lp));
%         %funzioni di forma per spostamenti senza f
%         Nf(1:4,j) = [ (2*X(j,1)^3)/lp^3 - (3*X(j,1)^2)/lp^2 + 1; X(j,1)^3/lp^3 - (2*X(j,1)^2)/lp^2 + X(j,1)/lp; (3*X(j,1)^2)/lp^2 - (2*X(j,1)^3)/lp^3; X(j,1)^3/lp^3 - X(j,1)^2/lp^2];
%         Nf(2,j) = Nf(2,j)*lp;
%         Nf(4,j) = Nf(4,j)*lp;
        
    end

    
%     %calcolo le ascisse dei nodi che utilizzo per l'interpolazione polinomiale
%     %controllo che l'ultima ruota abbia abbastanza nodi davanti per fare
%     %l'interpolazione
%     %il polinomio interpolante considera un numero di nodi uguale a quelli
%     %dell'interasse se il numero di nodi di un interasse è pari altrimenti
%     %prende un numero uguale al pari più grande
%     if Lsimulazione-x(j,1)>interasse/4+max(l,lp)
% %         Xinterp(:,j) = Xtot(posizione(j,1)-floor(INTbeams/4):posizione(j,1)+floor(INTbeams/4)+1,1);
%         Xinterp(:,j) = Xtot(posizione(j,1)-3:posizione(j,1)+4,1);
%                 
%     else
%         %se non ci sono abbastanza nodi solo la 4^ruota la interpolo coi
%         %nodi dell'ultimo interasse
%         Xinterp(:,j) = Xtot((TOTbeams+1)-(INTbeams+1)+1:(TOTbeams+1),1);
%     end
%     
%     %calcolo il coefficiente mu che mi serve per la derivata della forza di
%     %contatto lato substruttura
%         
end    




    