import matlab.unittest.TestRunner;
import matlab.unittest.plugins.TestReportPlugin;
import matlab.unittest.plugins.CodeCoveragePlugin;


suite = testsuite('test');
runner = TestRunner.withTextOutput;


pdfFile = 'myTestReport.pdf';
plugin = TestReportPlugin.producingPDF(pdfFile,...
    'IncludingPassingDiagnostics',true,'IncludingCommandWindowText',true);

runner.addPlugin(plugin);
runner.addPlugin(CodeCoveragePlugin.forFolder('C:\Users\fabrizio\Desktop\se-project-41-master\src'));

result = runner.run(suite);
