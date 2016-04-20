figure
for i = 1:floor((ss-1)/100):(ss-1)
   
    plot(US2(i,:));
    
    axis([0,ss-1,-300,300]);
    ylabel('acceleration [m/s2]')
    title('RAILWAY acceleration')
    xlabel(['time-steps = ', num2str(i)])
    
  
    
    pause(0.1);
    
end