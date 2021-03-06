Rstatic = (sum(Fv)/4);
t = ((i-stepsPRELOAD+1)*dt)/(ss-SstepsPRELOAD);
clear RdynMED10
clear Rdyn
clear Ddyn
tao = 2.3/V;
discr = floor((gg-SstepsPRELOAD)/(tao/t));
for ii = 1:1
    for j =1:discr
        RdynMED10(j,1) = max(Rstk(6+ii,floor(SstepsPRELOAD + (j-1)*(ss-SstepsPRELOAD)/discr):floor(SstepsPRELOAD + j*(ss-SstepsPRELOAD)/discr-1)));
%         Rdyn(i) = max(Rstk(6+i,(ss-SstepsPRELOAD)-500:(ss-SstepsPRELOAD)+500));
    end
    Rdyn(ii) = sum(RdynMED10)/discr;
    Ddyn(ii,1) = Rdyn(ii)/Rstatic;
end

% plotta forz di contatto in funzione dell'ascissa
% SstepsPRELOAD = 1;

% Rstk_plot = Rstk(9,SstepsPRELOAD:gg-1);
% t = ((i-stepsPRELOAD+1)*dt)/(ss-SstepsPRELOAD);
% 
% % figure
% plot([1:gg-SstepsPRELOAD]*t*V,Rstk_plot)
% axis([0,(gg-SstepsPRELOAD)*t*V,0,200000])


%IN FUNZIONE DEL TEMPO ANZICCH� DELLO SPAZIO
Rstk_plot = Rstk(7,SstepsPRELOAD:gg-1);
t = ((i-stepsPRELOAD+1)*dt)/(ss-SstepsPRELOAD);

figure
plot([1:gg-SstepsPRELOAD]*t,Rstk_plot)
axis([0,(gg-SstepsPRELOAD)*t,0,200000])


 hold on
 pl = plot([1:gg-SstepsPRELOAD]*t,Rstatic(1));
 set(pl,'Color','red','LineWidth',1)
 
 
 for ii = 1:discr
     pl2 = plot([(ii-1)*(gg-SstepsPRELOAD)/discr+1:ii*(gg-SstepsPRELOAD)/discr]*t,RdynMED10(ii))
     set(pl2,'Color','green','LineWidth',1)
 end
 pl3 = plot([1:gg-SstepsPRELOAD]*t,Rdyn(1))
 set(pl3,'Color','magenta','LineWidth',1)
 hold off