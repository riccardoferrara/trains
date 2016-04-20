%2 - calcolo del vettore bv
bv =   Fv + Kv*(Uv+dt*Uv1+((dt^2)/3)*Uv2) + Cv*(Uv1+(dt/2)*Uv2);

%inizializzazione iterazioni
check = 0;
k = 1;

%inizializzazione della variabile Uv2(i+1) che chiameremo NR
% NR = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

%iterazioni per ogni step temporale di New-Raph    
while(check==0)
    %A: 
    %
    %
    %
    %cominciano da qui le iterazioni per Newt-Raph per il calcolo del
    %vettore spostamenti nel veicolo


    %3 - cacolo la matrice R(4x4) diagonale che mi serve per definire il
    %Jacobiano


    r = [0;0;0;0];

    for j=(1:4)
        if Uv(6+j,1)+dt*Uv1(6+j,1)+(dt^2)/6*(NR(6+j,1)+2*Uv2(6+j,1))-(Vxi(j,1)+N(j))<0 
            r(j,1) = Kh*(dt^2)/4*(abs(Uv(6+j,1)+dt*Uv1(6+j,1)+(dt^2)/6*(NR(6+j,1)+2*Uv2(6+j,1))-(Vxi(j,1)+N(j))))^(1/2)+Ch*dt/2;
        else
            r(j,1)=0;
        end
    end
    RE = diag(-r);

    %4 - calcolo il jacobiano
    J = Av;
    J(7:10,7:10)=J(7:10,7:10)+RE;
  

    %5 - scrivo il vettore F

    %Rst(1 to 10) è il vettore delle reazioni substruttura/treno calcolate
    %con hertz
    Rst = zeros(10,1);
    
    %ricalcolo il vettore spost. veicolo per hertz
    Uv_i = Uv + dt*Uv1+((dt^2)/6)*(NR+2*Uv2);
    
    for j=(1:4)
        [Rst(6+j), D(j)] = hertz(dt, Uv_i(6+j,1), Kh, Vxi(j,1), N(j), D0(j), Ch);
    end
    
    F = Av*NR - Rst + bv; % il segno delle reazioni è positivo perchè intrinsecamente è calcolato positivo verso l'alto
 

    %6 - calcolo il vettore termine noto b del sistema tipo Ax=b per fare un
    %call di solveLDL

    b = J*NR-F;

    %7 - risolvo il sistema
    deltaNR = NR; % salvo un attimo l'NR dell'iterazione precedente

    %risolvo con fattorizzazione LDLt
    % NR=solveLDLT(J,b);

%     risolvo con fattorizzazione LU
    [L_v,U_v]=lu(J);
    y=L_v\b;
    NR=U_v\y;

% %     risolvo con fattorizzazione di Chloesky
%     L_v = chol(J);
%     y = L_v'\b;
%     NR = L_v\y;


    %8 - check sulla convergenza
    deltaNR = NR - deltaNR;

    norm1 = norm(deltaNR);
    norm2 = norm(NR);
    normRAPP = norm(deltaNR)/norm(NR);

    if norm(deltaNR)/norm(NR) <= err 
       check = 1;
    else
       check = 0;
    end

    % if Uv(6+j,1)+dt*Uv1(6+j,1)+(dt^2)/6*(NR(6+j,1)+2*Uv2(6+j,1))-(Us(6+j,1)+N(j))<0
    %     check = 0;
    % end

    %metto un limite alle iterazioni di N-R
    k = k +1;
    % disp(k)
    if k == 10000    
        disp('NR_BREAK - over 10000 iterations at this time step, CHECK IT!!');
        break
    end
    if getappdata(wait,'canceling')
        break
    end


end %fine iterazione


%risultati dell'i-esima iterazione di punto fisso
Uv_i = Uv + dt*Uv1+((dt^2)/6)*(NR+2*Uv2);
Uv1_i = Uv1 + dt*Uv1 + (dt/2)*(NR+Uv2);
Uv2_i = NR;


Uvkk(:,i) = Uv;