US = zeros(s/2,gg-1);
US2 = zeros(s/2,gg-1);
k = 1;
j = 1;


%apro i file con i risultati
Usfile = fopen('Usfile.txt');
Us1file = fopen('Us1file.txt');
Us2file = fopen('Us2file.txt');

%dimensiono le variabili risultato
Usk = zeros(s+2*n-2,gg-1);
Us1k = zeros(s+2*n-2,gg-1);
Us2k = zeros(s+2*n-2,gg-1);

%scrivo su vettori
Usk = fscanf(Usfile,'%g %g',[s+2*n-2 inf]);
% Us1k = fscanf(Us1file,'%g %g',[s+2*n-2 inf]);
% Us2k = fscanf(Us2file,'%g %g',[s+2*n-2 inf]);
% 
% fclose(Usfile);
% fclose(Us1file);
% fclose(Us2file);
% 
Usk_plot = [Usk(1,:);zeros(1,gg-1);Usk(2:s-2,:);zeros(1,gg-1)];
% Us2k_plot = [Us2k(1,:);zeros(1,gg-1);Us2k(2:s-2,:);zeros(1,gg-1)];
% 
%  
for h = (1:gg-1)
    j = 1;
    k = 1;
    while j<=s
            US(k,h) = Usk_plot(j,h);
%             US2(k,h) = Us2k_plot(j,h);
            k = k+1;
            j = j+2;
    end
end