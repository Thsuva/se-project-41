function [dataset, errorCode] = loadDataset(~,xlsxName)
%LOADDATASET legge il contenuto del file il cui nome è nella stringa xlsxName
%   [DATASET, ERRORCODE] = LOADDATASET(APP,XLSXNAME)la funzione di occupa 
%   di leggere il file il cui nome è contenuto in XLSXNAME.
%   Esegue inoltre alcuni controlli preliminari sulla possibilita che si 
%   generi errore nella lettura del file restituendo la matrice in DATASET
%   e l'eventuale errore in ERRORCODE
%   Input Argument:
%       APP     appdesigner app a cui la funzione fa riferimento,
%               l'imput è necesario per utilizzare la funzione all'interno
%               del tool ma non essendo la funzione vincolata ad alcun
%               elemento viene sostituito con '~'
%       XLSNAME
%               stringa contenete il nome e la posizione del file da
%               leggere
%   See also errorChecker|XLSREAD

    errorCode = 0;
    try
        vals_from_excel = xlsread(xlsxName);% tentativo di letturra del file Excel 
    catch exception
        if strcmp(exception.identifier,'MATLAB:xlsread:InvalidFileName')
            errorCode = 1; %nome del file invalido
        elseif strcmp(exception.identifier,'MATLAB:xlsread:FileNotFound')
            errorCode = 2;%file non valido
        else
            errorCode = -1;%errore inaspettato
        end
    end
    dataset = vals_from_excel;
end