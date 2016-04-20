figure

for i = 1:10:size(US2,1)
    plot(US2(i,1:size(US2,2)),'DisplayName','US2(16,1:2079)','YDataSource','US2(16,1:2079)');figure(gcf)
end

% plot(US2(578,1:size(US2,2)),'DisplayName','US2(16,1:2079)','YDataSource','US2(16,1:2079)');figure(gcf)
% axis([0,size(US2,2),-150,150])