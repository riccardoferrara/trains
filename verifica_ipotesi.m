%studio sull'ipotesi comparazione tra la differenza degli spostamenti della
%ruota della rotaia e la deformazione:

%riscrivo la deformazione sugli ss
ii = 1;
% ss = 0;
% for ii =1:steps
%     
%     %scrivo gli output solo per gli step da salvare
%     if mod(ii,floor(steps/Nsaving_steps))==0
%         ss = ss+1;
%         Ntk(:,ss) = Nk(1,ii);
%     end
% end

%calcolo le differenze per ogni step
ii = 1;
for ii = 1:ss-2;
    diff_Uvk(ii,1) = Uvk(7,ii+1)-Uvk(7,ii);
    diff_Vxik(ii,1) = Vxik(1,ii+1)-Vxik(1,ii);
    diff_Nk(ii,1) = Nk(1,ii+1)-Nk(1,ii);
    diff_Uvk_Vxik(ii,1) = Uvk(7,ii)-Vxik(1,ii);
end

close all    
figure
subplot(3,2,1)
plot(diff_Uvk(2:ss-2,1))
xlabel('timesteps')
ylabel('vertical displacement [m]')
title('Wheel: Uw(i+1)-Uw(i)')
% axis([0,ss,-0.00005,0.00005]);

subplot(3,2,3)
plot(diff_Vxik(2:ss-2,1))
xlabel('timesteps')
ylabel('vertical displacement [m]')
title('Railway: Ur(i+1)-Ur(i)')
% axis([0,ss,-0.00005,0.00005]);

subplot(3,2,5)
plot(diff_Nk(2:ss-2,1))
xlabel('timesteps')
ylabel('vertical displacement [m]')
title('Corrugation: N(i+1)-N(i)')
% axis([0,ss,-0.00005,0.00005]);


subplot(3,2,2)
plot(Uvk(7,2:ss-2))
xlabel('timesteps')
ylabel('vertical displacement [m]')
title('Wheel: Uw(i)')
% axis([0,ss,-0.00005,0.00005]);

subplot(3,2,4)
plot(Vxik(1,2:ss-2))
xlabel('timesteps')
ylabel('vertical displacement [m]')
title('Railway: Ur(i)')
% axis([0,ss,-0.00005,0.00005]);

subplot(3,2,6)
plot(Nk(1,2:ss-2))
xlabel('timesteps')
ylabel('vertical displacement [m]')
title('Corrugation: N(i)')
% axis([0,ss,-0.00005,0.00005]);

figure
plot(diff_Uvk_Vxik)

figure
plot(Uvk(7,:))
hold
plot(Vxik(1,:))

