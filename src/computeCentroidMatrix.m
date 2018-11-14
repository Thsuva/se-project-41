function matriceCentroidi = computeCentroidMatrix(~,numFeature,clusterNumber,classesTrain,x)
%COMPUTECENTROIDMATRIX si occupa di generare la matrice dei centroidi per la rete neurale che ha prodotto le label in ClassesTrain
%   MATRICECNTROIDI = COMPUTECENTROIDMATRIX(APP,NUMFEATURE,CLUSTERNUMBER,CLASSESTRAIN,X)
%   la funzione genera una matrice MATRICECENTROIDI contenente i centroidi dei cluster
%   per un modello di rete neurale usando i campioni al'interno dei vari
%   neuroni.
%   Il valore per una feature è calcolato in base al valore piu frequente
%   nel cluster per quella specifica feature.
%   Nel caso in cui si presenti un cluster vuoto il suo centroide sarà
%   composto da -1 essendo impossibile da calcolare,
%   il caso del cluster vuoto è un caso limite e non dovrebbe mai comparire 
%   dato l'uso fatto della SOM.
%   Input Argument:
%       APP     appdesigner app a cui la funzione fa riferimento,
%               l'imput è necesario per utilizzare la funzione all'interno
%               del tool ma non essendo la funzione vincolata ad alcun
%               elemento viene sostituito con '~'
%       NUMFEATURE
%               intero che rappresenta il numero delle feature estratte dal
%               dataset
%       CLUSTERNUMBER
%               intero che rappresenta il numero di cluster e quindi il
%               numero di centroidi che sarà necessarop trovare (uno per cluster)
%       CLASSESTRAIN
%               label generate dalla rete neurale per il dataset preso in
%               considerazione 
%       X
%               matrice contenente il dataset trasposto. Le colonne di x
%               conterranno i campioni e le righe conterranno le feature
    matriceCentroidi = zeros(numFeature,clusterNumber);

    for i=1:clusterNumber
        supportingArray = zeros(11,numFeature);
        temp = -1; %variabile per risolvere i cluster vuoti
        for k=1:length(classesTrain)
            if classesTrain(k)==i
                for j=1:numFeature
                    temp = x(j,k); %controllo il valore dataset in k per ogniuna delle j feature
                    supportingArray(temp+1,j) = supportingArray(temp+1,j)+1; %aumento la colonna della matrice corrispondente al risultato
                end
            end
        end

        if temp == -1 %se temp è -1 il cluster è vuoto e non è possibile computare un centroide
            errorVector = zeros(numFeature,1)-1;
            matriceCentroidi(:,i) = errorVector;
        else%calcolo il vettore dei centroidi scegliendo il risultato piu comune per ogni feature
            [~,centroideCluster] = max(supportingArray);
            matriceCentroidi(:,i) = (centroideCluster-1)';
        end
    end
end