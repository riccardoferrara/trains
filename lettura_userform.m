%carico parametri da userform

%parametri simulazione
V = str2double(get(handles.velocita,'String'))/3.6; %da km/h a m/s
d = str2double(get(handles.DiscretizzazioneCorta,'String'));
Lc = str2double(get(handles.Lcorta,'String'))/1000;
T_preload = str2double(get(handles.T_preload,'string'));

%carica parametri treno
treno = get(handles.treno,'value');
if treno == 1, load matrici_veicolo_ALn668, end
if treno == 2, load matrici_veicolo_TGV, end
if treno == 3, load matrici_veicolo_ETR500, end
if treno == 4, load matrici_veicolo_X-2000, end
if treno == 4, load matrici_veicolo_X-2000, end
if treno == 5, load matrici_veicolo_dong, end
if treno == 6, load matrici_veicolo_nelsen, end
if treno == 7, load matrici_veicolo_manchester_benchmark, end
if treno == 8, load matrici_veicolo_ALn668-2, end
if treno == 9, load matrici_veicolo_vehicle, end



%parametri alfa e delta per newmark
alfa = str2double(get(handles.alfaMIN,'string'));
delta = str2double(get(handles.delta,'string'));

%rilevo parametri difettosit� della rotaia
Acorta = str2double(get(handles.Acorta,'string'))/1000; %da mm a m
Am = str2double(get(handles.Amedia,'string'))/1000; %da mm a m
Al = str2double(get(handles.Alunga,'string'))/1000; %da mm a m
Lm = str2double(get(handles.Lmedia,'string'))/1000; %da mm a m
Ll = str2double(get(handles.Llunga,'string'))/1000; %da mm a m
Llower = str2double(get(handles.Llower,'string'))/1000; %da mm a m
Lupper = str2double(get(handles.Lupper,'string'))/1000; %da mm a m
N_difetti = str2double(get(handles.N_difetti,'string'));
grado = (get(handles.grado,'value'));
Lnodifetti = str2double(get(handles.Lnodifetti,'string')); %lunghezza tratto senza difetti rotaia

%rilevo parametri substruttura
mr = str2double(get(handles.mr,'string')); %massa rotaia kg/m
I = str2double(get(handles.I,'string')); %modulo d'inerzia della rotaia
S = str2double(get(handles.A,'string')); %Area della sezione lungitudinale della rotaia in m2
chi = str2double(get(handles.chi,'string')); %coefficiente a taglio di timoshenko
ms = str2double(get(handles.ms,'string')); %massa traversa
mb = str2double(get(handles.mb,'string')); %massa elemento di ballast
beams = str2double(get(handles.beams,'string')); %numero di elementi beam tra due traverse
Pbeams = str2double(get(handles.Pbeams,'string')); %numero elementi rotaia connessi a mezza piastra d'attacco
Kp = str2double(get(handles.Kp,'string')); %costante elast. molla rotaia/traversa
Kp = Kp/(2*Pbeams+1); %considerando pi� molle in parallelo
Kb = str2double(get(handles.Kb,'string'));%costante elsat. molla trav/ballast
Kf = str2double(get(handles.Kf,'string')); %costante elast. molla ballast/sottof
Kw = str2double(get(handles.Kw,'string')); %costante elats. molla ballast/ballast
Cp = str2double(get(handles.Cp,'string'));%costante di smorz rotaia/traversa
Cp = Cp/(2*Pbeams+1); %considerando pi� smorzatori in parallelo
Cb = str2double(get(handles.Cb,'string')); %costante di smorz trav/ballast
Cf = str2double(get(handles.Cf,'string')); %costante di smorz ballast/sottof
Cw = str2double(get(handles.Cw,'string')); %costante di smorz ballast/ballast
Pw = str2double(get(handles.Pw,'string'))/100; %larghezza traversa da cm a m


%rilevo lunghezza della simulazione
Lsimulazione = str2double(get(handles.Lunghezza,'string'));
interasse = str2double(get(handles.InterasseTraverse,'string'))/100; %da cm a m

%rilevo parametri errore per iterazioni NW-R
err = str2double(get(handles.errore,'string'));

%rilevo opzioni
opzione_deterministica = get(handles.opzione_deterministica,'value');
% opzione1 = get(handles.solo_modello_veicolo,'value');

%rilevo numero di steps da salvare
Nsaving_steps = str2double(get(handles.Nsaving_steps,'string'));

