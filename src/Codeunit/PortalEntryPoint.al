codeunit 172998 PortalEntryPoint
{
    var
        GenLedgerSetup: Record "Purchases & Payables Setup";






    procedure PortalRequests(
        FUNCTIONNAME: Text[100];
        REQUESTHEADER: Text;
        var RESPONSECODE: Integer;
        var RESPONSEDATA: BigText;
        var SUCCESSMESSAGE: Text
          )
    var
        customerData: JsonObject;
        portalFunctions: Codeunit PortalFunctions;
        request: JsonObject;
        response: JsonObject;
        No: Code[40];
        JT: JsonToken;
    begin

        if FUNCTIONNAME = 'GETCUSTOMER' THEN BEGIN
            customerData := portalFunctions.GETCUSTOMER('DN004');
            RESPONSECODE := 200;
            RESPONSEDATA.AddText(Format(customerData));
            SUCCESSMESSAGE := 'Customer';
            exit;
        END;
        if FUNCTIONNAME = 'PURCHASEHEADER' THEN BEGIN
            RESPONSECODE := 200;
            request.ReadFrom(REQUESTHEADER);
            RESPONSEDATA.AddText(format(portalFunctions.PURCHASEHEADER(browseJson(request, 'No').AsValue().AsText())));
            exit;
        END;

        if FUNCTIONNAME = 'REQUESTFORMHEADERS' THEN BEGIN
            RESPONSECODE := 200;
            request.ReadFrom(REQUESTHEADER);
            RESPONSEDATA.AddText(format(portalFunctions.REQUESTFORMHEADERS(browseJson(request, 'employeeNo').AsValue().AsText())));
            exit;

        END;

        if FUNCTIONNAME = 'PURCHASEHEADERS' THEN BEGIN
            RESPONSECODE := 200;
            request.ReadFrom(REQUESTHEADER);
            RESPONSEDATA.AddText(format(portalFunctions.PURCHASEHEADERS(browseJson(request, 'employeeNo').AsValue().AsText())));
            exit;
        END;



        if FUNCTIONNAME = 'LOGIN' then begin
            request.ReadFrom(REQUESTHEADER);
            response.Add('authenticated', portalFunctions.LOGIN(
            browseJson(request, 'username').AsValue().AsText(),
            browseJson(request, 'password').AsValue().AsText()));
            RESPONSEDATA.AddText(Format(response));
            exit;
        end;

        if FUNCTIONNAME = 'REGISTER' then begin
            request.ReadFrom(REQUESTHEADER);
            response.Add('authenticated', portalFunctions.REGISTER(
            browseJson(request, 'username').AsValue().AsText(),
            browseJson(request, 'email').AsValue().AsText(),
            browseJson(request, 'idno').AsValue().AsText()));
            RESPONSEDATA.AddText(Format(response));
            exit;
        end;

        if FUNCTIONNAME = 'CONFIRMREGISTRATION' then begin
            request.ReadFrom(REQUESTHEADER);
            response.Add('authenticated', portalFunctions.CONFIRMREGISTRATION(
            browseJson(request, 'username').AsValue().AsText(),
            browseJson(request, 'otp').AsValue().AsText(),
            browseJson(request, 'password').AsValue().AsText()));
            RESPONSEDATA.AddText(Format(response));
            exit;
        end;



    end;

    PROCEDURE Requesttypes() returnout: Text;
    VAR
        ObjDimensionValue: Record 50023;
        jarray: JsonArray;
        jobject: JsonObject;
        unitsofMeasure: Record "Unit of Measure";
        BudgetMatrix: Record 172069;

    BEGIN
        jobject.Add('Code', '');
        jobject.Add('Name', '');
        jobject.Add('Type', 'Request');
        jarray.Add(jobject);
        jobject.Replace('Code', '');
        jobject.Replace('Name', '');
        jobject.Replace('Type', 'Unit');
        jarray.Add(jobject);
        jobject.Replace('Code', '');
        jobject.Replace('Name', '');
        jobject.Replace('Type', 'Budget');
        jarray.Add(jobject);
        ObjDimensionValue.RESET;
        ObjDimensionValue.SETCURRENTKEY("Account Name");
        ObjDimensionValue.ASCENDING(TRUE);
        IF ObjDimensionValue.FINDFIRST THEN
            REPEAT
                jobject.Replace('Code', ObjDimensionValue."Type of Request");
                jobject.Replace('Name', ObjDimensionValue."Type of Request");
                jobject.Replace('Type', 'Request');
                jarray.Add(jobject);
            UNTIL ObjDimensionValue.NEXT = 0;

        unitsofMeasure.RESET;
        unitsofMeasure.SETCURRENTKEY(code);
        unitsofMeasure.ASCENDING(TRUE);
        IF ObjDimensionValue.FINDFIRST THEN
            REPEAT
                jobject.Replace('Code', unitsofMeasure.Code);
                jobject.Replace('Name', unitsofMeasure.Description);
                jobject.Replace('Type', 'Unit');
                jarray.Add(jobject);
            UNTIL unitsofMeasure.NEXT = 0;


        BudgetMatrix.RESET;
        BudgetMatrix.SETCURRENTKEY("Budget Line No Code");
        BudgetMatrix.SETCURRENTKEY("Budget Line No Code");
        BudgetMatrix.ASCENDING(TRUE);
        IF BudgetMatrix.FINDFIRST THEN
            REPEAT
                jobject.Replace('Code', BudgetMatrix."Budget Line No Code");
                jobject.Replace('Name', BudgetMatrix."Budget Line Description.");
                jobject.Replace('Type', 'Budget');
                jarray.Add(jobject);
            UNTIL BudgetMatrix.NEXT = 0;


        exit(Format(jarray));




    END;

    procedure browseJson(J: JsonObject; k: Text): JsonToken
    var
        jtoken: JsonToken;
    begin
        J.Get(k, jtoken);
        exit(jtoken);
    end;

    PROCEDURE fnDimensionValuesSpecific(filterType: Code[30]; filter: Code[60]) returnout: Text;
    VAR
        ObjDimensionValue: Record 349;
        jarray: JsonArray;
        jobject: JsonObject;

    BEGIN


        ObjDimensionValue.RESET;
        ObjDimensionValue.SetFilter("Global Dimension No.", filterType);
        ObjDimensionValue.SETRANGE(Code, filter);
        ObjDimensionValue.SETCURRENTKEY(Name);
        ObjDimensionValue.ASCENDING(TRUE);
        IF ObjDimensionValue.FINDFIRST THEN
            REPEAT
                jobject.Add('Code', ObjDimensionValue.Code);
                jobject.Add('Name', ObjDimensionValue.Name);
                jarray.Add(jobject);
            UNTIL ObjDimensionValue.NEXT = 0;

        exit(Format(jarray));




    END;

    PROCEDURE FnGetBudgetCodes(filterType: Code[30]; Filter: Code[60]) returnout: Text;
    VAR
        BudgetMatrix: Record 172069;
        jarray: JsonArray;
        jobject: JsonObject;

    BEGIN


        BudgetMatrix.RESET;
        BudgetMatrix.SETRANGE(BudgetMatrix."Budget Line No Code", filter);
        BudgetMatrix.SETCURRENTKEY("Budget Line No Code");
        BudgetMatrix.ASCENDING(TRUE);
        IF BudgetMatrix.FINDFIRST THEN
            REPEAT
                jobject.Add('Code', BudgetMatrix."Budget Line No Code");
                jobject.Add('Name', BudgetMatrix."Budget Line Description.");
                jarray.Add(jobject);
            UNTIL BudgetMatrix.NEXT = 0;

        exit(Format(jarray));




    END;

    PROCEDURE FnGetExpenseCode() returnout: Text;
    VAR
        PurchaseHeader: Record 38;
        jarray: JsonArray;
        jobject: JsonObject;

    BEGIN

        PurchaseHeader.RESET;
        PurchaseHeader.SetRange("AU Form Type", PurchaseHeader."AU Form Type"::"Expense Requisition");
        PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
        PurchaseHeader.SETCURRENTKEY("No.");
        PurchaseHeader.ASCENDING(TRUE);
        IF PurchaseHeader.FINDFIRST THEN
            REPEAT
                jobject.Add('Code', PurchaseHeader."No.");
                jobject.Add('Name', PurchaseHeader."No." + ' - ' + PurchaseHeader."Payee Naration");
                jarray.Add(jobject);
            UNTIL PurchaseHeader.NEXT = 0;

        exit(Format(jarray));
    END;

    PROCEDURE FnGetGlAccounts() returnout: Text;
    VAR
        GLAccounts: Record 15;
        jarray: JsonArray;
        jobject: JsonObject;

    BEGIN

        GLAccounts.RESET;
        GLAccounts.ASCENDING(TRUE);
        IF GLAccounts.FindSet THEN
            REPEAT
                jobject.Add('Code', GLAccounts."No.");
                jobject.Add('Name', GLAccounts.Name);
                jarray.Add(jobject);
            UNTIL GLAccounts.NEXT = 0;

        exit(Format(jarray));
    END;

    PROCEDURE FnGetBankAccounts() returnout: Text;
    VAR
        Banks: Record 270;
        jarray: JsonArray;
        jobject: JsonObject;

    BEGIN

        Banks.Reset();
        Banks.SetCurrentKey("No.");
        Banks.ASCENDING(TRUE);
        IF Banks.FINDFIRST THEN
            REPEAT
                jobject.Add('No', Banks."No.");
                jobject.Add('Name', Banks.Name);
                jarray.Add(jobject);
            UNTIL Banks.NEXT = 0;

        exit(Format(jarray));
    end;
    // PROCEDURE Requesttypes() returnout: Text;
    // VAR
    //     ObjDimensionValue: Record 50023;
    //     jarray: JsonArray;
    //     jobject: JsonObject;
    //     unitsofMeasure: Record "Unit of Measure";

    // BEGIN
    //     jobject.Add('Code', '');
    //     jobject.Add('Name', '');
    //     jobject.Add('Type', 'Request');
    //     jarray.Add(jobject);
    //     jobject.Replace('Code', '');
    //     jobject.Replace('Name', '');
    //     jobject.Replace('Type', 'Unit');
    //     jarray.Add(jobject);

    //     ObjDimensionValue.RESET;
    //     ObjDimensionValue.SETCURRENTKEY("Account Name");
    //     ObjDimensionValue.ASCENDING(TRUE);
    //     IF ObjDimensionValue.FINDFIRST THEN
    //         REPEAT
    //             jobject.Replace('Code', ObjDimensionValue."Type of Request");
    //             jobject.Replace('Name', ObjDimensionValue."Type of Request");
    //             jobject.Replace('Type', 'Request');
    //             jarray.Add(jobject);
    //         UNTIL ObjDimensionValue.NEXT = 0;

    //     unitsofMeasure.RESET;
    //     unitsofMeasure.SETCURRENTKEY(code);
    //     unitsofMeasure.ASCENDING(TRUE);
    //     IF ObjDimensionValue.FINDFIRST THEN
    //         REPEAT
    //             jobject.Replace('Code', unitsofMeasure.Code);
    //             jobject.Replace('Name', unitsofMeasure.Description);
    //             jobject.Replace('Type', 'Unit');
    //             jarray.Add(jobject);
    //         UNTIL unitsofMeasure.NEXT = 0;


    //     exit(Format(jarray));




    // END;



    PROCEDURE fnDimensionValues(filterType: Code[30]; filter: Code[60]) returnout: Text;
    VAR
        ObjDimensionValue: Record 349;
        jarray: JsonArray;
        jobject: JsonObject;
    BEGIN


        jobject.Add('Code', '');
        jobject.Add('Name', '');
        jarray.Add(jobject);

        jobject.Replace('Code', '');
        jobject.Replace('Name', '');
        jarray.Add(jobject);

        ObjDimensionValue.RESET;
        ObjDimensionValue.SetFilter("Global Dimension No.", filterType);
        ObjDimensionValue.SetRange(Blocked, false);
        ObjDimensionValue.SETCURRENTKEY(Name);
        ObjDimensionValue.ASCENDING(TRUE);


        IF ObjDimensionValue.FINDFIRST THEN BEGIN

            REPEAT

                jobject.Replace('Code', ObjDimensionValue.Code);
                jobject.Replace('Name', ObjDimensionValue.Name);
                jarray.Add(jobject);
            UNTIL ObjDimensionValue.NEXT = 0;
        END;
        exit(Format(jarray))
    END;

    procedure AppraisalPeriods(): Text
    VAR
        // ref: Variant
        appraisalPeriods: Record "Appraisal Periods";
        JA: JsonArray;
        JO: JsonObject;

    begin
        appraisalPeriods.Reset();
        appraisalPeriods.SetRange(Open, true);
        if appraisalPeriods.Find('-') then
            JO.Add('code', '');
        JO.Add('open', '');
        JO.Add('openedBy', '');
        JO.Add('periodStartDate', '');
        JO.Add('periodEndDate', '');
        JO.Add('description', '');
        JO.Add('closedBy', '');
        repeat
            JO.Replace('code', appraisalPeriods.code);
            JO.Replace('open', appraisalPeriods.Open);
            JO.Replace('openedBy', appraisalPeriods."Opened By");
            JO.Replace('periodStartDate', appraisalPeriods."Period Start Date");
            JO.Replace('periodEndDate', appraisalPeriods."Period End Date");
            JO.Replace('description', appraisalPeriods.Description);
            JO.Replace('closedBy', appraisalPeriods."Close By");


            JA.Add(JO);

        until appraisalPeriods.Next = 0;

        exit(Format(JA));
    end;
    // Supervisor objectives



    procedure JobPositions(): Text
    VAR
        // ref: Variant
        appraisalPeriods: Record "HR Jobss";
        JA: JsonArray;
        JO: JsonObject;

    begin
        appraisalPeriods.Find('-');

        repeat
            Clear(JO);
            JO.Add('code', appraisalPeriods."Job ID");
            JO.Add('description', appraisalPeriods."Job Description");

            JA.Add(JO);

        until appraisalPeriods.Next = 0;

        exit(Format(JA));
    end;
    // Supervisor objectives

    // procedure GetSupervisorObjectives(args: Text): Text

    // var
    //     JA: JsonArray;
    //     JO: JsonObject;
    //     joLines: JsonObject;
    //     jaLines: JsonArray;

    //     argJo: JsonObject;
    //     objecitves: record "Supervisor Job Specification";
    //     objeciveLines: record "Job Specification Lines";
    //     jsontoken: JsonToken;
    //     jobId: Code[40];
    //     employeeNo: code[50];
    //     SupervisorId: code[150];

    // begin
    //     //argJo.ReadFrom(args);
    //     if args <> '' then begin
    //         lJObject := lJObject.Parse(args);
    //         //  argJo.Get('jobId', jsontoken);
    //         jobId := Format(lJObject.GetValue('jobId'));
    //         employeeNo := Format(lJObject.GetValue('employeeNo'));
    //     end;
    //     objecitves.Reset();
    //     if jobId <> '' then
    //         objecitves.SetRange("Supervisor ID", Format(lJObject.GetValue('employeeNo')));
    //     if objecitves.Find('-') then begin
    //         repeat
    //             Clear(JO);
    //             objecitves.CalcFields("No of Lines");
    //             JO.Add('headerNo', objecitves."Header No");
    //             JO.Add('appraisalPeriod', objecitves."Appraisal Period");
    //             JO.Add('appraisalInterval', Format(objecitves."Appraisal Interval"));
    //             jo.Add('jobPosition', objecitves."Job Position");
    //             jo.Add('jobPositionName', objecitves."Job Position Name");
    //             jo.Add('markAsDone', objecitves."Mark as Done");
    //             jo.Add('evaluationPeriodEndDate', objecitves."Evaluation Period End Date");
    //             jo.add('evaluationPeriodStartDate', objecitves."Evaluation Period Start Date");
    //             jo.add('noOfLines', objecitves."No of Lines");

    //             objeciveLines.Reset();
    //             objeciveLines.SetRange("Header No", objecitves."Header No");
    //             if objeciveLines.find('-') then begin
    //                 repeat
    //                     Clear(joLines);
    //                     joLines.add('no', objeciveLines."No.");
    //                     joLines.add('lineNo', objeciveLines."Line No");
    //                     joLines.add('headerNo', objeciveLines."Header No");
    //                     joLines.Add('description', objeciveLines."Description/Job Specifications");
    //                     jaLines.add(joLines);

    //                 until objeciveLines.Next() = 0;

    //             end;



    //             jo.Add('lines', jaLines);
    //             JA.Add(JO);

    //         until objecitves.Next() = 0;
    //     end;


    //     exit(Format(JA));



    // end;


    // procedure GetSupervisorObjective(no: Code[50]): Text

    // var
    //     JA: JsonArray;
    //     JO: JsonObject;
    //     joLines: JsonObject;
    //     jaLines: JsonArray;

    //     argJo: JsonObject;
    //     objecitves: record "Supervisor Job Specification";
    //     objeciveLines: record "Job Specification Lines";
    //     jsontoken: JsonToken;
    //     jobId: Code[40];
    // begin


    //     if objecitves.get(no) then begin
    //         //  repeat
    //         objecitves.CalcFields("No of Lines");
    //         Clear(jo);
    //         JO.Add('headerNo', objecitves."Header No");
    //         JO.Add('appraisalPeriod', objecitves."Appraisal Period");
    //         JO.Add('appraisalInterval', Format(objecitves."Appraisal Interval"));
    //         jo.Add('jobPosition', objecitves."Job Position");
    //         jo.Add('jobPositionName', objecitves."Job Position Name");
    //         jo.Add('markAsDone', objecitves."Mark as Done");
    //         jo.Add('evaluationPeriodEndDate', objecitves."Evaluation Period End Date");
    //         jo.add('evaluationPeriodStartDate', objecitves."Evaluation Period Start Date");
    //         jo.add('noOfLines', objecitves."No of Lines");

    //         objeciveLines.Reset();
    //         objeciveLines.SetRange("Header No", objecitves."Header No");
    //         if objeciveLines.find('-') then begin
    //             repeat
    //                 Clear(joLines);
    //                 joLines.add('no', objeciveLines."No.");
    //                 joLines.add('lineNo', objeciveLines."Line No");
    //                 joLines.add('headerNo', objeciveLines."Header No");
    //                 joLines.Add('description', objeciveLines."Description/Job Specifications");
    //                 jaLines.add(joLines);

    //             until objeciveLines.Next() = 0;

    //         end;



    //         jo.Add('lines', jaLines);
    //         // JA.Add(JO);

    //         // until objecitves.Next() = 0;
    //     end;


    //     exit(Format(jo));



    // end;


    // procedure InsertObjective(args: Text): Text
    // var
    //     objecitves: record "Supervisor Job Specification";
    //     objeciveLines: record "Job Specification Lines";
    // begin
    //     if args <> '' then begin
    //         lJObject := lJObject.Parse(Format(args));
    //         objecitves.Init();

    //         Evaluate(objecitves."Appraisal Interval", Format(lJObject.GetValue('appraisalInterval')));

    //         if Format(lJObject.SelectToken('lines')) <> '' then begin
    //             lJsonArray := lJsonArray.Parse(Format(lJObject.SelectToken('lines')));
    //             Clear(lJObject);
    //             foreach lJObject in lJsonArray do begin
    //                 objeciveLines.Init();
    //                 objeciveLines."Header No" := Format(lJObject.GetValue('headerNo'));
    //                 Evaluate(objeciveLines."No.", Format(lJObject.GetValue('no')));
    //                 objeciveLines."Description/Job Specifications" := Format(lJObject.GetValue('description'));
    //                 objeciveLines.Insert();
    //             end;
    //         end;
    //         objecitves."Appraisal Period" := Format(lJObject.GetValue('appraisalPeriod'));
    //         objecitves.Insert(true);
    //         // objecitves.Validate("Appraisal Period");
    //         objecitves."Job Position" := Format(lJObject.GetValue('jobPosition'));
    //         objecitves.Validate("Job Position");
    //         objecitves.Modify(true);




    //     end;
    //     exit(GetSupervisorObjective(objecitves."Header No"));

    // end;

    // procedure ModifyObjective(args: Text): Text
    // var
    //     objecitves: record "Supervisor Job Specification";
    //     objeciveLines: record "Job Specification Lines";
    // begin
    //     if args <> '' then begin
    //         lJObject := lJObject.Parse(Format(args));
    //         if objecitves.Get(Format(lJObject.GetValue('headerNo'))) then begin
    //             objecitves."Appraisal Period" := Format(lJObject.GetValue('appraisalPeriod'));
    //             Evaluate(objecitves."Appraisal Interval", Format(lJObject.GetValue('appraisalInterval')));


    //             lJsonArray := lJsonArray.Parse(Format(lJObject.SelectToken('lines')));
    //             Clear(lJObject2);
    //             foreach lJObject2 in lJsonArray do begin
    //                 Evaluate(objeciveLines."Line No", Format(lJObject2.GetValue('lineNo')));
    //                 if not objeciveLines.get(objeciveLines."Line No", Format(lJObject2.GetValue('headerNo'))) then begin
    //                     objeciveLines.Init();
    //                     objeciveLines."Header No" := Format(lJObject2.GetValue('headerNo'));
    //                     Evaluate(objeciveLines."No.", Format(lJObject2.GetValue('no')));
    //                     objeciveLines."Description/Job Specifications" := Format(lJObject2.GetValue('description'));
    //                     objeciveLines.Insert(true);
    //                 end else begin
    //                     Evaluate(objeciveLines."No.", Format(lJObject2.GetValue('no')));
    //                     objeciveLines."Description/Job Specifications" := Format(lJObject2.GetValue('description'));
    //                     objeciveLines.Modify(true);
    //                 end;
    //             end;


    //             objecitves.Validate("Appraisal Period");
    //             objecitves."Job Position" := Format(lJObject.GetValue('jobPosition'));
    //             objecitves.Validate("Job Position");
    //             objecitves.Modify(true);

    //         end;

    //     end;
    //     exit(GetSupervisorObjective(objecitves."Header No"));
    // end;

    //End supervisor objectives

    //Evaluations 


    procedure GetEvaluations(args: Text): Text
    var
        appraisalHeader: record "HR Appraisal Header";
        appraisalLines: record "Appraissal Lines WP";
        projectworkload: Record "Projects Work Load";
        AnnualReview: Record 50019;
        KeyCompetencies: Record 50022;
        PersonalDevelopment: Record 50124;
        OveralComments: Record 50103;
        Assesment: Record Assessment;
        jsonObjAppHeader: JsonObject;
        jsonArrApHeader: JsonArray;

        jsonObjApplines: JsonObject;
        jsonArrAppLines: JsonArray;

        jsonObjJobSpecs: JsonObject;
        jsonArrJobSpecifs: JsonArray;

        jsonObjannualreview: JsonObject;
        jsonArrannualreview: JsonArray;
        jsonObjCompetencies: JsonObject;
        jsonArrCompetencies: JsonArray;
        jsonObjdevelopments: JsonObject;
        jsonArrdevelopments: JsonArray;
        jsonObjComments: JsonObject;
        jsonArrComments: JsonArray;

    begin
        if args <> '' then begin
            lJObject := lJObject.Parse(args);
            appraisalHeader.reset;

            if Format(lJObject.GetValue('supervisorNo')) <> '' then
                appraisalHeader.SetRange("Supervisor No.", Format(lJObject.GetValue('supervisorNo')));
            if Format(lJObject.GetValue('employeeNo')) <> '' then
                appraisalHeader.SetRange("Employee No.", Format(lJObject.GetValue('employeeNo')));
            if Format(lJObject.GetValue('Hr')) <> '' then
                appraisalHeader.SetRange(HR, Format(lJObject.GetValue('Hr')));
            if Format(lJObject.GetValue('jobId')) <> '' then
                appraisalHeader.SetRange("Job Title", Format(lJObject.GetValue('jobId')));
            if appraisalHeader.find('-') then begin
                repeat
                    Clear(jsonObjAppHeader);
                    jsonObjAppHeader.add('no', appraisalHeader."No.");
                    jsonObjAppHeader.add('appraisalPeriod', appraisalHeader."Appraisal Period");
                    jsonObjAppHeader.add('appraisalInterval', Format(appraisalHeader."Appraisal Stage"));
                    jsonObjAppHeader.add('appraisalStatus', Format(appraisalHeader."Appraisal Status"));
                    jsonObjAppHeader.add('userId', appraisalHeader."User ID");
                    jsonObjAppHeader.add('jobPosition', appraisalHeader."Job Title");
                    jsonObjAppHeader.Add('jobPositionName', appraisalHeader."Job Title");
                    jsonObjAppHeader.add('employeeNo', appraisalHeader."Employee No.");
                    jsonObjAppHeader.add('employeeName', appraisalHeader."Employee Name");
                    jsonObjAppHeader.add('supervisorNo', appraisalHeader."Supervisor No.");
                    jsonObjAppHeader.add('supervisorName', appraisalHeader."Supervisor Name");

                    jsonObjAppHeader.add('supervisorRemarks', appraisalHeader."Comments Appraiser");
                    jsonObjAppHeader.add('supervisorTargetRemarks', appraisalHeader."Supervisor Target Comments");
                    jsonObjAppHeader.add('HRTargetRemarks', appraisalHeader."HR Target Comments");

                    jsonObjAppHeader.add('HrAnnualRemarks', appraisalHeader."HR Annual Comments");
                    jsonObjAppHeader.add('supervisorApproved', appraisalHeader."Supervisor Target Approved");
                    jsonObjAppHeader.add('supervisorRejected', appraisalHeader."Supervisor Target Rejected");
                    jsonObjAppHeader.add('HrApproved', appraisalHeader."HR Target Approved");
                    jsonObjAppHeader.add('HrRejected', appraisalHeader."Hr Target Rejected");
                    jsonObjAppHeader.add('supervisorMidApproved', appraisalHeader."Supervisor MID Approved");
                    jsonObjAppHeader.add('supervisorMidRejected', appraisalHeader."Supervisor MID Rejected");
                    jsonObjAppHeader.add('HrMidApproved', appraisalHeader."HR Mid Approved");
                    jsonObjAppHeader.add('HrMidRejected', appraisalHeader."Hr Mid Rejected");
                    jsonObjAppHeader.add('supervisorAnnualApproved', appraisalHeader."Supervisor Annual Approved");
                    jsonObjAppHeader.add('supervisorAnnualRejected', appraisalHeader."Supervisor Annual Rejected");
                    jsonObjAppHeader.add('HrAnnualApproved', appraisalHeader."HR Annual Approved");
                    jsonObjAppHeader.add('HrAnnualRejected', appraisalHeader."Hr Annual Rejected");
                    jsonObjAppHeader.add('status', appraisalHeader.Status);
                    Assesment.Reset();
                    Assesment.SetRange("Appraisal No", appraisalHeader."No.");
                    if Assesment.Find('-') then begin
                        jsonObjAppHeader.add('MidSupervisorremarks', Assesment."Appraiser’s assessment");
                        jsonObjAppHeader.add('Midremarks', Assesment."Employee’s self-assessment");
                        jsonObjAppHeader.add('HrMidRemarks', Assesment."Line Manager Comments");
                    end;
                    projectworkload.reset;
                    projectworkload.SetRange("Header No", appraisalHeader."No.");
                    if projectworkload.Find('-') then begin
                        repeat
                            Clear(jsonObjJobSpecs);
                            jsonObjJobSpecs.add('appraisalNo', projectworkload."Header No");
                            jsonObjJobSpecs.add('projectcode', projectworkload."Project Code");
                            jsonObjJobSpecs.Add('projectname', projectworkload."Project Name");
                            jsonObjJobSpecs.add('weight', projectworkload.Weight);
                            // jsonObjJobSpecs.add('lineNo', projectworkload."Line No");


                            jsonArrJobSpecifs.Add(jsonObjJobSpecs);

                        until projectworkload.Next() = 0;
                    end;
                    appraisalLines.Reset();
                    appraisalLines.SetRange(appraisalLines."Header No", appraisalHeader."No.");
                    if appraisalLines.find('-') then begin

                        repeat
                            Clear(jsonobjAppLines);
                            //Section 2
                            jsonobjAppLines.Add('keyPerformanceIndicators', appraisalLines."Key Performance Indicator");
                            jsonobjAppLines.Add('performanceGoalsAndTargets', appraisalLines."Agreed Performance Targets");
                            jsonobjAppLines.add('objectives', appraisalLines.Objectives);
                            jsonobjAppLines.add('projectcode', appraisalLines."Project Code");
                            jsonobjAppLines.add('selfRating', appraisalLines."Self Assesment Score");
                            jsonobjAppLines.add('employeeComments', appraisalLines."Appraisee Comments");
                            jsonobjAppLines.add('supervisorRating', appraisalLines."Supervisor-Assesment");
                            jsonobjAppLines.Add('supervisorComments', appraisalLines."Supervisors Comments");
                            jsonArrAppLines.Add(jsonobjAppLines);




                        until appraisalLines.Next() = 0;
                    end;

                    //Anual Review
                    AnnualReview.Reset();
                    AnnualReview.SetRange(AnnualReview."Header No", appraisalHeader."No.");
                    if AnnualReview.find('-') then begin

                        repeat
                            Clear(jsonObjannualreview);
                            jsonObjannualreview.Add('KPI', AnnualReview."Key Performance Indicator");
                            jsonObjannualreview.Add('AgreedTarget', AnnualReview."Agreed Performance Targets");
                            jsonObjannualreview.add('acheivements', AnnualReview."Actual Achievement");
                            jsonObjannualreview.add('appraiseerating', AnnualReview."Appraisee Rating");
                            jsonObjannualreview.add('appraiserrating', AnnualReview."Appraiser Rating");
                            jsonObjannualreview.add('appraisalNo', AnnualReview."Appraisal No.");
                            jsonObjannualreview.add('lineno', AnnualReview."Line No");
                            jsonArrannualreview.Add(jsonObjannualreview);
                        until AnnualReview.Next() = 0;
                    end;
                    //KeyComptencies                   
                    KeyCompetencies.Reset();
                    KeyCompetencies.SetRange(KeyCompetencies."Appraisal No", appraisalHeader."No.");
                    if KeyCompetencies.find('-') then begin

                        repeat
                            Clear(jsonObjCompetencies);
                            jsonObjCompetencies.Add('Value', KeyCompetencies.Value);
                            jsonObjCompetencies.Add('improvement', KeyCompetencies."Improvement Require");
                            jsonObjCompetencies.add('good', KeyCompetencies.Good);
                            jsonObjCompetencies.add('average', KeyCompetencies.Average);
                            jsonObjCompetencies.add('excellent', KeyCompetencies.Excellent);
                            jsonObjCompetencies.add('comments', KeyCompetencies.Comments);
                            jsonObjCompetencies.add('appraisalNo', KeyCompetencies."Appraisal No");
                            jsonArrCompetencies.Add(jsonObjCompetencies);
                        until KeyCompetencies.Next() = 0;
                    end;
                    //Personal Development
                    PersonalDevelopment.Reset();
                    PersonalDevelopment.SetRange(PersonalDevelopment."Appraisal No.", appraisalHeader."No.");
                    if PersonalDevelopment.find('-') then begin
                        repeat
                            Clear(jsonObjdevelopments);
                            jsonObjdevelopments.Add('areas', PersonalDevelopment."Areas to develop");
                            jsonObjdevelopments.Add('developmentactivities', PersonalDevelopment."Development activities");
                            jsonObjdevelopments.add('resourcesrequired', PersonalDevelopment."Resources required");
                            jsonObjdevelopments.add('targetstimelines', PersonalDevelopment."Targets and Timelines");
                            jsonObjdevelopments.add('appraisalNo', PersonalDevelopment."Appraisal No.");
                            jsonArrdevelopments.Add(jsonObjdevelopments);
                        until PersonalDevelopment.Next() = 0;
                    end;
                    //Annual Comments
                    OveralComments.Reset();
                    OveralComments.SetRange(OveralComments."Appraisal No", appraisalHeader."No.");
                    OveralComments.SetRange("Appraisal Stage", OveralComments."Appraisal Stage"::"End Year Evaluation");
                    if OveralComments.find('-') then begin
                        repeat
                            Clear(jsonObjComments);
                            jsonObjComments.Add('employeecomments', OveralComments."Employee Comments");
                            jsonObjComments.Add('apparaisercomments', OveralComments."Appraiser’s assessment");
                            jsonObjComments.add('hrcomments', OveralComments."Line Manager Comments");
                            jsonObjComments.add('appraisalNo', OveralComments."Appraisal No");
                            jsonObjComments.add('lineno', OveralComments."Line No");
                            jsonArrComments.Add(jsonObjComments);
                        until OveralComments.Next() = 0;
                    end;
                    jsonObjAppHeader.Add('lines', jsonArrAppLines);
                    jsonObjAppHeader.add('jobSpecific', jsonArrJobSpecifs);
                    jsonObjAppHeader.add('Annualreview', jsonArrannualreview);
                    jsonObjAppHeader.add('Competencies', jsonArrCompetencies);
                    jsonObjAppHeader.add('PersonalDevelopment', jsonArrdevelopments);
                    jsonObjAppHeader.add('OverallComments', jsonArrComments);
                    jsonArrApHeader.add(jsonObjAppHeader);

                until appraisalHeader.Next() = 0;
            end;
        end;
        exit(Format(jsonArrApHeader));
    end;



    procedure GetEvaluation(appraisalNo: code[50]): Text
    var
        appraisalHeader: record "HR Appraisal Header";
        appraisalLines: record "Appraissal Lines WP";
        projectworkload: Record "Projects Work Load";
        ResourcesRequired: Record "Resources Required ";
        Assesment: Record Assessment;
        AnnualReview: Record 50019;
        KeyCompetencies: Record 50022;
        PersonalDevelopment: Record 50124;
        OveralComments: Record 50103;

        jsonObjAppHeader: JsonObject;
        jsonArrApHeader: JsonArray;

        jsonObjApplines: JsonObject;
        jsonArrAppLines: JsonArray;

        jsonObjProjectWk: JsonObject;
        jsonArrProjectWk: JsonArray;

        jsonObjresourcesrequired: JsonObject;
        jsonArrresourcesrequired: JsonArray;

        jsonObjannualreview: JsonObject;
        jsonArrannualreview: JsonArray;
        jsonObjCompetencies: JsonObject;
        jsonArrCompetencies: JsonArray;
        jsonObjdevelopments: JsonObject;
        jsonArrdevelopments: JsonArray;
        jsonObjComments: JsonObject;
        jsonArrComments: JsonArray;
    begin
        if appraisalNo <> '' then begin


            if appraisalHeader.get(appraisalNo) then begin

                jsonObjAppHeader.add('no', appraisalHeader."No.");
                jsonObjAppHeader.add('appraisalPeriod', appraisalHeader."Appraisal Period");
                jsonObjAppHeader.add('appraisalInterval', Format(appraisalHeader."Appraisal Stage"));
                jsonObjAppHeader.add('appraisalStatus', appraisalHeader."Appraisal Status");
                jsonObjAppHeader.add('userId', appraisalHeader."User ID");
                jsonObjAppHeader.add('jobPosition', appraisalHeader."Job Title");
                jsonObjAppHeader.Add('jobPositionName', appraisalHeader."Job Title");
                jsonObjAppHeader.add('employeeNo', appraisalHeader."Employee No.");
                jsonObjAppHeader.add('employeeName', appraisalHeader."Employee Name");
                jsonObjAppHeader.add('supervisorNo', appraisalHeader."Supervisor No.");
                jsonObjAppHeader.add('supervisorName', appraisalHeader."Supervisor Name");

                jsonObjAppHeader.add('supervisorRemarks', appraisalHeader."Comments Appraiser");
                jsonObjAppHeader.add('supervisorTargetRemarks', appraisalHeader."Supervisor Target Comments");
                jsonObjAppHeader.add('HRTargetRemarks', appraisalHeader."HR Target Comments");

                jsonObjAppHeader.add('HrAnnualRemarks', appraisalHeader."HR Annual Comments");
                jsonObjAppHeader.add('supervisorApproved', appraisalHeader."Supervisor Target Approved");
                jsonObjAppHeader.add('supervisorRejected', appraisalHeader."Supervisor Target Rejected");
                jsonObjAppHeader.add('HrApproved', appraisalHeader."HR Target Approved");
                jsonObjAppHeader.add('HrRejected', appraisalHeader."Hr Target Rejected");
                jsonObjAppHeader.add('supervisorMidApproved', appraisalHeader."Supervisor MID Approved");
                jsonObjAppHeader.add('supervisorMidRejected', appraisalHeader."Supervisor MID Rejected");
                jsonObjAppHeader.add('HrMidApproved', appraisalHeader."HR Mid Approved");
                jsonObjAppHeader.add('HrMidRejected', appraisalHeader."Hr Mid Rejected");
                jsonObjAppHeader.add('supervisorAnnualApproved', appraisalHeader."Supervisor Annual Approved");
                jsonObjAppHeader.add('supervisorAnnualRejected', appraisalHeader."Supervisor Annual Rejected");
                jsonObjAppHeader.add('HrAnnualApproved', appraisalHeader."HR Annual Approved");
                jsonObjAppHeader.add('HrAnnualRejected', appraisalHeader."Hr Annual Rejected");
                jsonObjAppHeader.add('status', appraisalHeader.Status);
                Assesment.Reset();
                Assesment.SetRange("Appraisal No", appraisalHeader."No.");
                if Assesment.Find('-') then begin
                    jsonObjAppHeader.add('MidSupervisorremarks', Assesment."Appraiser’s assessment");
                    jsonObjAppHeader.add('Midremarks', Assesment."Employee’s self-assessment");
                    jsonObjAppHeader.add('HrMidRemarks', Assesment."Line Manager Comments");
                end;
                projectworkload.reset;
                projectworkload.SetRange(projectworkload."Header No", appraisalHeader."No.");
                if projectworkload.Find('-') then begin
                    repeat
                        Clear(jsonObjProjectWk);
                        jsonObjProjectWk.add('appraisalNo', projectworkload."Header No");
                        jsonObjProjectWk.add('projectcode', projectworkload."Project Code");
                        jsonObjProjectWk.Add('projectname', projectworkload."Project Name");
                        jsonObjProjectWk.add('weight', projectworkload.Weight);
                        jsonObjProjectWk.add('lineNo', projectworkload."Line No");

                        jsonArrProjectWk.Add(jsonObjProjectWk);

                    until projectworkload.Next() = 0;
                end;
                appraisalLines.Reset();
                appraisalLines.SetRange(appraisalLines."Header No", appraisalHeader."No.");
                if appraisalLines.find('-') then begin

                    repeat
                        Clear(jsonObjApplines);
                        //Section 2
                        jsonobjAppLines.Add('keyPerformanceIndicators', appraisalLines."Key Performance Indicator");
                        jsonobjAppLines.Add('performanceGoalsAndTargets', appraisalLines."Agreed Performance Targets");
                        jsonobjAppLines.add('objectives', appraisalLines.Objectives);
                        jsonobjAppLines.add('projectcode', appraisalLines."Project Code");
                        jsonobjAppLines.add('selfRating', appraisalLines."Self Assesment Score");
                        jsonobjAppLines.add('employeeComments', appraisalLines."Appraisee Comments");
                        jsonobjAppLines.add('supervisorRating', appraisalLines."Supervisor-Assesment");
                        jsonobjAppLines.Add('supervisorComments', appraisalLines."Supervisors Comments");
                        jsonobjAppLines.add('lineNo', appraisalLines."Line No");
                        jsonArrAppLines.Add(jsonobjAppLines);




                    until appraisalLines.Next() = 0;
                end;
                ResourcesRequired.Reset();
                ResourcesRequired.SetRange(ResourcesRequired."Header No", appraisalHeader."No.");
                if ResourcesRequired.find('-') then begin

                    repeat
                        Clear(jsonObjresourcesrequired);
                        //Section 2
                        jsonObjresourcesrequired.Add('Intervention', ResourcesRequired.Intervention);
                        jsonObjresourcesrequired.Add('Resources', ResourcesRequired."Resources Required");
                        jsonObjresourcesrequired.add('Targets', ResourcesRequired."Targets and timelines");
                        jsonObjresourcesrequired.add('Person', ResourcesRequired."Person Responsible");
                        jsonObjresourcesrequired.add('lineNo', ResourcesRequired."Line No");
                        jsonArrresourcesrequired.Add(jsonObjresourcesrequired);
                    until ResourcesRequired.Next() = 0;
                end;
                //Anual Review
                AnnualReview.Reset();
                AnnualReview.SetRange(AnnualReview."Header No", appraisalHeader."No.");
                if AnnualReview.find('-') then begin

                    repeat
                        Clear(jsonObjannualreview);
                        jsonObjannualreview.Add('KPI', AnnualReview."Key Performance Indicator");
                        jsonObjannualreview.Add('AgreedTarget', AnnualReview."Agreed Performance Targets");
                        jsonObjannualreview.add('acheivements', AnnualReview."Actual Achievement");
                        jsonObjannualreview.add('appraiseerating', AnnualReview."Appraisee Rating");
                        jsonObjannualreview.add('appraiserrating', AnnualReview."Appraiser Rating");
                        jsonObjannualreview.add('appraisalNo', AnnualReview."Appraisal No.");
                        jsonObjannualreview.add('lineno', AnnualReview."Line No");
                        jsonArrannualreview.Add(jsonObjannualreview);
                    until AnnualReview.Next() = 0;
                end;
                //KeyComptencies                   
                KeyCompetencies.Reset();
                KeyCompetencies.SetRange(KeyCompetencies."Appraisal No", appraisalHeader."No.");
                if KeyCompetencies.find('-') then begin

                    repeat
                        Clear(jsonObjCompetencies);
                        jsonObjCompetencies.Add('Value', KeyCompetencies.Value);
                        jsonObjCompetencies.Add('improvement', KeyCompetencies."Improvement Require");
                        jsonObjCompetencies.add('good', KeyCompetencies.Good);
                        jsonObjCompetencies.add('average', KeyCompetencies.Average);
                        jsonObjCompetencies.add('excellent', KeyCompetencies.Excellent);
                        jsonObjCompetencies.add('comments', KeyCompetencies.Comments);
                        jsonObjCompetencies.add('appraisalNo', KeyCompetencies."Appraisal No");
                        jsonArrCompetencies.Add(jsonObjCompetencies);
                    until KeyCompetencies.Next() = 0;
                end;
                //Personal Development
                PersonalDevelopment.Reset();
                PersonalDevelopment.SetRange(PersonalDevelopment."Appraisal No.", appraisalHeader."No.");
                if PersonalDevelopment.find('-') then begin
                    repeat
                        Clear(jsonObjdevelopments);
                        jsonObjdevelopments.Add('areas', PersonalDevelopment."Areas to develop");
                        jsonObjdevelopments.Add('developmentactivities', PersonalDevelopment."Development activities");
                        jsonObjdevelopments.add('resourcesrequired', PersonalDevelopment."Resources required");
                        jsonObjdevelopments.add('targetstimelines', PersonalDevelopment."Targets and Timelines");
                        jsonObjdevelopments.add('appraisalNo', PersonalDevelopment."Appraisal No.");
                        jsonArrdevelopments.Add(jsonObjdevelopments);
                    until PersonalDevelopment.Next() = 0;
                end;
                //Annual Comments
                OveralComments.Reset();
                OveralComments.SetRange(OveralComments."Appraisal No", appraisalHeader."No.");
                OveralComments.SetRange("Appraisal Stage", OveralComments."Appraisal Stage"::"End Year Evaluation");
                if OveralComments.find('-') then begin
                    repeat
                        Clear(jsonObjComments);
                        jsonObjComments.Add('employeecomments', OveralComments."Employee Comments");
                        jsonObjComments.Add('apparaisercomments', OveralComments."Appraiser’s assessment");
                        jsonObjComments.add('hrcomments', OveralComments."Line Manager Comments");
                        jsonObjComments.add('appraisalNo', OveralComments."Appraisal No");
                        jsonObjComments.add('lineno', OveralComments."Line No");
                        jsonArrComments.Add(jsonObjComments);
                    until OveralComments.Next() = 0;
                end;
                jsonObjAppHeader.Add('lines', jsonArrAppLines);
                jsonObjAppHeader.add('jobSpecific', jsonArrProjectWk);
                jsonObjAppHeader.add('resources', jsonArrresourcesrequired);
                jsonObjAppHeader.add('Annualreview', jsonArrannualreview);
                jsonObjAppHeader.add('Competencies', jsonArrCompetencies);
                jsonObjAppHeader.add('PersonalDevelopment', jsonArrdevelopments);
                jsonObjAppHeader.add('OverallComments', jsonArrComments);

                // jsonObjAppHeader.Add('lines', jsonArrAppLines);
                // jsonObjAppHeader.add('jobSpecific', jsonArrProjectWk);
                // jsonObjAppHeader.add('resources', jsonArrresourcesrequired);



            end;
        end;
        exit(Format(jsonObjAppHeader));
    end;

    procedure InsertEvaluations(args: Text): Text
    var
        hremployees: Record "HR Employees";
        appraisalHeader: record "HR Appraisal Header";
        appraisalLines: record "HR Appraisal Lines";
        Hremp: Record "HR Employees";
        Hremps: Record "HR Employees";
        Supervisor: Code[250];
        PerformanceSetup: Record "PMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if args <> '' then begin
            lJObject := lJObject.Parse(args);

            hremployees.reset;
            hremployees.SetRange("No.", Format(lJObject.GetValue('employeeNo')));
            if hremployees.FindFirst() then begin
                appraisalHeader.Init();
                appraisalHeader."Appraisal Period" := Format(lJObject.GetValue('appraisalPeriod'));
                Evaluate(appraisalHeader."Appraisal Stage", Format((lJObject.GetValue('appraisalInterval'))));
                appraisalHeader."User ID" := hremployees."User ID";
                // appraisalHeader."Employee Name" := hremployees.FullName;
                appraisalHeader."Job Title" := hremployees."Job Title";

                AppraisalHeader.Reset();
                AppraisalHeader.SetRange(AppraisalHeader."Employee No.", Format(lJObject.GetValue('employeeNo')));
                AppraisalHeader.SetRange(AppraisalHeader."Appraisal Status", 0);
                if AppraisalHeader.FindSet() then begin
                    if AppraisalHeader.Count > 2 then begin
                        Error('You have another target setting that is open kindly use that %1', AppraisalHeader."No.");
                    end;

                end;
                PerformanceSetup.Get();
                appraisalHeader."No." := NoSeriesMgt.GetNextNo(PerformanceSetup."Performance Numbers", Today, true);
                appraisalHeader.Insert(true);
                appraisalHeader.Validate("User ID");
                appraisalHeader."Employee No." := Format(lJObject.GetValue('employeeNo'));
                appraisalHeader.Validate("Employee No.");
                appraisalHeader.Validate("Appraisal Period");
                appraisalHeader.Validate("Appraisal Stage");
                Hremp.Reset();
                Hremp.SetRange("Employee UserID", hremployees."Supervisor ID");
                if Hremp.Find('-') then begin
                    appraisalHeader."Supervisor No." := Hremp."No.";
                    //appraisalHeader.Validate("Supervisor No.");
                    appraisalHeader."Supervisor User ID" := Hremp."Employee UserID";
                    appraisalHeader."Supervisor Name" := Hremp."First Name" + ' ' + Hremp."Middle Name" + ' ' + Hremp."Last Name";

                end;
                Hremps.Reset();
                Hremps.SetRange("Employee UserID", hremployees."HR Manager");
                if Hremps.Find('-') then begin
                    appraisalHeader.HR := Hremps."No.";
                end;

                appraisalHeader."Supervisor Target Approved" := false;
                appraisalHeader."HR Target Approved" := false;
                appraisalHeader."Supervisor MID Approved" := false;
                appraisalHeader."HR MID Approved" := false;
                appraisalHeader."Supervisor Target Comments" := '';
                appraisalHeader."HR Target Comments" := '';
                appraisalHeader."HR Mid Comments" := '';
                appraisalHeader.Modify(true);
            end;
            //Add lines






        end;

        exit(GetEvaluation(appraisalHeader."No."));
    end;

    procedure SENDEMAILApproval(email: text; message: Text): Boolean;
    var
        smtp: Codeunit Email;
        smtpsetup: Codeunit "Email Message";
    begin

        smtpsetup.Create(email, 'AFIDEP Appraisal Approval', message, true);
        smtp.Send(smtpsetup);

        exit(true);
    end;

    procedure ModifyEvaluations(args: Text): Text

    var
        appraisalheader: Record "HR Appraisal Header";
        appraisalLines: Record "Appraissal Lines WP";
        ProjectWorkload: Record "Projects Work Load";
        Resources: Record "Resources Required ";
        lno: Integer;
        StaffMail: Text[150];
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        VarMemberEmail: Text;
        VarMailSubject: Text;
        VarMailBody: Text;
        HREmp: Record "HR Employees";
        HREmps: Record "HR Employees";
        Dimensions: record "Dimension Value";
        Assessment: Record Assessment;
        AnnualReview: Record 50019;
        KeyCompetencies: Record 50022;
        PersonalDevelopment: Record 50124;
        OveralComments: Record 50103;
        isImprovement: Boolean;
        jTokenValue: DotNet JToken;
        Message: text;
        MessageFormatterd: Text;
    begin
        if args <> '' then begin
            lJObject := lJObject.Parse(args);
            appraisalheader.get(Format(lJObject.GetValue('no')));
            Hremp.Reset();
            Hremp.SetRange("No.", appraisalHeader."Employee No.");
            if Hremp.Find('-') then begin
                appraisalheader.Validate("Employee No.");
                appraisalHeader."Employee Name" := Hremp."First Name" + ' ' + Hremp."Middle Name" + ' ' + Hremp."Last Name";
                Hremps.Reset();
                Hremps.SetRange("Employee UserID", Hremp."Supervisor ID");
                if HREmps.Find('-') then begin
                    appraisalHeader."Supervisor No." := HREmps."No.";

                    // appraisalHeader.Validate("Supervisor No.");
                    appraisalHeader."Supervisor User ID" := HREmps."Employee UserID";
                    appraisalHeader."Supervisor Name" := Hremps."First Name" + ' ' + HREmps."Middle Name" + ' ' + HREmps."Last Name";
                end;

            end;
            Hremps.Reset();
            Hremps.SetRange("Employee UserID", Hremp."HR Manager");
            if Hremps.Find('-') then begin
                appraisalHeader.HR := Hremps."No.";
            end;

            appraisalHeader.Modify(true);

            Evaluate(appraisalheader."Appraisal Stage", Format(lJObject.GetValue('appraisalInterval')));
            if format(lJObject.GetValue('appraisalStatus')) <> '' then begin
                if format(lJObject.GetValue('appraisalStatus')) = '2' then begin
                    // Change status
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Target Approval";
                    appraisalheader.Modify(true);
                    //Send Email

                    Message := 'Approval for Target Setting Appraisal of %1 (No. %2) requires your attention. Kindly ' +
                                                       '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Supervisor No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;




                end;

            end;

            if format(lJObject.GetValue('appraisalStatus')) <> '' then begin
                if format(lJObject.GetValue('appraisalStatus')) = '1' then
                    // Evaluate(appraisalheader."Appraisal Status", Format(lJObject.GetValue('appraisalStatus')));
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Appraisee;
                appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Target Setting";
                appraisalheader.Modify(true);
                //  Message := 'Approval for Target Setting Appraisal of %1 (No. %2) has been rejected. Kindly ' +
                //                                        '<a href="https://bc.afidep.org:8090/">click here</a> to view.';
                //     MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                //        HREmp.Reset();
                //     HREmp.SetRange("No.", appraisalheader."Employee No.");
                //     if HREmp.FindFirst() then begin
                //        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                //     end;  

            end;
            if format(lJObject.GetValue('appraisalStatus')) <> '' then begin
                if format(lJObject.GetValue('appraisalStatus')) = '8' then
                    // Evaluate(appraisalheader."Appraisal Status", Format(lJObject.GetValue('appraisalStatus')));
                appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Mid Year Review";
                appraisalheader.Modify(true);
                Message := 'Approval for Mid Year Appraisal of %1 (No. %2) requires your attention. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                HREmp.Reset();
                HREmp.SetRange("No.", appraisalheader."Supervisor No.");
                if HREmp.FindFirst() then begin
                    SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                end;

            end;

            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '3' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Target Setting";
                    appraisalheader."Supervisor Target Approved" := true;
                    appraisalheader.Modify(true);
                    Message := 'Approval for Target Setting  Appraisal of %1 (No. %2) has been approved  by supervisor. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to view.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;

                    Message := 'Approval for Target Setting  Appraisal of %1 (No. %2) requires your attention. Kindly ' +
                                                     '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader.HR);
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                    Commit();
                end;
            end;

            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '4' then begin
                    appraisalheader.Status := appraisalheader.Status::Closed;
                    appraisalheader.Appraised := true;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Appraisal Completed";
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for Appraisal of %1 (No. %2) has been fully approved. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to view.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '5' then begin
                    appraisalheader."Supervisor Target Rejected" := true;
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Appraisee;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Target Setting";
                    appraisalheader.Modify(true);
                    Commit();

                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '6' then begin
                    appraisalheader."HR Target Approved" := true;
                    appraisalheader."Goal Setting (31 Jan)" := Today;
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Target Approval";
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for Target Setting Appraisal of %1 (No. %2) has been approved by HR. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to view.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '7' then begin
                    appraisalheader."Hr Target Rejected" := true;
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Appraisee;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Target Setting";
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for Target Setting Appraisal of %1 (No. %2) has been rejected by HR. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to view.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '8' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Mid Year Review";
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for MID Year Appraisal of %1 (No. %2) requires your attention. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Supervisor No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '9' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Mid Year Review";
                    appraisalheader."Supervisor MID Approved" := true;
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for MID Year Appraisal of %1 (No. %2) has been approved by supervisor. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to view.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '20' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"End Year Evaluation";
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for End Year  Appraisal of %1 (No. %2) requires your attention. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Supervisor No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '10' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Appraisee;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Mid Year Review";
                    appraisalheader."Supervisor MID Rejected" := true;
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for MID Year Appraisal of %1 (No. %2) has been rejected by Supervisor. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to View.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '11' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Appraisee;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"End Year Evaluation";
                    appraisalheader."HR Mid Approved" := true;
                    appraisalheader."Mid Term Review (31 Jul)" := Today;
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for MID Year Appraisal of %1 (No. %2) has been approved by HR. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '12' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Appraisee;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Mid Year Review";
                    appraisalheader."Hr Mid Rejected" := true;
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for Appraisal of %1 (No. %2) has been rejected by HR. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to View.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '13' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"End Year Evaluation";
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for END Year  Appraisal of %1 (No. %2) requires your attention. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Supervisor No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '14' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"End Year Evaluation";
                    appraisalheader."Supervisor Annual Approved" := true;
                    appraisalheader."Annual Review (31 Dec)" := Today;
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for End Year Appraisal of %1 (No. %2) has been approved by Supervisor. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to view.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '15' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Appraisee;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"End Year Evaluation";
                    appraisalheader."Supervisor Annual Rejected" := true;
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for End Year Appraisal of %1 (No. %2) has been rejected by Supervisor. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to view.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '16' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Appraisal Completed";
                    appraisalheader."HR Annual Approved" := true;
                    appraisalheader.Appraised := true;
                    appraisalheader."Annual Review (31 Dec)" := Today;

                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for End Year Appraisal of %1 (No. %2) has been approved by HR. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to View.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '17' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Appraisee;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"End Year Evaluation";
                    appraisalheader."Hr Annual Rejected" := true;
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for End Year Appraisal of %1 (No. %2) has been rejected by HR. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to View.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Employee No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('status')) <> '' then begin
                if format(lJObject.GetValue('status')) = '18' then begin
                    appraisalheader."Appraisal Status" := appraisalheader."Appraisal Status"::Supervisor;
                    appraisalheader."Appraisal Stage" := appraisalheader."Appraisal Stage"::"Target Approval";
                    appraisalheader.Modify(true);
                    Commit();
                    Message := 'Approval for Appraisal of %1 (No. %2) requires your attention. Kindly ' +
                                                      '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                    MessageFormatterd := StrSubstNo(Message, appraisalheader."Employee Name", appraisalheader."No.");
                    HREmp.Reset();
                    HREmp.SetRange("No.", appraisalheader."Supervisor No.");
                    if HREmp.FindFirst() then begin
                        SENDEMAILApproval(HREmp."Company E-Mail", MessageFormatterd)
                    end;
                end;
            end;
            if format(lJObject.GetValue('remarks')) <> '' then begin
                appraisalheader."Comments Appraisee" := Format(lJObject.GetValue('remarks'));
                appraisalheader.Modify(true);
                Commit();
            end;
            if format(lJObject.GetValue('supervisorRemarks')) <> '' then begin
                appraisalheader."Comments Appraiser" := Format(lJObject.GetValue('supervisorRemarks'));
                appraisalheader.Modify(true);
                Commit();
            end;
            if format(lJObject.GetValue('supervisorTargetRemarks')) <> '' then begin
                appraisalheader."Supervisor Target Comments" := Format(lJObject.GetValue('supervisorTargetRemarks'));
                appraisalheader.Modify(true);
                Commit();
            end;
            if format(lJObject.GetValue('HRTargetRemarks')) <> '' then begin
                appraisalheader."HR Target Comments" := Format(lJObject.GetValue('HRTargetRemarks'));
                appraisalheader.Modify(true);
                Commit();
            end;
            if format(lJObject.GetValue('HrMidRemarks')) <> '' then begin
                appraisalheader."HR Mid Comments" := Format(lJObject.GetValue('HrMidRemarks'));
                appraisalheader.Modify(true);
                Commit();
            end;
            if format(lJObject.GetValue('HrAnnualRemarks')) <> '' then begin
                appraisalheader."HR Annual Comments" := Format(lJObject.GetValue('HrAnnualRemarks'));
                appraisalheader.Modify(true);
                Commit();
            end;

            //Mid Year Review
            if format(lJObject.GetValue('Midremarks')) <> '' then begin
                Assessment.Reset();
                Assessment.SetRange("Appraisal No", appraisalheader."No.");
                if Assessment.Find('-') then begin
                    Assessment."Employee’s self-assessment" := Format(lJObject.GetValue('Midremarks'));
                    Assessment.Modify(true);
                    Commit();
                end else begin
                    Assessment.Init();
                    Assessment."Appraisal No" := appraisalheader."No.";
                    Assessment."Employee No" := appraisalheader."Employee No.";
                    Assessment."Appraisal Stage" := Assessment."Appraisal Stage"::"Mid Year Review";
                    Assessment."Appraisal Period" := appraisalheader."Appraisal Period";
                    Assessment."Employee’s self-assessment" := Format(lJObject.GetValue('Midremarks'));
                    Assessment.Insert();
                end;
            end;
            if format(lJObject.GetValue('MidSupervisorremarks')) <> '' then begin
                Assessment.Reset();
                Assessment.SetRange("Appraisal No", appraisalheader."No.");
                if Assessment.Find('-') then begin
                    Assessment."Appraiser’s assessment" := Format(lJObject.GetValue('MidSupervisorremarks'));
                    Assessment.Modify(true);
                    Commit();
                end;
            end;
            if format(lJObject.GetValue('HrMidRemarks')) <> '' then begin
                Assessment.Reset();
                Assessment.SetRange("Appraisal No", appraisalheader."No.");
                if Assessment.Find('-') then begin
                    Assessment."Line Manager Comments" := Format(lJObject.GetValue('HrMidRemarks'));
                    Assessment.Modify(true);
                    Commit();
                end;
            end;
            //Job specificaions
            if Format(lJObject.SelectToken('jobSpecific')) <> '' then begin
                lJsonArray := lJsonArray.Parse(Format(lJObject.SelectToken('jobSpecific')));
                Clear(lJObject2);

                foreach ljobject2 in lJsonArray do begin
                    Evaluate(ProjectWorkload."Line No", Format(ljobject2.GetValue('lineNo')));
                    if ProjectWorkload.get(
                     ProjectWorkload."Line No",
                      Format(lJObject2.GetValue('projectcode')),
                     Format(lJObject2.GetValue('appraisalNo'))
                    )
                    then begin

                        ProjectWorkload."Project Code" := Format(ljobject2.GetValue('projectcode'));
                        ProjectWorkload.Validate("Project Code");
                        Evaluate(ProjectWorkload.Weight, Format(ljobject2.GetValue('weight')));

                        Commit();

                    end
                    else begin
                        ProjectWorkload.Init();
                        ProjectWorkload."Header No" := Format(lJObject2.GetValue('appraisalNo'));
                        ProjectWorkload."Project Code" := Format(ljobject2.GetValue('projectcode'));
                        ProjectWorkload.Validate("Project Code");
                        Evaluate(ProjectWorkload.Weight, Format(ljobject2.GetValue('weight')));
                        ProjectWorkload.Insert(true);
                        Commit();

                    end;
                end;

            end;
            if Format(lJObject.SelectToken('lines')) <> '' then begin
                clear(lJsonArray);
                lJsonArray := lJsonArray.Parse(Format(lJObject.SelectToken('lines')));
                Clear(lJObject2);
                foreach ljobject2 in lJsonArray do begin

                    Evaluate(appraisalLines."Line No", Format(ljobject2.GetValue('lineNo')));

                    appraisalLines.Reset();
                    appraisalLines.SetRange("Line No", appraisalLines."Line No");
                    appraisalLines.SetRange("Header No", Format(ljobject2.GetValue('appraisalNo')));
                    if appraisalLines.Find('-') then begin
                        appraisalLines."Project Code" := Format(ljobject2.GetValue('projectcode'));
                        appraisalLines.Validate("Project Code");
                        appraisalLines.Objectives := Format(ljobject2.GetValue('objectives'));
                        appraisalLines."Key Performance Indicator" := Format(ljobject2.GetValue('keyPerformanceIndicators'));
                        appraisalLines."Agreed Performance Targets" := Format(ljobject2.GetValue('performanceGoalsAndTargets'));
                        appraisalLines.Modify(true);
                        Sleep(1);
                        Commit();

                    end else begin
                        appraisalLines.Init();
                        appraisalLines."Header No" := Format(ljobject2.GetValue('appraisalNo'));
                        appraisalLines."Project Code" := Format(ljobject2.GetValue('projectcode'));
                        appraisalLines.Validate("Project Code");
                        appraisalLines.Objectives := Format(ljobject2.GetValue('objectives'));
                        appraisalLines."Key Performance Indicator" := Format(ljobject2.GetValue('keyPerformanceIndicators'));
                        appraisalLines."Agreed Performance Targets" := Format(ljobject2.GetValue('performanceGoalsAndTargets'));
                        appraisalLines.Insert(true);
                        Commit();


                    end;
                end;
                if Format(lJObject.SelectToken('resources')) <> '' then begin
                    clear(lJsonArray);
                    lJsonArray := lJsonArray.Parse(Format(lJObject.SelectToken('resources')));
                    Clear(lJObject2);
                    foreach ljobject2 in lJsonArray do begin

                        Evaluate(Resources."Line No", Format(ljobject2.GetValue('lineNo')));

                        Resources.Reset();
                        Resources.SetRange("Line No", Resources."Line No");
                        Resources.SetRange("Header No", Format(ljobject2.GetValue('appraisalNo')));
                        if Resources.Find('-') then begin
                            Resources.Intervention := Format(ljobject2.GetValue('Intervention'));
                            Resources."Resources Required" := Format(ljobject2.GetValue('Resources'));
                            Resources."Targets and timelines" := Format(ljobject2.GetValue('Targets'));
                            Resources."Person Responsible" := Format(ljobject2.GetValue('Person'));
                            Resources.Validate("Person Responsible");
                            Resources.Modify(true);
                            Sleep(1);
                            Commit();

                        end else begin
                            Resources.Init();
                            Resources."Header No" := Format(ljobject2.GetValue('appraisalNo'));
                            Resources.Intervention := Format(ljobject2.GetValue('Intervention'));
                            Resources."Resources Required" := Format(ljobject2.GetValue('Resources'));
                            Resources."Targets and timelines" := Format(ljobject2.GetValue('Targets'));
                            Resources."Person Responsible" := Format(ljobject2.GetValue('Person'));
                            Resources.Validate("Person Responsible");
                            Resources.Insert(true);

                            Commit();


                        end;
                    end;
                end;
                //Annual Review
                if Format(lJObject.SelectToken('Annualreview')) <> '' then begin
                    clear(lJsonArray);
                    lJsonArray := lJsonArray.Parse(Format(lJObject.SelectToken('Annualreview')));
                    Clear(lJObject2);
                    foreach ljobject2 in lJsonArray do begin

                        Evaluate(AnnualReview."Line No", Format(ljobject2.GetValue('lineno')));
                        AnnualReview.Reset();
                        AnnualReview.SetRange("Line No", AnnualReview."Line No");
                        AnnualReview.SetRange("Header No", Format(ljobject2.GetValue('appraisalNo')));
                        if AnnualReview.Find('-') then begin
                            AnnualReview."Key Performance Indicator" := Format(ljobject2.GetValue('KPI'));
                            AnnualReview."Agreed Performance Targets" := Format(ljobject2.GetValue('AgreedTarget'));
                            AnnualReview."Actual Achievement" := Format(ljobject2.GetValue('acheivements'));
                            Evaluate(AnnualReview."Appraisee Rating", Format(ljobject2.GetValue('appraiseerating')));
                            Evaluate(AnnualReview."Appraiser Rating", Format(ljobject2.GetValue('appraiserrating')));
                            AnnualReview.Modify(true);
                            Sleep(1);
                            Commit();

                        end else begin
                            AnnualReview.Init();
                            AnnualReview."Header No" := Format(ljobject2.GetValue('appraisalNo'));
                            AnnualReview."Key Performance Indicator" := Format(ljobject2.GetValue('KPI'));
                            AnnualReview."Agreed Performance Targets" := Format(ljobject2.GetValue('AgreedTarget'));
                            AnnualReview."Actual Achievement" := Format(ljobject2.GetValue('acheivements'));
                            Evaluate(AnnualReview."Appraisee Rating", Format(ljobject2.GetValue('appraiseerating')));
                            Evaluate(AnnualReview."Appraiser Rating", Format(ljobject2.GetValue('appraiserrating')));
                            AnnualReview.Insert(true);
                            Commit();
                        end;
                    end;
                end;
                //Key Competencies                
                if Format(lJObject.SelectToken('Competencies')) <> '' then begin
                    clear(lJsonArray);
                    lJsonArray := lJsonArray.Parse(Format(lJObject.SelectToken('Competencies')));
                    Clear(lJObject2);
                    foreach ljobject2 in lJsonArray do begin

                        Evaluate(KeyCompetencies.Value, Format(ljobject2.GetValue('Value')));
                        KeyCompetencies.Reset();
                        KeyCompetencies.SetRange(Value, KeyCompetencies.Value);
                        KeyCompetencies.SetRange("Appraisal No", Format(ljobject2.GetValue('appraisalNo')));
                        if KeyCompetencies.Find('-') then begin
                            // jTokenValue := ljobject2.GetValue('improvement');
                            // isImprovement := jTokenValue.ToObject();
                            // KeyCompetencies."Improvement Require" := isImprovement;
                            Evaluate(KeyCompetencies."Improvement Require", Format(ljobject2.GetValue('improvement')));
                            Evaluate(KeyCompetencies.Good, Format(ljobject2.GetValue('good')));
                            Evaluate(KeyCompetencies.Average, Format(ljobject2.GetValue('average')));
                            Evaluate(KeyCompetencies.Excellent, Format(ljobject2.GetValue('excellent')));
                            KeyCompetencies.Comments := Format(ljobject2.GetValue('comments'));
                            KeyCompetencies.Modify(true);
                            Sleep(1);
                            Commit();

                        end else begin
                            KeyCompetencies.Init();
                            KeyCompetencies."Appraisal No" := Format(ljobject2.GetValue('appraisalNo'));
                            Evaluate(KeyCompetencies.Value, Format(ljobject2.GetValue('Value')));
                            // jTokenValue := ljobject2.GetValue('improvement');
                            // isImprovement := jTokenValue.ToObject();
                            // KeyCompetencies."Improvement Require" := isImprovement;
                            Evaluate(KeyCompetencies."Improvement Require", Format(ljobject2.GetValue('improvement')));
                            Evaluate(KeyCompetencies.Good, Format(ljobject2.GetValue('good')));
                            Evaluate(KeyCompetencies.Average, Format(ljobject2.GetValue('average')));
                            Evaluate(KeyCompetencies.Excellent, Format(ljobject2.GetValue('excellent')));
                            KeyCompetencies.Comments := Format(ljobject2.GetValue('comments'));
                            KeyCompetencies.Insert(true);
                            Commit();
                        end;
                    end;
                end;
                //Personal Development
                if Format(lJObject.SelectToken('PersonalDevelopment')) <> '' then begin
                    clear(lJsonArray);
                    lJsonArray := lJsonArray.Parse(Format(lJObject.SelectToken('PersonalDevelopment')));
                    Clear(lJObject2);
                    foreach ljobject2 in lJsonArray do begin

                        PersonalDevelopment.Reset();
                        // PersonalDevelopment.SetRange("Line No", AnnualReview."Line No");
                        PersonalDevelopment.SetRange("Appraisal No.", Format(ljobject2.GetValue('appraisalNo')));
                        if PersonalDevelopment.Find('-') then begin
                            PersonalDevelopment."Areas to develop" := Format(ljobject2.GetValue('areas'));
                            PersonalDevelopment."Development activities" := Format(ljobject2.GetValue('developmentactivities'));
                            PersonalDevelopment."Resources required" := Format(ljobject2.GetValue('resourcesrequired'));
                            PersonalDevelopment."Targets and Timelines" := Format(ljobject2.GetValue('targetstimelines'));
                            PersonalDevelopment.Modify(true);
                            Sleep(1);
                            Commit();

                        end else begin
                            PersonalDevelopment.Init();
                            PersonalDevelopment."Appraisal No." := Format(ljobject2.GetValue('appraisalNo'));
                            PersonalDevelopment."Areas to develop" := Format(ljobject2.GetValue('areas'));
                            PersonalDevelopment."Development activities" := Format(ljobject2.GetValue('developmentactivities'));
                            PersonalDevelopment."Resources required" := Format(ljobject2.GetValue('resourcesrequired'));
                            PersonalDevelopment."Targets and Timelines" := Format(ljobject2.GetValue('targetstimelines'));
                            PersonalDevelopment.Insert(true);
                            Commit();
                        end;
                    end;
                end;
                //OverallComments
                if Format(lJObject.SelectToken('OverallComments')) <> '' then begin
                    if Format(lJObject.SelectToken('employeecomments')) <> '' then
                        clear(lJsonArray);
                    lJsonArray := lJsonArray.Parse(Format(lJObject.SelectToken('OverallComments')));
                    Clear(lJObject2);
                    foreach ljobject2 in lJsonArray do begin
                        Evaluate(OveralComments."Line No", Format(ljobject2.GetValue('lineno')));
                        OveralComments.Reset();
                        OveralComments.SetRange("Line No", OveralComments."Line No");
                        OveralComments.SetRange("Appraisal No", Format(ljobject2.GetValue('appraisalNo')));
                        OveralComments.SetRange("Appraisal Stage", OveralComments."Appraisal Stage"::"End Year Evaluation");
                        if OveralComments.Find('-') then begin
                            OveralComments."Employee Comments" := Format(ljobject2.GetValue('employeecomments'));
                            OveralComments."Appraiser’s assessment" := Format(ljobject2.GetValue('apparaisercomments'));
                            OveralComments."Line Manager Comments" := Format(ljobject2.GetValue('hrcomments'));
                            OveralComments."Appraisal Stage" := OveralComments."Appraisal Stage"::"End Year Evaluation";
                            OveralComments.Modify(true);
                            Sleep(1);
                            Commit();

                        end else begin
                            OveralComments.Init();
                            OveralComments."Appraisal No" := Format(ljobject2.GetValue('appraisalNo'));
                            OveralComments."Employee Comments" := Format(ljobject2.GetValue('employeecomments'));
                            OveralComments."Appraiser’s assessment" := Format(ljobject2.GetValue('apparaisercomments'));
                            OveralComments."Appraisal Stage" := OveralComments."Appraisal Stage"::"End Year Evaluation";
                            OveralComments."Line Manager Comments" := Format(ljobject2.GetValue('hrcomments'));
                            OveralComments.Insert(true);
                            Commit();
                        end;
                    end;
                end;

            end;
            exit(GetEvaluation(appraisalheader."No."));

        end;

    end;
    //Evaluations
    var
        lJsonArray: DotNet JArray;
        lJObject: dotnet JObject;

        lJObject2: dotnet JObject;

}