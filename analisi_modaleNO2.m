%fft lavora in modo più preciso con campionamenti digitalizzati a potenze
%di 2 quindi calcolo la potenza di due compresa nei nostri dati (minore di
%ss)
% partenza = stepsPRELOAD;
% partenza = 1500;
partenza = 0;
% ss2 = 2^(nextpow2(ss-ss/i*stepsPRELOAD-partenza)-1);
ss2 = ss-ss/i*stepsPRELOAD-partenza;


% OUTPUT = US(floor(s/4),400:ss2);
% OUTPUT = US(220,1:ss2);
% OUTPUT = US2(522,100:99+ss2);
% OUTPUT = US2rid(1,100:99+ss2);
% OUTPUT = Uvk(7,1:ss2);
% OUTPUT = Rstk(9,ss/i*stepsPRELOAD+partenza+1:partenza+ss/i*stepsPRELOAD+ss2);
% OUTPUT = Vxik(2,stepsPRELOAD+20:19+stepsPRELOAD+ss2);
% OUTPUT = US2(115,1:ss2);
% OUTPUT = Uv2k(7,1:ss2);
% OUTPUT = funz(1,1:ss2);
% OUUTPUT = Rstk(9,1000:ss-1)

digitalizzazione = size(OUTPUT,2);

MEDIA = sum(OUTPUT)/digitalizzazione;
OUTPUT = OUTPUT - MEDIA*ones(1,digitalizzazione);


% OUTPUT = US(50,1:2046);
% OUTPUT = Uvk(7,1:2035);

%filtro lo spettro tagliando con un filtro passa basso che lascia passare
%solo le frequenze più basse di 1/2 della frequenza di campionamento
%(rispettando il teorema di Shannon

% b = fir1(3,0.5);
% OUTPUT = filter(b,1,OUTPUT);


% t può nn coincidere con dt se salvo meno dati di quelli della
% simulazione, di seguito calcolo l'intervallo di tempo tra un salvataggio
% e l'altro


% t = (Lsimulazione-distanze_ruote(4)-0.5)/V/(ss-stepsPRELOAD);
if i<ss
    disp('ERRORE i<ss')
    i = ss;
end
t = ((i-stepsPRELOAD+1)*dt)/(ss-ss/i*stepsPRELOAD);
% t = dt;



%la frequenza di campionamento é 
Frequenza = 1/(t);

% freq =   [0 33 34  40 41 Frequenza/2 ]/(Frequenza/2);
% valori = [1 1  0   0  1  1];

% stop_filter = fir2(30, freq, valori);
% stop_filter = firls(500, freq, valori);
% stop_filter = fir1(1500, 40/(Frequenza/2), 'high');
% stop_filter = filtro(Frequenza);


% figure
% [h,w] = freqz(stop_filter,1,128);
% plot(freq,valori,w/pi,abs(h))
% legend('Ideal','fir2 Designed')
% title('Comparison of Frequency Response Magnitudes')

% plot(OUTPUT);
% OUTPUT = filter(stop_filter', 1, OUTPUT);
% figure
% plot(OUTPUT);

%progetto un passa alto per tagliare tutte le componenti a frequenza
%superiore alla frequenza di Nyquist (Fn = Fcampionamento/2)
passa_basso = fir1(12,0.5);
OUTPUT = filter(passa_basso, 1, OUTPUT);

NFFT = (digitalizzazione); % Next power of 2 from length of y
Y = fft(OUTPUT,NFFT)/digitalizzazione;
f = Frequenza/2*linspace(0,1,NFFT/2+1);


% Plot single-sided amplitude spectrum.
figure 

plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
axis([0,2000,0,5000])

nfft = 2^nextpow2(length(OUTPUT));
Pxx = abs(fft(OUTPUT,nfft)).^2/length(OUTPUT)/t;
figure
Hpsd = dspdata.psd(Pxx(1:length(Pxx)/2),'Fs',t);
% Hpsd = normalizefreq(Hpsd);
plot(Hpsd); 

