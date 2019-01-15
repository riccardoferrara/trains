Una precisazione sui parametri da cambiare:
Lenght of simulazion: di default è 50m, può portarlo fino a 20m per fare simulazioni più veloci, ma non al di sotto, perchè considerato che il treno è lungo circa 15m in realtà percorrerà soltanto 5m.

n° of beam's element between sleepers: di default è messo 8, ed è il minimo per avere una simulazione corretta. In pratica è il numero di elementi beam (FEM) tra due traverse. mettendo 8, ogni beam è circa 7cm. Aumentando tale valore, si aumenta la precisione della simulazione ma al contempo, anche il tempo necessario.

parametres of rail's defect: qui è dove sto lavorando proprio oggi. Di default c'è messa un'usura ondulatoria corta (30mm di lunghezza d'onda) con ampiezza 0.03mm. é meglio non cambiare questi parametri al momento per vari motivi: uno è che sto cambiando la funzione che descrive la deformazione della rotaia per inserire dei difetti un pò piu stocastici e meno deterministici, un'altra è che aumentando troppo i difetti, il periodo transitorio iniziale aumenta notevolmente poiché la ruota fa dei piccoli salti che solo a regime dopo parecchi metri, scompaiono. L'ultimo motivo è che, il fatto che tali difetti siano implementati in modo deterministico, creano una sorta di risonanza nella rotaia che in alcuni casi non riesce ad essere smorzata (proprio per questo sto cambiando l'implementazione).

n° of steps in short's defects: questo parametro rappresenta la precisione della simulazione. é esattamente il numero di volte nel quale si vuole discretizzare la lunghezza d'onda dell'usura ondulatoria più corta. Di default è 20, ed è anche il minimo per ottenere la giusta approssimazione con i parametri inseriti. Se i risultati, cambiando i parametri, non convergono, occorre aumentare questo valore (aumenterà anche il tempo di simulazione). Il parametro è direttamente legato alla durata dell i-esimo step temporale. Cambiando questo parametro, o la velocità, cambia automaticamente la durata dello step temporale i-esimo.

I valori di K (a destra nell'interfaccia) corrispondono a:
Kp - rigidezza dell'attacco
Kb - rigidezza ballast
Kf - rigidezza sottofondo
Kw - rigidezza d'interazione orizzontale tra gli elementi di ballast

Model's options: sono delle opzioni che c'erano prima, non ho avuto il tempo di levare. La simulazione funziona solo con il 1° metodo (Raphson); l'altro l ho utilizzato in passato per verificare con due metodi diversi di integrazione e di risoluzione; al momento non è stato aggiornato e non si interfaccia più con il file pilota. Non ho avuto il tempo di levarlo.

Simulation's options: qui c'è la possibilità di lanciare la simulazione con due opzioni:
ONLY VEHICLE MODEL: con questa opzione la simulazione viene lanciata bloccando la substruttura. L'unico particolare è che anche la rotaia viene considerata infinitamente rigida, e quindi inserendo dei difetti, la reazione della rotaia risulta troppo alta. Quest'opzione mi serviva per calcolare l'abbassamento naturale della cassa e dei carrelli soggetti alla sola forza di gravità, in maniera da considerarli poi come condizioni iniziali per le seguenti simulazioni e velocizzare il transitorio.
NO RAIL'S DEFECTS: la simulazione viene lanciata considerando la rotaia senza difetti.
rail's defect afetr "0" metres: qui può decidere di far partire i difetti dopo tot metri per vedere la differenza del prima e del dopo, comparati negli stessi grafici.
n° saving steps: sebbene alcune simulazioni possano contenere migliaia di step temporali, la memoria di MATLAB è limitata, quindi è consigliabile non aumentare questo parametro più di 5000, altrimenti potrebbe dare errore. Di deault è 1000, già comunque si ottiene un ottima approssimazione. In pratica, la simulazione contiene effettivamente più steps temporali (in dipendenza del valore di "n° of steps in short's defects) ma ne verrano salvati e visualizzati 1000 (o il numero scelto).

Se ancora, vuole più risultati di quelli standard visualizzati in automatico dall'applicazione, lanciando la simulazione da matlab, deve eseguire il file pilota che si chiama userform1.m. alla fine della simulazione facendo un "load" (tasto destro del mouse e poi load) sul file matlab.mat può analizzare le variabili che più le interessano.
Le variabili più "interessanti" sono le seguenti. 
(tasto destro e poi plot su una riga o una colonna per visualizzare il grafico)
Uvk ogni riga rappresenta in ordine:
spostamento verticale della cassa del veicolo (in m) in fuzione del tempo
rotazioni della cassa (in rad)
spostamento verticale del carrello posteriore (m)
rotazioni carrello posteriore
spostamento verticale carrello anteriore
rotazioni carrello anteriore
spostamento verticale quarta ruota (la posteriore)
spostamento verticale terza ruota
spostamento verticale seconda ruota
spostamento verticale prima ruota
Uv1k anche queste sono 10 righe ma corrispondono alle velocità, ed alle velocità angolari
Uv2k lo stesso ma con le accelerazioni
US ogni colonna rappresenta lo spostamento verticale di tutti i nodi della rotaia
US2 ogni colonna rappresenta le accelerazioni verticali di tutti i nodi della rotaia
Usk ogni riga rappresenta il valore per ogni step temporale del grado di libertà associato alla substruttura. In riferimento alle variabili s, ed n che trova come output tra le variabili della simulazione, le prime "s" righe sono i gdl della rotaia, le seguenti "n" righe rappresentano le traverse, le ultime "n" rappresentano gli elementi di ballast (le righe sono in totale s+2n)
Us1k lo stesso ma con le velocità
Us2k lo stesso ma con le accelerazioni
Rstk le ultime 4 righe sono le forze di contatto ruota-rotaia espresse in Newton (in funzione degli step temporali)

Inoltre c'è uno script "analisi_modale.m" che serve per creare una "power spectral density" della funzione analizzata, ma ogni volta bisogna entrare nello script per cambiare la variabile in esame. Tutti gli altri script vengono richiamati dal "pilota" per funzionare.
Buon divertimento!
