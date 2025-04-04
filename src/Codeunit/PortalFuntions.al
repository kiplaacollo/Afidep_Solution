codeunit 172997 PortalFunctions
{
    var
        jsonFunctionsG: Codeunit JsonFunctions;
        objNumSeries: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Purchases & Payables Setup";
        purchaseLine: record "Purchase Line";
        lJObject: dotnet JObject;
        lArrayString: Text;
        lJSONString: Text;
        lJsonArray: DotNet JArray;

    procedure GETCUSTOMER(custId: Code[30]): JsonObject
    var
        JsonFunctions: Codeunit JsonFunctions;
        cust: record Customer;
        recVariant: Variant;
    begin

        cust.Get(custId);
        recVariant := cust;

        exit(JsonFunctions.RecordToJson(recVariant));


    end;

    // Ref: AUTHENTICATION 
    procedure LOGIN(username: Code[50]; password: Text): Boolean
    var
        hrEmployee: record "HR Employees";
        authenticated: Boolean;
    begin
        authenticated := false;
        hrEmployee.reset;
        hrEmployee.SetRange("No.", username);
        hrEmployee.SetRange("Portal Password", password);
        if hrEmployee.FindFirst() then authenticated := true;
        exit(authenticated);

    end;
    //Get otp
    procedure REGISTER(username: Code[50]; email: Text; idno: code[20]): Boolean
    //TODO: Create a better otp management for registering new users
    VAR
        hrEmployee: record "HR Employees";
        otp: Text;
        rand: Text;
    begin
        otp := '';
        hrEmployee.Reset;
        hrEmployee.SetRange("No.", username);
        hrEmployee.SetRange(hrEmployee."E-Mail", email);
        hrEmployee.SetRange("ID Number", idno);
        if hrEmployee.FindFirst then begin
            rand := Format(Random(99999));
            hrEmployee."Portal Password" := rand;
            hrEmployee.Modify(true);
            exit(SENDEMAIL(email, 'Your O.T.P is ' + Format(rand)));

        end else
            exit(false);

    end;

    procedure SENDEMAIL(email: text; message: Text): Boolean;
    var
        smtp: Codeunit Email;
        smtpsetup: Codeunit "Email Message";
    begin

        smtpsetup.Create(email, 'Self service portal communication', message);
        smtp.Send(smtpsetup);

        exit(true);
    end;

    procedure CONFIRMREGISTRATION(username: Code[50]; otp: Text; password: Text): Boolean
    var
        hremployee: record "HR Employees";
        confirmed: Boolean;
    begin
        confirmed := false;
        hremployee.Reset();
        hremployee.SetRange("No.", username);
        hremployee.SetRange("Portal Password", otp);
        if hremployee.FindFirst() then begin
            hremployee."Portal Password" := password;
            hremployee.Modify(true);
            confirmed := true;
        end;
        exit(confirmed);
    end;

    //GET 
    procedure HREMPLOYEE(No: code[50]): JsonObject
    var
        ref: Variant;
        hrEmployee: record "HR Employees";
        JO: JsonObject;
    begin
        if hrEmployee.Get(No) then begin
            ref := hrEmployee;
            JO := jsonFunctionsG.RecordToJson(ref);
        end;

        exit(JO);

    end;

    // GET MANY
    procedure HREMPLOYEES(): JsonArray
    VAR
        ref: Variant;
        hremployee: record "HR Employees";
        JA: JsonArray;
        JO: JsonObject;

    begin
        hremployee.Find('-');
        repeat

            ref := hremployee;
            JO := jsonFunctionsG.RecordToJson(ref);
            JA.Add(JO);

        until hremployee.Next = 0;

        exit(JA);
    end;
    //GET 
    procedure LEAVE(No: code[50]; LeaveType: Code[60]): JsonObject
    var
        ref: Variant;
        hrLeave: Record "HR Leave Application";
        JO: JsonObject;
    begin
        if hrLeave.Get(No, LeaveType) then begin
            ref := hrLeave;
            JO := jsonFunctionsG.RecordToJson(ref);
        end;

        exit(JO);

    end;

    // GET MANY
    procedure LEAVES(): JsonArray
    VAR
        ref: Variant;
        hrLeave: Record "HR Leave Application";
        JA: JsonArray;
        JO: JsonObject;

    begin
        hrLeave.Find('-');
        repeat

            ref := hrLeave;
            JO := jsonFunctionsG.RecordToJson(ref);
            JA.Add(JO);

        until hrLeave.Next = 0;

        exit(JA);
    end;

    procedure PURCHASEHEADER(No: code[50]): JsonObject
    var
        ref: Variant;
        purchaseHeader: record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        relationships: JsonArray;

        JO: JsonObject;
        JOR: JsonObject;
    begin
        if purchaseHeader.Get(purchaseHeader."Document Type"::Quote, No) then begin
            ref := purchaseHeader;
            JO := jsonFunctionsG.RecordToJson(ref);
            purchaseLine.reset;
            purchaseLine.SetRange("Document No.", no);
            if purchaseLine.Find('-') then begin
                repeat
                    ref := purchaseLine;
                    relationships.Add(jsonFunctionsG.RecordToJson(ref));
                until purchaseLine.Next = 0;
            end;
            JO.Add('relationships', relationships);
        end;

        exit(JO);

    end;

    procedure REQUESTHEADER(No: code[50]): JsonObject
    var
        ref: Variant;
        purchaseHeader: record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        relationships: JsonArray;

        JO: JsonObject;
        JOR: JsonObject;
    begin
        if purchaseHeader.Get(purchaseHeader."Document Type"::Quote, No) then begin
            ref := purchaseHeader;
            JO := jsonFunctionsG.RecordToJson(ref);
            purchaseLine.reset;
            purchaseLine.SetRange("Document No.", no);
            if purchaseLine.Find('-') then begin
                repeat
                    ref := purchaseLine;
                    relationships.Add(jsonFunctionsG.RecordToJson(ref));
                until purchaseLine.Next = 0;
            end;
            JO.Add('relationships', relationships);
        end;

        exit(JO);

    end;



    procedure REQUESTFORM(No: code[50]): JsonObject
    var
        ref: Variant;
        purchaseHeader: record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        relationships: JsonArray;
        JO: JsonObject;
        JOR: JsonObject;

    begin
        if purchaseHeader.Get(purchaseHeader."Document Type"::Quote, No) then begin

            ref := purchaseHeader;
            JO := jsonFunctionsG.RecordToJson(ref);
            purchaseLine.Reset();
            purchaseLine.SetRange("Document No.", No);
            if purchaseLine.FindSet() then begin
                repeat
                    relationships.Add(jsonFunctionsG.RecordToJson(purchaseLine));
                until purchaseLine.Next() = 0;
            end;

            JO.Add('relationships', relationships);

        end;
       
        exit(JO);

    end;

    procedure PURCHASEHEADERS(employee: code[50]): JsonArray;
    var
        ref: Variant;
        pHeader: record "Purchase Header";
        JA: JsonArray;
    begin
        pHeader.Reset;
        pHeader.SetRange("Employee No", employee);
        if pHeader.Find('-') then begin
            repeat
                ref := pHeader;
                JA.Add(PURCHASEHEADER(pHeader."No."));
            until pHeader.Next = 0;
        end;
        exit(JA);
    end;


    procedure REQUESTFORMHEADERS(employee: code[50]): JsonArray;
    var
        ref: Variant;
        pHeader: record "Purchase Header";
        JA: JsonArray;
    begin
        pHeader.Reset;
        pHeader.SetRange("Employee No", employee);
        if pHeader.Find('-') then begin
            repeat
                ref := pHeader;
                JA.Add(REQUESTFORM(pHeader."No."));
            until pHeader.Next = 0;
        end;
        exit(JA);
    end;









    procedure FnInsertRequestForm(JsonData: Text[2048]) jsonObject: JsonObject
    var
        lineNo: Integer;
        departuretime: DateTime;
        arrivalTime: DateTime;
        ModifyLineNo: Integer;
        purchaseheader: Record "Purchase Header";
        hrEmployee: Record "HR Employees";
        customer: Record Customer;

    begin

        lJSONString := JsonData;
        if lJSONString <> '' then
            lJObject := lJObject.Parse(Format(lJSONString));
        if Format(lJObject.GetValue('No')) = '' then begin
            purchaseheader.Init;
            GenLedgerSetup.Get;
            purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Mission Proposal Nos.", 0D, true);
            purchaseheader."No. Series" := GenLedgerSetup."Mission Proposal Nos.";
            purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        end
        else
            purchaseheader."No." := Format(lJObject.GetValue('No'));

        purchaseheader."Shortcut Dimension 1 Code" := Format(lJObject.GetValue('ProgramCode'));
        purchaseheader."Shortcut Dimension 2 Code" := Format(lJObject.GetValue('budgetdminesion'));
        purchaseheader.Purpose := Format(lJObject.GetValue('Purpose'));
        purchaseheader."Posting Description" := Format(lJObject.GetValue('Department'));
        purchaseheader.MP := true;
        hrEmployee.Get(purchaseHeader."Employee No");
        purchaseHeader."Employee Name" := hrEmployee."First Name" + ' ' + hrEmployee."Middle Name" + ' ' + hrEmployee."Last Name";
        purchaseHeader."Account No" := hrEmployee.Travelaccountno;
        customer.get(hrEmployee.Travelaccountno);
        purchaseHeader."Responsibility Center" := hrEmployee."Responsibility Center";
        purchaseHeader."Responsibility Center Name" := hrEmployee."Responsibility Center Name";
        purchaseheader.Validate("Employee No");
        // Peformance
        //Travel detials
        lArrayString := lJObject.SelectToken('relationships').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);

        if ModifyLineNo = 0 then
            purchaseline.Insert
        else
            purchaseline.Modify;

        foreach lJObject in lJsonArray do begin
            Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));

            if ModifyLineNo = 0 then begin
                purchaseline.Init;
                purchaseline."Line No." := lineNo;
            end else
                purchaseline."Line No." := ModifyLineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::ActionPoints;


            Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));
            purchaseline.date := purchaseline.date;
            Evaluate(departuretime, Format(lJObject.GetValue('departureTime')));
            purchaseline.departureTime := Dt2Time(departuretime);
            purchaseline.departurePlace := Format(lJObject.GetValue('departurePlace'));
            purchaseline.arrivalPlace := Format(lJObject.GetValue('arrivalPlace'));
            Evaluate(arrivalTime, Format(lJObject.GetValue('arrivalTime')));
            purchaseline.arrivalTime := Dt2Time(arrivalTime);
            purchaseline.remarks := Format(lJObject.GetValue('remarks'));

            if ModifyLineNo = 0 then
                purchaseline.Insert
            else
                purchaseline.Modify;

            lineNo += 1000;
        end;
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('AccomodationDetails').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);

        //Accoumodation detils
        foreach lJObject in lJsonArray do begin
            Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
            if ModifyLineNo = 0 then begin
                purchaseline.Init;
                purchaseline."Line No." := lineNo;
            end else
                purchaseline."Line No." := ModifyLineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::Activity;


            Evaluate(purchaseline.dateFrom, Format(lJObject.GetValue('dateFrom')));
            Evaluate(purchaseline.dateTo, Format(lJObject.GetValue('dateTo')));
            purchaseline.date := purchaseline.date;
            Evaluate(purchaseline.accomodtionCatered, Format(lJObject.GetValue('accomodationCatered')));


            Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));


            if ModifyLineNo = 0 then
                purchaseline.Insert
            else
                purchaseline.Modify;

            lineNo += 1000;
        end;

        /// Meals and incidentals
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('MealsAndIncidentals').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);

        foreach lJObject in lJsonArray do begin
            Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
            if ModifyLineNo = 0 then begin
                purchaseline.Init;
                purchaseline."Line No." := lineNo;
            end else
                purchaseline."Line No." := ModifyLineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::"Budget Info";


            Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));

            purchaseline."location." := Format(lJObject.GetValue('location'));
            purchaseline.Description := Format(lJObject.GetValue('description'));
            Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
            Evaluate(purchaseline.noOfDays, Format(lJObject.GetValue('noOfDays')));


            if ModifyLineNo = 0 then
                purchaseline.Insert
            else
                purchaseline.Modify;

            lineNo += 1000;
        end;

        // other expenses
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('OtherExpenses').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);


        foreach lJObject in lJsonArray do begin
            Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
            if ModifyLineNo = 0 then begin
                purchaseline.Init;
                purchaseline."Line No." := lineNo;
            end else
                purchaseline."Line No." := ModifyLineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::"Budget Notes";


            Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));

            purchaseline."location." := Format(lJObject.GetValue('location'));
            purchaseline.Description := Format(lJObject.GetValue('description'));
            Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));


            if ModifyLineNo = 0 then
                purchaseline.Insert
            else
                purchaseline.Modify;
            lineNo += 1000;
        end;
        if Format(lJObject.GetValue('No')) = '' then
            purchaseheader.Insert
        else
            purchaseheader.Modify;
    end;

    procedure browseJson(J: JsonObject; k: Text): JsonToken
    var
        jtoken: JsonToken;
    begin
        J.Get(k, jtoken);
        exit(jtoken);
    end;


}