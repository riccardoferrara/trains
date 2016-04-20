
%possibilità di lanciare una simulazione senza difetti alla rotaia
opzione2 = get(handles.no_difetti,'value');
if opzione2 == 1
    N = [0;0;0;0];
end


%se invece voglio lanciare la simulazione considerando i difetti
%posso decidere di farli partire da un'ascissa x, per eliminare gli effetti
%di transitorio.
if opzione2 == 0
    %costruisco il vettore N(1 to 4) le cui componenti rappresentano 
    %le deformazioni della rotaia date da usura in corrispondenza delle 
    %quattro ruote
     if i >stepsNODIFETTI
         
         %due tipi di deformazioni: una deterministica ed una pseudo_random
         if opzione_deterministica == 1
             N = deformata_det(x,Acorta,Am,Al,Lc,Lm,Ll);
         else
             N = deformata_pr_nielsen(x, i, NN, stepsPRELOAD);
             %N = -N;
         end
     else
         %N = [0;0;0;0];
         %faccio entrare progressivamente i difetti
         if opzione_deterministica == 1
             if max(max(Acorta,Am),Al) == 0, 
                 graduale = 1;
             else
                 graduale = 0.00001/max(max(Acorta,Am),Al)+(1-0.00001/max(max(Acorta,Am),Al))/(stepsNODIFETTI-1)*(i-1);
             end
             N = deformata_det(x,Acorta,Am,Al,Lc,Lm,Ll)*graduale;
         else
             graduale = 0.00001/max(ak)+(1-0.00001/max(ak))/(stepsNODIFETTI-1)*(i-1);
             N = deformata_pr_nielsen(x, i, NN, stepsPRELOAD)*graduale;
            %N = -N;
         end
     end
end

