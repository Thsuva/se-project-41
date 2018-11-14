function [trainSet, testSet] = splitCrossVal(~,fullDataset)
%SPLITCORSSVAL divide il dataset in trainSet e testSet basandosi su un valore di split
%   [TRAINSET, TESTSET] = SPLITCROSSVAL(APP,FULLDATASET) la funzione divide 
%   il dataset contenuto in FULLDATASET in TRAINSET e TESTSET basandosi su un valore di split
%   per il progetto è stato scelto un rapporto del 70%
%   Input Argument:
%       APP     appdesigner app a cui la funzione fa riferimento,
%               l'imput è necesario per utilizzare la funzione all'interno
%               del tool ma non essendo la funzione vincolata ad alcun
%               elemento viene sostituito con '~'
%       FULLDATASET
%               matrice contenente il dataset scelto per l'analisi
    backUpDataset = fullDataset;
    split = 70/100;
    [righe, colonne] = size(fullDataset);
    backUpRighe = righe;
    count=0;
    testSet = zeros(1,colonne);
    while backUpRighe-count > righe*split %finche lo split non viene superato sposto campioni nel test
        rndRaw = randi([1 (backUpRighe-count)]);
        testSet = [testSet; backUpDataset(rndRaw,:)];
        backUpDataset(rndRaw,:) = [];
        count = count+1;
        [backUpRighe, ~] = size(backUpDataset);
    end
    testSet(1,:) = []; %elimino la prima riga di zeri creata in precedenza
    trainSet = backUpDataset;
end