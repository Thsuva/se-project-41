# se-project-41 TestFunzionale

nella cartella vengono presentati gli scripit usati per il testing funzionale di tipo BVA sull'unico input fornito dall'utente i file formato xlxs presentano ogniuno una tipologia di errore diversa

i test vengono svolti da un sistema di capture and replay che testa sull'interfaccia l'handling degli errori e il corretto funzionamento 
per eseguire il test basta aprire test runner, cambiare il path con quello della macchina che si sta usando (line 10) e runnare lo script

la suite proveder� a generare in automatico un report in pdf per il test eseguito ed ad aprire una pagina html per la coverage del test

ATTENZIONE il risultato presente del pdf Profiler Coverage Report � mutabile quello salvato � quello del caso ottimo ovvero quando tra le feature importanti per l'utente rimane una feature a 3 risposte
purtroppo non si � riuscito a controllare il seed per ottenere sempre questo tipo di risultato, in altri casi i valori ottenuti saranno minori a causa di alcuni if

MANCANZE:

il risultato totale 93.7%  dovuto al fatto che alcuni controlli sono stati generati per sicurezza ma per come � costruito il codice � impossibile accedere a quei branch

in StartButtonPushed il risultato 97.8 � dovuto ad un else in cui il programma non puo andare legato ai due bottoni iniziali ad esclusione reciproca per la scelta del dataset
nel caso venisse scelto un altro valore esterno ai due programmati il programma darebbe vita ad un errore inaspettato (CODE -1)

	
in BOHButtonPushed il risutlato 50%� dovuto al fatto che l'unica domanda a 3 risposte è l'ultima e quindi non viene ricercata una domanda seguentemente, le domande sono statiche all'interno del sistema e funzionano solo per il dataset predefinito

in FeatureSelButtonPushed il risultato 91.0% � dovuto alla scelta di non mostrare le domande in caso non si usi un dataset predefinito

in MyPrivacyPersona.MyPrivacyPersona non viene coperto uno statement if. il file è pero generato automaticamente da appdesigner e non ho trovato un modo di forzare nargout = 0

in computeCentroidMatrix il risultato 90.5% � dovuto a un controllo pensato per sistemi con N grande di cluster vincitori rispetto al numero dei campioni in questo caso roofcluster = 15 impedisce alla base questa eventualit� pertanto non si presenteranno mai cluster vuoti 

in saveWinnerCluster il risultato 61.5% � dovuto al fatto che non si � potuto cancellare la scelta di salvare il file coperta dalle rimanenti linee di codice




