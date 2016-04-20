%scrivo gli output solo per gli step da salvare
if mod(i,floor(steps/Nsaving_steps))==0
    Nk(:,ss) = N(:,1);
    Rstk(:,ss) = Rst;
    Uvk(:,ss) = Uv;
    Uv1k(:,ss) = Uv1;
    Uv2k(:,ss) = Uv2;
    ss = ss+1;
end
if i == stepsPRELOAD
    SstepsPRELOAD = ss;
end