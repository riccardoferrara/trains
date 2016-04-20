%scrivo gli output solo per gli step da salvare
if mod(i,floor(steps/Nsaving_steps))==0
%     Usk(1:s+2*n-2,gg) = Us;
%     Us1k(1:s+2*n-2,gg) = Us1;
%     Us2k(1:s+2*n-2,gg) = Us2;
    gg = gg+1;
    
    fprintf(Usfile,'%18.16e\t',Us);
    fprintf(Usfile,'\n');
    
    fprintf(Us1file,'%18.16e\t',Us1);
    fprintf(Us1file,'\n');
    
    fprintf(Us2file,'%18.16e\t',Us2);
    fprintf(Us2file,'\n');
end