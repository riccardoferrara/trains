%close all

%indicare il punto studio in m
punto_studio = 31;

%calcolo una traversa dove passano entrambe le ruote - a punto_studio m dall'inizio
%simulazione
td = floor(punto_studio/interasse);

%calcolo un gdl della rotaia dove passano entrambe le ruote - a punto_studio m dall'inizio
%simulazione 
%ATTENZIONE!!!!
%solo se l = lp
rd = floor(punto_studio/interasse)*interasse/l*2-1;

%calcolo il carico statico
static = (sum(Fv)/4)*ones(ss,2);

% figure
%     mesh(US)
%     xlabel('timesteps')
%     ylabel('railway')
%     title('railway displacement [m]')

figure
    plot(Usk(floor(rd),:))
    xlabel('timesteps')
    title(['railway-displacement [m/s] at ',num2str(floor(punto_studio/interasse)*interasse),' m'])
%     axis([0,ss,-0.00175,0])
    
figure
    subplot(2,1,1)
    plot(Rstk(7,:))
    xlabel('timesteps')
    title('contact-force [N]')
    axis([0,ss,0,300000])
    hold on
    pl = plot(static);
    set(pl,'Color','red','LineWidth',1)
    hold off

    subplot(2,1,2)
    plot(Uvk(7,:))
    xlabel('timesteps')
    title('Wheel-displacement [m]')

figure
    subplot(3,1,1)
    plot(Us2k(floor(rd),:))
    xlabel('timesteps')
    title(['railway-acceleration [m/s^2] at ',num2str(floor(punto_studio/interasse)*interasse),' m'])
%     axis([0,ss,-150,150])

    subplot(3,1,2)
    plot(Us2k(s+td,:))
    xlabel('timesteps')
    title(['sleeper-acceleration [m/s^2] at ',num2str(floor(punto_studio/interasse)*interasse),' m'])
%     axis([0,ss,-70,70])

    subplot(3,1,3)
    plot(Us2k(s+n+td,:))
    xlabel('timesteps')
    title(['ballast-acceleration [m/s^2] at ',num2str(floor(punto_studio/interasse)*interasse),' m'])


% 
% 
% rd = floor(punto_studio/l)*l/l*2-1;
% 
% figure
%     subplot(3,1,1)
%     plot(Us2k(floor(rd),:))
%     xlabel('timesteps')
%     title(['railway-acceleration [m/s^2] at ',num2str(floor(punto_studio/l)*l),' m'])
%     axis([0,ss,-150,150])
% 
%     subplot(3,1,2)
%     plot(Us2k(s+td,:))
%     xlabel('timesteps')
%     title(['sleeper-acceleration [m/s^2] at ',num2str(floor(punto_studio/interasse)*interasse),' m'])
%     axis([0,ss,-70,70])
% 
%     subplot(3,1,3)
%     plot(Us2k(s+n+td,:))
%     xlabel('timesteps')
%     title(['ballast-acceleration [m/s^2] at ',num2str(floor(punto_studio/interasse)*interasse),' m'])
