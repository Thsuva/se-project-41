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

        function test_fileNameError(testCase)
            
            app=myPrivacyPersona;
            testCase.addTeardown(@delete,app);
            
            testCase.press(app.FindDSButton);
            %error -1
            app.DSfileName = 'C:\Users\fabrizio\Desktop\se-project-41-master\src\Testing_Funzionale\/error1Invalid.docx';
            testCase.press(app.StartButton);
            
            %error 1
            app.DSfileName = 67;
            testCase.press(app.StartButton);
            
            %error 2
            app.DSfileName = 'C:\Users\fabrizio\Desktop\se-project-41-master\src\Testing_Funzionale\/error2NotFound.xlsx';
            testCase.press(app.StartButton);
            
            %error 3
            app.DSfileName = 'C:\Users\fabrizio\Desktop\se-project-41-master\src\Testing_Funzionale\/error3Empty.xlsx';
            testCase.press(app.StartButton);
            
            %error 4
            app.DSfileName = 'C:\Users\fabrizio\Desktop\se-project-41-master\src\Testing_Funzionale\/error4Virgola.xlsx';
            testCase.press(app.StartButton);
            
            %error 5
            app.DSfileName = 'C:\Users\fabrizio\Desktop\se-project-41-master\src\Testing_Funzionale\/error5GR10.xlsx';
            testCase.press(app.StartButton);
            
            %error 6
            app.DSfileName = 'C:\Users\fabrizio\Desktop\se-project-41-master\src\Testing_Funzionale\/error6LT0.xlsx';
            testCase.press(app.StartButton);
            
            %error 7
            app.DSfileName = 'C:\Users\fabrizio\Desktop\se-project-41-master\src\Testing_Funzionale\/error7NaN.xlsx';
            testCase.press(app.StartButton);
            
            %no error
            testCase.press(app.DefaultDSButton);
            
            testCase.press(app.StartButton); 
            testCase.press(app.FeatureSelButton);
            app.TabGroup.SelectedTab = app.FindmypermissionTab;
            
            numDomande = length(app.questionVector);
            for i=1:numDomande
                if strcmp(app.BOHButton.Enable,'on')
                    testCase.press(app.BOHButton);
                else
                    if mod(i,2)==0
                        testCase.press(app.YESButton);
                    else
                        testCase.press(app.NOButton);
                    end 
                end
            end 
            
        end
    end   
end