page 80180 "DocumentsPortal"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;

    SourceTable = "Portal Document upload";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Url; Rec.Url)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies Document Link.';
                    ExtendedDatatype = URL;
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        // Filema: Codeunit "PDF Displayer";
                        // NewStream: InsTream;
                        // TempFile: File;
                        // ToFileName: Variant;
                        // Uri: DotNet Uri;
                        // OutStream: OutStream;
                        // TempBlob: Codeunit "Temp Blob";
                        // HttpClient: HttpClient;
                        // Response: HttpResponseMessage;
                        // Buffer: BigText;
                        // ContentText: Text;
                        // Char: Char;
                        TempBlob: Codeunit "Temp Blob";
                        TempBlobOutStream: OutStream;
                        ResponseStream: InStream;
                        FileName: Text;
                        //Rec: Record;
                        Url: Text;
                    begin

                    //     Url := Rec.Url; // URL of the file you want to download

                    //     // Create a TempBlob and its output stream
                    //     TempBlob.CreateOutStream(TempBlobOutStream);

                    //     // Fetch the file content from the URL and write it to TempBlob
                    //    // HttpClient.Get(Url, ResponseStream);
              
                    //         TempBlobOutStream.WriteText(ResponseStream.ReadText(Url,StrLen(Url)));
                      

                    //     // Set the destination filename
                    //     FileName := 'output.txt';

                    //     // Download content from TempBlob to a file
                    //     DownloadFromStream(TempBlobOutStream, 'Export', '', 'All Files (*.*)|*.*', FileName);

                    //     // Close the TempBlob
                    //     TempBlob.Close;
                    //     //Download(Rec.Url)
                    //     //TempFile.CreateInStream(NewStream);

                    //     // TempFile.CreateTempFile();
                    //     // TempFile.Write(Rec.Url);
                        // TempFile.CreateInStream(NewStream);
                        // ToFileName := rec.Description;
                        // NewStream.ReadText(Rec.Url);
                        // DownloadFromStream(NewStream, 'Export', '', 'All Files (*.*)|*.*', ToFileName);
                        // TempFile.Close();
                    end;

                }
                field(link; link)
                {
                    ApplicationArea = all;
                    ExtendedDatatype = URL;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Filema: Codeunit "PDF Displayer";
                    begin
                        //Hyperlink(Rec.Url);
                        //CreateGuid();
                        Filema.ReadAndDisplayFileContent(Rec.Url);
                    end;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;


                }
                field(Description; Rec.Description) { ApplicationArea = all; }


            }


        }



    }

    actions
    {
        area(Processing)
        {
            action(DisplayPDF)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

    end;

    procedure ReadAndExtractURLLink()
    var
        uri: DotNet Uri;
        FileRead: DotNet File;
        PortalDocuments: Record "Portal Document upload";
        FileManagement: Codeunit "File Management";
    //uri: DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Uri";

    begin
        PortalDocuments.Reset();
        PortalDocuments.SetRange(PortalDocuments."Document No", Rec."Document No");
        if PortalDocuments.Find('-') then begin
            Hyperlink(PortalDocuments.Url);
            // link := PortalDocuments.Url;
            //link:= FileManagement.GetServerDirectoryFilesList();
            // FileRead.ReadAllBytes(link);
        end;
        ///uri := uri.Uri(link);
    end;

    var
        UrlLinK: Text;
        link: Text;
        TempFile: File;
        TempFileName: Text[250];
        TempFileInStream: InStream;
        ToFileName: Text[100];
        FileManagement: Codeunit "File Management";
        FilePath: Text[2014];
        path: DotNet Path;
        Jina: Text[2048];

}