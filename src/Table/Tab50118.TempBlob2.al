Table 50118 "TempBlob2"
{
    Caption = 'TempBlob';

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; Blob; Blob)
        {
            Caption = 'Blob';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GlobalInStream: InStream;
        GlobalOutStream: OutStream;
        ReadLinesInitialized: Boolean;
        WriteLinesInitialized: Boolean;
        NoContentErr: label 'The BLOB field is empty.';
        UnknownImageTypeErr: label 'Unknown image type.';
        XmlCannotBeLoadedErr: label 'The XML cannot be loaded.';

    procedure WriteAsText(Content: Text; Encoding: TextEncoding)
    var
        OutStr: OutStream;
    begin
        Clear(Blob);
        if Content = '' then
            exit;
        Blob.CreateOutstream(OutStr, Encoding);
        OutStr.WriteText(Content);
    end;

    procedure ReadAsText(LineSeparator: Text; Encoding: TextEncoding) Content: Text
    var
        InStream: InStream;
        ContentLine: Text;
    begin
        Blob.CreateInstream(InStream, Encoding);

        InStream.ReadText(Content);
        while not InStream.eos do begin
            InStream.ReadText(ContentLine);
            Content += LineSeparator + ContentLine;
        end;
    end;

    procedure ReadAsTextWithCRLFLineSeparator(): Text
    var
        CRLF: Text[2];
    begin
        CRLF[1] := 13;
        CRLF[2] := 10;
        exit(ReadAsText(CRLF, Textencoding::UTF8));
    end;

    procedure StartReadingTextLines(Encoding: TextEncoding)
    begin
        Blob.CreateInstream(GlobalInStream, Encoding);
        ReadLinesInitialized := true;
    end;

    procedure StartWritingTextLines(Encoding: TextEncoding)
    begin
        Clear(Blob);
        Blob.CreateOutstream(GlobalOutStream, Encoding);
        WriteLinesInitialized := true;
    end;

    procedure MoreTextLines(): Boolean
    begin
        if not ReadLinesInitialized then
            StartReadingTextLines(Textencoding::Windows);
        exit(not GlobalInStream.eos);
    end;

    procedure ReadTextLine(): Text
    var
        ContentLine: Text;
    begin
        if not MoreTextLines then
            exit('');
        GlobalInStream.ReadText(ContentLine);
        exit(ContentLine);
    end;

    procedure WriteTextLine(Content: Text)
    begin
        if not WriteLinesInitialized then
            StartWritingTextLines(Textencoding::Windows);
        GlobalOutStream.WriteText(Content);
    end;

    procedure ToBase64String(): Text
    var
        IStream: InStream;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Base64String: Text;
    begin
        if not Blob.Hasvalue then
            exit('');
        Blob.CreateInstream(IStream);
        MemoryStream := MemoryStream.MemoryStream;
        CopyStream(MemoryStream, IStream);
        Base64String := Convert.ToBase64String(MemoryStream.ToArray);
        MemoryStream.Close;
        exit(Base64String);
    end;

    procedure FromBase64String(Base64String: Text)
    var
        OStream: OutStream;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
    begin
        if Base64String = '' then
            exit;
        MemoryStream := MemoryStream.MemoryStream(Convert.FromBase64String(Base64String));
        Blob.CreateOutstream(OStream);
        MemoryStream.WriteTo(OStream);
        MemoryStream.Close;
    end;

    procedure GetHTMLImgSrc(): Text
    var
        ImageFormatAsTxt: Text;
    begin
        if not Blob.Hasvalue then
            exit('');
        if not TryGetImageFormatAsTxt(ImageFormatAsTxt) then
            exit('');
        exit(StrSubstNo('data:image/%1;base64,%2', ImageFormatAsTxt, ToBase64String));
    end;

    [TryFunction]
    local procedure TryGetImageFormatAsTxt(var ImageFormatAsTxt: Text)
    var
        Image: dotnet Image;
        ImageFormatConverter: dotnet ImageFormatConverter;
        InStream: InStream;
    begin
        Blob.CreateInstream(InStream);
        Image := Image.FromStream(InStream);
        ImageFormatConverter := ImageFormatConverter.ImageFormatConverter;
        ImageFormatAsTxt := ImageFormatConverter.ConvertToString(Image.RawFormat);
    end;

    procedure GetImageType(): Text
    var
        ImageFormatAsTxt: Text;
    begin
        if not Blob.Hasvalue then
            Error(NoContentErr);
        if not TryGetImageFormatAsTxt(ImageFormatAsTxt) then
            Error(UnknownImageTypeErr);
        exit(ImageFormatAsTxt);
    end;

    [TryFunction]
    procedure TryDownloadFromUrl(Url: Text)
    var
        FileManagement: Codeunit "File Management";
        WebClient: dotnet WebClient;
        MemoryStream: dotnet MemoryStream;
        OutStr: OutStream;
    begin
        FileManagement.IsAllowedPath(Url, false);
        WebClient := WebClient.WebClient;
        MemoryStream := MemoryStream.MemoryStream(WebClient.DownloadData(Url));
        Blob.CreateOutstream(OutStr);
        CopyStream(OutStr, MemoryStream);
    end;

    [TryFunction]
    local procedure TryGetXMLAsText(var Xml: Text)
    var
        XmlDoc: dotnet XmlDocument;
        InStr: InStream;
    begin
        Blob.CreateInstream(InStr);
        XmlDoc := XmlDoc.XmlDocument;
        XmlDoc.PreserveWhitespace := false;
        XmlDoc.Load(InStr);
        Xml := XmlDoc.OuterXml;
    end;

    procedure GetXMLAsText(): Text
    var
        Xml: Text;
    begin
        if not Blob.Hasvalue then
            Error(NoContentErr);
        if not TryGetXMLAsText(Xml) then
            Error(XmlCannotBeLoadedErr);
        exit(Xml);
    end;
}

