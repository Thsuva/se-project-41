function saveWinnerCluster(app,winnerCluster)
%SAVEWINNERCLUSTER si occupa di gestire il salvataggio in un file del cluster per l'utente
%   SAVEWINNERCLUSTER(APP,WINNERCLUSTER) la funzione gestisce il salvataggio in un fle formato
%   xls o csv, di un vettore per i permessi basato sulla previsione di un
%   modello ad albero e contenuto in WINNERCLUSTER.
%   Nel caso in cui il file esista gia viene sovrascritto.
%   Inoltre aggiorna l'UI per comunicare all'utente l'esito dell'operazione
%   Input Argument:
%       APP     appdesigner app a cui la funzione fa riferimento,
%               l'imput è necesario per utilizzare la funzione all'interno
%               del tool ma non essendo la funzione vincolata ad alcun
%               elemento viene sostituito con '~'
%       WINNERCLUSTER
%               centroide del cluster scelto per l'utente che andrà a
%               formare i suoi permessi
%   See also XLSWRITE

    [FileNameWrite, PathNameWrite] = uiputfile({'*.xls';'*.csv'},'Save As...',['myPermission' '.xls']);
    if FileNameWrite ~=0
        if exist([PathNameWrite FileNameWrite],'file')
            delete([PathNameWrite FileNameWrite]);
        end

        xlswrite([PathNameWrite FileNameWrite],winnerCluster); %data
        app.QuestionLabel2.Text = strcat('your permission are in: ',FileNameWrite);
        app.QuestionLabel2.Visible = 'on';
    else
        app.QuestionLabel2.Text = strcat('saving has failed, you need to restart the tool');
        app.QuestionLabel2.Visible = 'on';
    end
end