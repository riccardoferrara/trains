%lancio una waitbar
wait = waitbar(0,'computing...','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(wait,'canceling',0)