# se-project-41

ATTENZIONE alle 13.50 del 19/07/2018 è stata caricata una versione migliorata del file myPrivacyPersona.mlapp tutti i documenti sono pero ancora basati sulla vecchia applicazione nello specifico vengono cambiate:

-interfaccia iniziale che permette di scegliere il dataset da ovunque
-metodo di crossvalidation del dataset pre NN
-metodo di handling degli errori
-modo di mostrare risultati della feature selection
-possibilità di salvare i risultati ovunque

nei prossimi giorni verranno prodotti nuovi documenti per gli errori e modificato il drs per rispecchiare il nuovo funzionamento


andare su https://it.mathworks.com/downloads/ 
accedere con le proprie credenziali matricola@studenti.unige.it
download matlab per linux
creare una cartella "matlab" sul desktop

salvare il contenuto estratto dall'archivio nella cartella "matlab"
accedere al terminale 
digitare ./install dopo essere entrati da terminale nella cartella
inserire la psw del sudo (spring)

procedere con l'installazione sinche non si arriva a una scelta multipla ignorando se compare l'avviso sullo spazio disponibile

selezionare SOLO:
	Matlab 9.4
	MATLAB Compiler 6.6
	NeuralNetwork Toolbox 11.1
	Statistic and Machine Learning toolbox 11.3


https://it.mathworks.com/matlabcentral/answers/93739-how-do-i-launch-matlab-on-linux (guida per lanciare matlab da linux)


cd /usr/local/MATLAB/R2018a/bin
infine digitare
./matlab

bisogna accedere alla cartella di lavoro in /home/spring/Desktop/se-project-41/src

digitare app designer nella bash di matlab e aprire il progetto myPrivacyPersona.mlapp

ATTENZIONE: non è possibile utilizzare il tool su linux a causa dei bug sotto riportati

Istruzioni Per Windows:

per poter accedere al codice sorgente da matlab sono essenziali le stesse estensioni descritte in linux e matlab 2018a

una volta installato digitare app designer nella bash di matlab e aprire il progetto myPrivacyPersona.mlapp

se si desidera installare il tool nella cartella src/installer sono disponibili l'installer .exe per windows che richiederà una installazione di un applicativo matlab per poter usufruire delle librerie
ma il tutto dovrebbe avvenire in maniera automatica durante il processo di installazione

altrimenti è possibile installare il tool come matlab app nel caso si disponga di matlab sul computer (saranno necessarie le sopracitate librerie)

Known Bug and issue:

il tool se installato non mostra il messaggio di attesa all'utente, il funzionamento non ne viene compromesso. Il problema non si presenta nel caso si stia eseguendo il tool da progetto
a meno che non si inserisca nel codice la riga "net.trainParam.showWindow = 'false';" attualmente commentata a riga 456 tale codice che dovrebbe solamente inibire la visualizzazione della toolbox di training della rete neurale ha anche effetto su tutte le modifiche alla gui contenute nella funzione che non si verificano (come l'impossibilità di ripremere il pulsante start durante il processo o la stringa che comunica il tempo rimanente al termine dell'operazione)

nel caso in cui si voglia inserire un dataset proprio con il tool stand alone il file in questione deve trovarsi sul desktop
il file di risultato myPermission viene altresi generato sul desktop

nel caso si usi la matlab app il file del dataset deve trovarsi nella cartella attiva di matlab, l'output myPermission verra generato in quest'ultima


	


	
