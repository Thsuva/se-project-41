classdef test < matlab.uitest.TestCase
    
    properties
        originalPath
    end
    
    methods (TestMethodSetup)
        function addSolverToPath(testCase)
            testCase.originalPath = path;
            addpath(fullfile('C:','Users','fabrizio','Desktop','se-project-41-master','src'));
        end
    end
    
    methods (TestMethodTeardown)
        function restorePath(testCase)
            path(testCase.originalPath)
        end
    end
  
    methods (Test)

        function test_splitCrossVal(testCase)
            
            app=myPrivacyPersona;
            testCase.addTeardown(@delete,app);
            
            rng(0,'twister');
            xlsxName = 'SmallDataset.xlsx';
            fullDataset = xlsread(xlsxName);
            [Train, Test] = splitCrossVal(app,fullDataset);
            goodTest = xlsread('testSplit');
            goodTrain = xlsread('trainSplit');
            assert(~all(all(goodTest - Test)));
            assert(~all(all(goodTrain - Train)));
            
        end
        
        function test_errorChecker(testCase)
            
            app=myPrivacyPersona;
            testCase.addTeardown(@delete,app);
            
            xlsxName = ["SmallDataset.xlsx", "error3Empty.xlsx", "error4Virgola.xlsx", "error5GR10.xlsx", "error6LT0.xlsx", "error7NaN.xlsx"];
            supposedError = [0 3 4 5 6 7];
            for i=1:length(xlsxName)    
                fullDataset = xlsread(xlsxName(i));
                errorCode = errorChecker(app,fullDataset);
                
                assert(errorCode==supposedError(i));
            end
        end
        
        function test_errorHandler(testCase)
            
            app=myPrivacyPersona;
            testCase.addTeardown(@delete,app);
            
            errorString = ["unexpected error has occurred" "" "invalid file name" "file not found"...
                "dataset you choose is empty" "there is a NON whole number in the dataset"...
                "there is a value greater than 10 in the dataset"...
                "there is a negative value in the dataset" "there is a NaN value in the dataset" "unexpected error has occurred"];
            supposedError = [-1 0 1 2 3 4 5 6 7 8];
            boolValue = [false true false false false false false false false false];
            for i=1:length(supposedError)    
                
                boolean = errorHandler(app,supposedError(i));
%                 
%                 
                assert(boolean==boolValue(i));
                assert(strcmp(errorString(i),app.ErrorLabel.Text))
                app.ErrorLabel.Text='';
            end
        end
        
        function test_deleteUselessFeature(testCase)
            
            app=myPrivacyPersona;
            testCase.addTeardown(@delete,app);
            
            rng(0,'twister');
            Test  = xlsread('testSplit');
            Train = xlsread('trainSplit');
            [~, numFeature] = size(Test);
            app.questionVector=1:numFeature
            imp = zeros(1,numFeature);
            for i=1:numFeature
                a = 2;
                b = 10;
                imp(i) = (b-a).*rand(1,1) + a;
            end
            
            indexToDelete = [5 7 11 15 21 37 39];
            for j=1:length(indexToDelete)
                imp(indexToDelete(j))=0;
            end
            
           
            [LessTrain, LessTest] = deleteUselessFeature(app,Train,Test,numFeature,imp);
            
            for i=1:length(indexToDelete)
                [~, colTrain]=size(LessTrain);
                [~, colTest]=size(LessTrain);
                LessTrain = [LessTrain(:,1:indexToDelete(i)-1) Train(:,indexToDelete(i)) LessTrain(:,indexToDelete(i):colTrain)];
                LessTest = [LessTest(:,1:indexToDelete(i)-1) Test(:,indexToDelete(i)) LessTest(:,indexToDelete(i):colTest)];
                
            end    
            assert(~all(all(LessTest - Test)));
            assert(~all(all(LessTrain - Train)));
        end

    end   
end