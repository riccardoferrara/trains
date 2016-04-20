%calcolo un vettore che associa ad ogni istante temporale il valore della
%difettosità della rotaia

%fisso il seme random per comparare le simulazioni
% randn('state',0)
% rand('state',0)

%scelgo il numero di wavelenghts per ogni banda
M = 50;

%definisco il vettore delle fasi random
fk = rand(N_difetti,M)*2*pi;
% fk =zeros(N_difetti,1);

% %lunghezze deterministiche
% wk = zeros(N_difetti,1);
% for kk = 1:N_difetti
%     wk(kk,1) = wl+(kk-1)*dw;
% end
% 
% %lunghezze random
% lambdak = zeros(N_difetti,1);
% lambdak = (Lupper-Llower)*rand(1,N_difetti)' + Llower;
% 
% %lunghezze deterministiche
% dl = (Lupper - Llower)/(N_difetti);
% for kk = 1:N_difetti
%     lambdak(kk,1) = Llower + dl/2 + (kk-1)*dl;
% end

wupper = 2*pi*V/Llower;
wlower = 2*pi*V/Lupper;

%ampiezze deterministiche 
dw = (wupper-wlower)/N_difetti;
for kk = 1:N_difetti
    wk(kk,1) = wlower + dw/2 + (kk-1)*dw;
    lambdak(kk,1) = 2*pi*V/wk(kk,1);
end


% DIFETTI SVIZZERA x2000
%
% -----------------------------------------------------------------------
% load polinomio_interp_x2.mat
% for kk = 1:N_difetti
% %     lambda = (2*pi*V/wk(N_difetti-kk+1,1));
% %     devk(kk,1) = polyval(p,(2*pi*V/wk(N_difetti-kk+1,1)));
%     devk(kk,1) = polyval(p,(2*pi*V/wk(kk,1)));
% end
% 
% ak = 0.5*diag(devk)*randn(N_difetti,1);
% % ak = 0.1*devk*randn(N_difetti,1);
% % ak = diag(devk)*ones(N_difetti,1);
% -----------------------------------------------------------------------


% % DIFETTI ISO3095
% %
% % -----------------------------------------------------------------------
for kk = 1:N_difetti
    %passo il lambda in mm
    lambda = lambdak(kk,1)*1000;
    if lambda < 10
        lambda = 10;
    end
 
    % applico la iso per trovare il livello di db
    devk = 27.176 - 18.419*log10(1000/lambda); %dB ref mum
    %trovo l'ampiezza a partire dai decibel
    ak(kk,1) = (2/M)^0.5*10^-6*(10^(devk/20)); %m
    ak(kk,1) = 1*(2/N_difetti)^0.5*10^-6*(10^(devk/20)); %m
end

% % -----------------------------------------------------------------------

% %scelgo l'intervallo di ogni banda espresso in m
% int = 0.1;
% int = dl;

for ii = 1:4
    for k = 1:(steps-stepsPRELOAD)+1;
        %inizializzazione variabile
        NN(k,ii) = 0;
        for i = 1:N_difetti
%             dk = 2*pi/M*( 1/(-int/2) - 1/(+int/2) );
            NN(k,ii) = NN(k,ii) + ak(i,1)*sin( (2*pi/(lambdak(i,1)))*(V*k*dt+distanze_ruote(ii,1)) + fk(i,1));
%             for j = 1:M
%                 NN(k,ii) = NN(k,ii) + ak(i,1)*sin( (2*pi/(lambdak(i,1)-int/2) + dk*(j-1))*(V*k*dt+distanze_ruote(ii,1)) + fk(i,j));
%             end
        end
        disp(k)
    end
end