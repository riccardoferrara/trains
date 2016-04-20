%stato della progress bar
waitbar(i/steps)  
% %possibilità di interrompere dalla progress bar
 if getappdata(wait,'canceling')
        break
 end