%stato della progress bar
waitbar(i/steps)  
% %possibilitÓ di interrompere dalla progress bar
 if getappdata(wait,'canceling')
        break
 end