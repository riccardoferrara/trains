load MATLAB.mat
USrotaia

Rstatic = (sum(Fv)/4);
t = ((i-stepsPRELOAD+1)*dt)/(ss-SstepsPRELOAD);
clear RdynMED10
clear Rdyn
clear Ddyn
% for ii = 1:4
%     for j =1:10
%         RdynMED10(j,1) = max(Rstk(6+ii,floor(SstepsPRELOAD + (j-1)*(ss-SstepsPRELOAD)/10):floor(SstepsPRELOAD + j*(ss-SstepsPRELOAD)/10-1)));
% %         Rdyn(i) = max(Rstk(6+i,(ss-SstepsPRELOAD)-500:(ss-SstepsPRELOAD)+500));
%     end
%     Rdyn(ii) = sum(RdynMED10)/10;
%     Ddyn(ii,1) = Rdyn(ii)/Rstatic;
% end

% USrotaia
Dsl = -min(Usk(floor(s+3/4*n),:));

tao = 2.3/V;
discr = floor((gg-SstepsPRELOAD)/(tao/t));
% discr = 10;
for ii = 1:4
    for j =1:discr
        RdynMED10(j,1) = max(Rstk(6+ii,floor(SstepsPRELOAD + (j-1)*(ss-SstepsPRELOAD)/discr):floor(SstepsPRELOAD + j*(ss-SstepsPRELOAD)/discr-1)));
%         Rdyn(i) = max(Rstk(6+i,(ss-SstepsPRELOAD)-500:(ss-SstepsPRELOAD)+500));
    end
    Rdyn(ii) = sum(RdynMED10)/discr;
    Ddyn(ii,1) = Rdyn(ii)/Rstatic;
end