clear;
clc;

%inizializzazione variabili
roofCluster = 10; %numero massimo di cluster
errors = zeros(1,roofCluster);
errors(1) = 25;
precisionBestNet = 50; %tiene traccia della migliore rete in assoluto
dimentionBestNet = [0 0];
numberOfTestedNet = 0;
flag = 0;
resultati = zeros(1,10);
%inizio analisi

%salvo il training set
[num, txt, raw] = xlsread('SmallDataset.xlsx',1,'A2:AU207');
ASFDataset_training = num;


%salvo il testing set
[num, txt, raw] = xlsread('SmallDataset.xlsx',2,'A2:AU90');
ASFDataset_testing = num;
count = 0;

% %%test cancello le feature
% for exe=35:47
%     if exe==46
%         
%     else
%         ASFDataset_training(:,exe-count) = [];
%         ASFDataset_testing(:,exe-count) = [];
%     end
%     count = count+1;
% end
t = ASFDataset_testing';
x = ASFDataset_training';


resultati = zeros(10,10);

for changew=1:10
for change=1:10
%il primo for controlla il numero di cluster da analizzare da 2 a roof

roofCluster = 15; %numero massimo di cluster
errors = zeros(1,roofCluster);
errors(1) = 25;
precisionBestNet = 50; %tiene traccia della migliore rete in assoluto
dimentionBestNet = [0 0];
numberOfTestedNet = 0;
flag = 0;


for clusterNumber=2:roofCluster
    
    %questo è l'errore per stabilire all'interno del numero n di cluster
    %quale è la migliore rete
    errorThreshold = 50;
    
    %genero le dimensioni della rete: voglio configurazioni rettangolari
    %le cui dimensioni moltiplicate diano il numero dei cluster
    for numA=1:clusterNumber
        if (mod(clusterNumber,numA)==0) %esegue il resto della divisione
            
            numB = clusterNumber/numA;
            
            [numFeature numCampioni] = size(ASFDataset_testing');
            
            %genero la net
            net = selforgmap([numA numB]);
            
            %%possibility to set training param.
            %net.trainParam.showWindow = false;
            
            net.trainParam.epochs = 200*change;  %numero di epoche (200)
            net.trainParam.lr = 0.01*changew;     %learning rate  (0.01)
            %net.trainParam.lr = 0.01+0.10*change;     %learning rate  (0.01)
            %net.trainParam.lr_dec = 0.7*change;  %ratio to decrease lr (0.7)
            
            
            %training della rete sul dataset di training x
            net = train(net,x);
            
            %le seguenti righe di codice generano il vettore classes
            %per ogniuno dei campioni presenti in x è presente il cluster di
            %appartenenza.
            y = net(x);
            classes = vec2ind(y);
            
            %calcolo dei centroidi per la rete
            
            %genero la matrice dei centroidi per la combinazione numA*numB
            matriceCentroidi = zeros(numFeature,numA*numB);
            
            for i=1:clusterNumber
                supportingArray = zeros(4,numFeature);
                temp = -1; %variabile per risolvere i cluster vuoti
                for k=1:length(classes)
                    if classes(k)==i %cerco quali elementi del dataset originale sono caduti nel cluster i
                        for j=1:numFeature
                            temp = x(j,k); %controllo il valore dataset in k per ogniuna delle j feature
                            if temp > 3
                                error('valore non supportato'); %il dataset non contiene valori superiori a 3
                            else
                                %aumento la colonna della matrice
                                %corrispondente al risultato
                                supportingArray(temp+1,j) = supportingArray(temp+1,j)+1;
                            end
                        end
                    end
                end
                
                if temp == -1
                    %se temp è -1 il cluster è vuoto e non è possibile
                    %computare un centroide
                    errorVector = zeros(numFeature,1)-1;
                    matriceCentroidi(:,i) = errorVector;
                else
                    %calcolo il vettore dei centroidi scegliendo il risultato
                    %preferito per ogni feature
                    [M,centroideCluster1] = max(supportingArray);
                    centroideCluster1 = (centroideCluster1-1)';
                    matriceCentroidi(:,i) = centroideCluster1;
                end
            end
            
            %testing delle prestazioni
            
            k = net(t);
            clusterHit = vec2ind(k);
            
            hitRate = zeros(1,length(clusterHit));
            
            for i=1:length(clusterHit)
                errorVector = matriceCentroidi(:,clusterHit(i))-t(:,i);
                goodResult = sum(errorVector(:)==0);
                hitRate(:,i) = (goodResult/numFeature)*100;
            end
            
            hitRateComplessivo = mean(hitRate);
            numberOfTestedNet = numberOfTestedNet + 1;
            
            if hitRateComplessivo>errorThreshold
                %se la rete è la migliore(sin ora) per questo n
                errorThreshold=hitRateComplessivo; %aggiorno il threshold
                errors(clusterNumber) = 100-hitRateComplessivo; %computo errore
            end
        end
    end
    
    %controllo che le prestazioni migliorino abbastanza devono avere
    %un aumento di almeno il 25% rispetto alla precedente iterazione
    
    %il controllo puo essere fatto solo dal quarto giro in poi in
    %quanto per 1 cluster l'analisi non ha senso
    if clusterNumber > 3
        if (errors(clusterNumber-1)-errors(clusterNumber)) < ((errors(clusterNumber-2)-errors(clusterNumber-1))*20/100)
            flag = 1;
        end
    end
    %controllo infine se la precisione
    if (flag == 0)
        if errors(clusterNumber)<(100-precisionBestNet)
            %se la rete è la migliore in assoluto
            precisionBestNet=hitRateComplessivo; %aggiorno la best net
            bestNet = net; %salvo la best net
            dimentionBestNet = [numA numB]; %aggiorno le dimensioni
        end
    end
end


resultati(change,changew)=precisionBestNet;

end
end
%save bestNet;
bestNetNumber = dimentionBestNet(1,1)*dimentionBestNet(1,2);

%plot del grafico degli errori
plot(errors,'-o','MarkerIndices',bestNetNumber);

xlswrite('risultatitimultipli.xlsx',resultati);



