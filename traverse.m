for tr = 1:ss
%     disp(V*(tr-stepsPRELOAD)*t+0.5)
    
    if tr>SstepsPRELOAD
        if mod(V*(tr-SstepsPRELOAD)*t,interasse) <0.01
            disp(V*(tr-SstepsPRELOAD)*t)
            pads(tr) = 10^5;
        end
    else
        pads(tr) = 0;
    end
end

% figure
plot(pads)
axis([0,ss,-1,10^5])