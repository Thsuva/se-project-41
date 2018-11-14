function booleanReturn = errorHandler(app, errorCode)
%ERRORHANDLER gestisce un flag e la stringa di errore da mostrare
%   BOOLEANRETURN = ERRORHANDLER(APP, ERRORCODE)la funzione modifica la 
%   stringa di errore a secondo dell'errore presente in ERRORCODE
%   e la rende visibile nella UI.
%   Se errorCode = 0 nessun errore è stato trovato e il ritorno della 
%   funzione sarà true, in caso contrario, essendo false, l'esecuzione del
%   codice verrà interrotta
%   Input Argument:
%       APP     appdesigner app a cui la funzione fa riferimento,
%               l'imput è necesario per utilizzare la funzione all'interno
%               del tool ma non essendo la funzione vincolata ad alcun
%               elemento viene sostituito con '~'
%       ERRORCODE
%               codice dell'errore presente nel dataset
%   See also errorChecker
    if errorCode == 0
        booleanReturn = true;
    else
        errorString = '';
        switch errorCode
            case 1
                errorString = 'invalid file name';
            case 2
                errorString = 'file not found';
            case 3
                errorString = 'dataset you choose is empty';
            case 4
                errorString = 'there is a NON whole number in the dataset';
            case 5
                errorString = 'there is a value greater than 10 in the dataset';
            case 6
                errorString = 'there is a negative value in the dataset';
            case 7
                errorString = 'there is a NaN value in the dataset';
            otherwise
                errorString = 'unexpected error has occurred';
        end

        app.ErrorLabel.Visible = 'on';
        app.ErrorLabel.Text = errorString;
        booleanReturn = false;
    end
end