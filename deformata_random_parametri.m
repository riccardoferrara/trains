%calcolo un vettore che associa ad ogni istante temporale il valore della
%difettosità della rotaia

load coefficientsAvWc.mat

%fisso il seme random per comparare le simulazioni
randn('state',0)
rand('state',0)

%ricavo i coefficienti Av e Wc dalla tabella della America Railway Standard
Av = coefficientsAvWc(grado,1)/10000*V;%da cmqrad/m a mqrad/s
Wc = coefficientsAvWc(grado,2)*V;%da rad/m a rad/s

%definisco il vettore delle fasi random
fk = rand(N_difetti,1)*2*pi;
% fk =zeros(N_difetti,1);

%calcolo le pulsazioni limite associate alle lunghezze d'onda limite
wl = 2*pi*V/Lupper; %alla lunghezza d'onda più lunga è associata la pulsazione più piccola
wu = 2*pi*V/Llower;
dw = (wu-wl)/(N_difetti-1);

%definisco il vettore delle le pulsazioni
% wk = wl*ones(N_difetti,1) + dw*[1:N_difetti]';

% %pulsazioni deterministiche
% wk = zeros(N_difetti,1);
% for kk = 1:N_difetti
%     wk(kk,1) = wl+(kk-1)*dw;
% end

%pulsazioni random
wk = zeros(N_difetti,1);
wk = (wu-wl)*rand(1,N_difetti)' + wl;

%definisco il vettore delle deviazioni standard di devk (calcolato come quadrato della
%varianza)
devk = zeros(N_difetti,1);
for kk = 1:N_difetti
    devk(kk,1) = (4*S_linegrade(wk(kk,1),kk, Av, Wc)*dw)^0.5;
end

%definisco il vettore ak
ak = diag(devk)*randn(N_difetti,1);
% ak = diag(devk)*ones(N_difetti,1);


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
%     lambda = (2*pi*V/wk(N_difetti-kk+1,1))*1000; %mm
    lambda = (2*pi*V/wk(kk,1))*1000; %mm
    if lambda < 10
        lambda = 10;
    end
    % applico la iso per trovare il livello di db
    devk = 27.176 - 18.419*log10(1000/lambda); %dB ref mum
    %trovo l'ampiezza a partire dai decibel
    ak(kk) = (2/N_difetti)^0.5*10^-6*(10^(devk/20)); %mm
end
% ak = diag(ak)*randn(N_difetti,1);
ak = diag(ak)*ones(N_difetti,1);
% % -----------------------------------------------------------------------

