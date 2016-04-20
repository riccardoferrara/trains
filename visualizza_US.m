
figure

Ui = 1;

%richiamo l'algo che costruisce il vettore dell X
vettX

%fisso i massimi e minimi per bloccare gli assi cartesiani
Yus_min = min(min(US(:,size(US,2)/2:size(US,2))));
Yus_max = max(max(US(:,size(US,2)/2:size(US,2))));
Xus_max = Xtot(size(Xtot,1));

Yus2_min = min(min(US2(:,size(US2,2)/2:size(US2,2))));
Yus2_max = max(max(US2(:,size(US2,2)/2:size(US2,2))));
Xus2_max = Xus_max;



for i = 1:floor((ss-1)/100):(ss-1)
    subplot(2,1,1);
    plot(Xtot,US(:,i));
    
    axis([0,Xus_max,Yus_min,Yus_max]);
    ylabel('displacement [m]')
    title('RAILWAY DISPLACEMENT')
    xlabel(['time-steps = ', num2str(i)])
    
%     subplot(2,1,2);
%     plot(Xtot,US2(:,i));
%     axis([0,Xus2_max,Yus2_min,Yus2_max]);
%     ylabel('acceleration [m/s^2]')
%     title('RAILWAY ACCELERATION')
%     xlabel(['time-steps = ', num2str(i)])
    
    pause(0.1);
    
end
   