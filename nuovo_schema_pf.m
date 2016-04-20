%calcolo le forze da inserire nel modello sovrastruttura all'istante
%i-esimo

check_pf = 0;
puntofisso = 0;

while(check_pf == 0)
     posizione_ruote
    
     if getappdata(wait,'canceling')
        break
     end
     
     deformata
     
     %ricalcolo il vettore abbassamento ruote per hertz
%      [Vxi,Vxik] = abbassamento_ruote(i, posizione, steps, dt, Us_i, V, TOTbeams, stepsPRELOAD, gg, Vxik, x, INTbeams, Xtot, interasse, Lsimulazione, l, lp, Xinterp, campo); 
     [Vxi,Vxik] = abbassamento_ruote(i, posizione, Us_i, gg, Vxik, X, lp, campo, l, Nf);

     
     for j=(1:4)
        [Rst(6+j), D(j)] = hertz(dt, Uv_i(6+j,1), Kh, Vxi(j,1), N(j), D0(j), Ch);
     end
                                                         %Rst    i
        
     calcolo_Fs_con_taglio                               %Fs     i

     newmark                                             %Us_i   i



    %check_convergenza punto fisso
%     if puntofisso ~= 0;
        if norm(Us_i-Us_pf)/norm(Us_i) < err
            
            aggiorno_Us_Uv
            
            output_sovrastruttura
            
            output_veicolo
            
            i = i+1;
            disp(i)
            
            posizione_ruote                                     %xi    i+1
            
            %         [Vxi,Vxik] = abbassamento_ruote(i, posizione, steps, dt, Us_i, V, TOTbeams, stepsPRELOAD, gg, Vxik, x, INTbeams, Xtot, interasse, Lsimulazione, l, lp, Xinterp, campo);
            [Vxi,Vxik] = abbassamento_ruote(i, posizione, Us_i, gg, Vxik, X, lp, campo, l, Nf);
            
            
            %Vxi    i+1
            
            
            deformata
            %         N = N + deformata_ruota(x, diametro_ruota, V, gg);          %Ni     i+1
            
            
            progress_bar
            
            %         save matlab.mat
%             if i ==3
%                 clear Rtrasp_INIT
%                 clear R_INIT
%             end
            break
        end
%     end
    
    
    %calcolo il valore di Us dell i-esima iterazione di punto fisso
    Us_pf = Us_i;
    
%     [Vxi,Vxik] = abbassamento_ruote(i, posizione, steps, dt, Us_pf, V, TOTbeams, stepsPRELOAD, gg, Vxik, x, INTbeams, Xtot, interasse, Lsimulazione, l, lp, Xinterp);
    [Vxi,Vxik] = abbassamento_ruote(i, posizione, Us_i, gg, Vxik, X, lp, campo, l, Nf);

                                                            %Vxi   i+1
    
    modello_veicolo
    
    puntofisso = puntofisso + 1;
    if puntofisso == 1000    
        disp('PF_BREAK - over 1000 iterations at this time step, CHECK IT!!');
        break
    end
    disp(['PF ', num2str(puntofisso)])
    if getappdata(wait,'canceling')
        break
    end
    
end

%     hold on
    j = 1;
    kk = 1;
    Us_i_plot = [Us_i(1,1);[0];Us_i(2:s-2);[0]];
    while kk<=s/2
        US(kk) = Us_i_plot(j,1);
        j = j+2;
        kk = kk+1;
    end
%     plot(Uk(1,1),i)
 plot(Xtot,US(:));

% hold on
% plot(i,Rstk(7,i-1));
