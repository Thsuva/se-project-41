function elbowFlag =  elbowMethod(~,clusterNumber,errors,flag)
%ELBOWMETHOD controla che le prestazioni abbiano un miglioramento del 20%
%   ELBOWFLAG =  ELBOWMETHOD(APP,CLUSTERNUMBER,ERRORS,FLAG) la funzione controlla
%   che le prestazioni migliorino abbastanza ad ogni iterazione. Il trashold scelto per il
%   progetto è 20%.
%   In caso contrario ELBOWFLAG passa a false e non puo piu essere
%   modificata.
%   Il controllo puo essere fatto solo dalla quarto giro in poi in quanto necessita
%   il valore contenuto in ERRORS per due iterazioni precedenti
%   Input Argument:
%       APP     appdesigner app a cui la funzione fa riferimento,
%               l'imput è necesario per utilizzare la funzione all'interno
%               del tool ma non essendo la funzione vincolata ad alcun
%               elemento viene sostituito con '~'
%       CLUSTERNUMBER
%               intero che rappresenta il numero di cluster per la rete attuale 
%       ERRORS
%               vettore contenete gli errori calcolati sin ora per le reti
%               costruite 
%       FLAG
%               il booleano flag, una volta modificato dalla funzione
%               impedisce ulteriori aggiornamenti della best net
    migliramentoMinimo = 20/100;
    elbowFlag=flag;
    if clusterNumber > 3
        if errors(clusterNumber-1)-errors(clusterNumber) < (errors(clusterNumber-2)-errors(clusterNumber-1))*migliramentoMinimo
            elbowFlag = false;
        end
    end
end