function errorCode = errorChecker(~,Dataset)
%ERRORCHECKER controlla che il dataset abbia il formato desiderato
%   ERRORCODE = ERRORCHECKER(APP,DATASET)la funzione si occupa di analizzare
%   il dataset per restituire in ERRORCODE l'eventuale codice dell' errore trovato 
%   Input Argument:
%       APP     appdesigner app a cui la funzione fa riferimento,
%               l'imput è necesario per utilizzare la funzione all'interno
%               del tool ma non essendo la funzione vincolata ad alcun
%               elemento viene sostituito con '~'
%       DATASET
%               dataset che si desidera analizzare
%   See also loadDataset
    [rawDataset, colDataset] = size(Dataset);
    errorCode = 0;

    if rawDataset == 0||colDataset == 0  %controllo che il dataset non sia vuoto
        errorCode = 3;
    else %se non lo è controllo che non ci siano:
        if ~isempty(Dataset(mod(Dataset,1) > 0)) %elementi con la virgola
            errorCode = 4;
        elseif ~isempty(Dataset(Dataset > 10)) %elementi > 10
            errorCode = 5;
        elseif ~isempty(Dataset(Dataset < 0)) %elementi < 0
            errorCode = 6;
        elseif any(any(isnan(Dataset))) %elementi NaN
            errorCode = 7;
        end
    end
end
