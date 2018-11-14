function [backUptrain, backUptest] = deleteUselessFeature(app,train,test,numFeature,imp)
%DELETEUSELESSFEATURE cancella dal dataset le colonne corrisponednti a indici nulli di imp
%   [BACKUPTRAIN, BACKUPTEST] = DELETEUSELESSFEATURE(APP,TRIN,TEST,NUMFEATURE,IMP)
%   la funzione modifica la matrice contentente il train set TRAIN e la matrice
%   contenente il test set TEST eliminando quelle feature che compaiono con valori nulli
%   nel vettore IMP, vettore di importanza delle feature nel modello ad
%   albero.
%   Input Argument:
%       APP     appdesigner app a cui la funzione fa riferimento,
%               l'imput è necesario per utilizzare la funzione all'interno
%               del tool e per referenziarne le proprietà
%       TRAIN
%               trainSet ovvero una delle porzioni in cui il dataset è
%               stato diviso e utilizzata per il training dei modelli
%       TEST
%               testSet ovvero una delle porzioni in cui il dataset è
%               stato diviso e utilizzata per il test dei modelli trainati
%       NUMFEATURE
%               intero che rappresenta il numero delle feature estratte dal
%               dataset
%       IMP
%               vettore contenente gli indici di importanza delle feature
%               per il modello ad albero.
%               see also predictorImportance      

    backUptrain = train;
    backUptest  = test;
    count=0;

    for i=1:numFeature
        if (imp(i)==0)
            backUptrain(:,i-count) = [];
            backUptest(:,i-count) = [];
            app.questionVector(i-count) = [];
            count=count+1;
        end
    end
end