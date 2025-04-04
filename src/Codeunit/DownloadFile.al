codeunit 50100 "PDF Displayer"
{
    procedure DisplayPDF(URl: Text[200])
    var
        HttpClient: HttpClient;
        Response: HttpResponseMessage;
        PdfStream: InStream;
        PdfContent: Text;
        PageParams: Page "DocumentsPortal";

    begin
        HttpClient.Get(URl, Response);

        if Response.HttpStatusCode = 200 then begin
            Response.Content.ReadAs(PdfContent);

            PageParams.RunModal();

        end;

        HttpClient.Timeout();
    end;

    procedure ReadAndDisplayFileContent(FilePath: Text[250])
    var
        FileManagement: DotNet File;//"'System.IO.File', 'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'";
                                    //FilePath: Text[250];
        FileText: Text[1000];
        FileStream: DotNet StreamReader;//"'System.IO.StreamReader', 'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'";
    begin
        Message('%1', FilePath);
        FileStream := FileManagement.OpenText(FilePath);
        FileText := FileStream.ReadToEnd();
        FileStream.Close();

        Message(FileText); // Display the file content
    end;



}
