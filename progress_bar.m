%stato della progress bar
waitbar(i/steps)  
% %possibilit� di interrompere dalla progress bar
 if getappdata(wait,'canceling')
        break
 end