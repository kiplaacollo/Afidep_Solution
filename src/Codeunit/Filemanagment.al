// codeunit 50100 "HTTP Data Reader"
// {
//     procedure ReadDataFromURL()
//     var
//         HttpClient: HttpClient;
//         Response: HttpResponseMessage;
//         ResponseStream: InStream;
//         Buffer: Text[1000];
//         BytesRead: Integer;
//         filename: Text[2014];
//         Path: DotNet Path;
//         filepath: Text[2048];
//         filedata: Byte;

//         File: DotNet File;
//     begin
//         filename := Path.GetFileName(FileName);
//         filepath := Path.Combine('\\PASGR-FINANCE\Downloads\', filename);
//         filedata := File.ReadAllBytes(filepath);

//         // ResponseStream.ReadText()
//         // Make HTTP GET request
//         HttpClient.Get('\\PASGR-FINANCE\Downloads\', Response);

//         if Response.HttpStatusCode = 200 then begin
//             // Read response content stream
//             Response.Content.ReadAs(filepath);
//             response.Content().ReadAs(responseText);

//             // Initialize buffer and read response content
//             Buffer := '';
//             BytesRead := ResponseStream.READ(BUFFER);

//             WHILE BytesRead > 0 DO BEGIN
//                 Buffer := Buffer + SelectStr(ResponseStream.BYTES, 1, BytesRead);
//                 BytesRead := ResponseStream.READ(BUFFER);
//             END;

//             // Display the data using the MESSAGE function
//             MESSAGE(Buffer, 'Data from URL');
//         end
//         else begin
//             MESSAGE('Failed to fetch data from URL.', 'Error');
//         end;
//     end;


//     procedure MakeRequest(uri: Text; IStream: InStream) responseText: Text;
//     var
//         client: HttpClient;
//         request: HttpRequestMessage;
//         response: HttpResponseMessage;
//         contentHeaders: HttpHeaders;
//         content: HttpContent;
//     begin
//         // Add the InStream payload to the content
//         content.WriteFrom(IStream);

//         // Retrieve the contentHeaders associated with the content
//         content.GetHeaders(contentHeaders);
//         contentHeaders.Clear();
//         contentHeaders.Add('Content-Type', 'application/octet-stream');
//         request.Content := content;

//         request.SetRequestUri(uri);
//         request.Method := 'POST';

//         client.Send(request, response);

//         // Read the response content as json.
//         response.Content().ReadAs(responseText);
//     end;

// }

codeunit 50101 "HTTP Data Reader2"
{
    procedure ReadDataFromURL()
    var
        HttpClient: HttpClient;
        Response: HttpResponseMessage;
        ResponseContent: Text;
        ResponseStream: InStream;
    begin
        // Make HTTP GET request
        HttpClient.Get('http://192.168.10.241:8090/PASGR-FINANCE/Downloads/', Response);

        if Response.HttpStatusCode = 200 then begin
           
            // Read response content
            // ResponseContent := Response.Content.AsText;
            Response.Content.ReadAs(ResponseContent);

            // Display the data using the MESSAGE function
            MESSAGE(ResponseContent, 'Data from URL');
        end
        else begin
            MESSAGE('Failed to fetch data from URL.', 'Error');
        end;
    end;
}