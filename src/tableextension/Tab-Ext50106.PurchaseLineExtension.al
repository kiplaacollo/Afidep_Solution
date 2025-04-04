tableextension 50106 "PurchaseLineExtension" extends "Purchase Line"
{


    fields
    {


        field(172760; "ShortcutDimCode[3]"; Code[20])
        {
            DataClassification = ToBeClassified;

            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                          Blocked = const(false),
                                                          "Outcome Code" = field("ShortcutDimCode[4]"));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;

        }
        field(172761; "ShortcutDimCode[4]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                          Blocked = const(false), "Project Code" = field("Shortcut Dimension 2 Code"));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                // "Budget Line description" :=dimen
            end;
        }
        field(172762; "ShortcutDimCode[5]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(172763; "ShortcutDimCode[6]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(172764; "ShortcutDimCode[7]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(172765; "ShortcutDimCode[8]"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 5 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(172766; "Amount Spent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172767; "Cash Refund"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172768; "Cash Refund  Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(172769; "Expense Category"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text";

            trigger OnValidate()
            begin
                exp := "Expense Category";
                Type := Type::"G/L Account";
                if StandardText.Get("Expense Category") then
                    Validate("No.", StandardText."G/L Account");

                "Expense Category" := exp;
            end;
        }
        field(172770; "Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Objectives,"Team Roles",Activity,"Budget Info","Budget Notes",Performance,Sections,PersonalQualities,Reflections,CapacityNeeds,ActionPoints;
        }
        field(172771; "No of days"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // "Total Ksh" := "No of days" * "No of pax" * Ksh;
                // "Line Amount" := "No of days" * "No of pax" * Ksh;
                // "Amount Including VAT" := "No of days" * "No of pax" * Ksh;
                //Amount := "No of days" * "No of pax" * Ksh;

            end;
        }
        field(172772; "No of pax"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //  "Total Ksh" := "No of days" * "No of pax" * Ksh;
                //  "Line Amount" := "No of days" * "No of pax" * Ksh;
                //Amount := "No of days" * "No of pax" * Ksh;
                //  "Amount Including VAT" := "No of days" * "No of pax" * Ksh;
            end;
        }
        field(172773; Ksh; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Ksh" := "No of days" * "No of pax" * Ksh;
                "Line Amount" := "No of days" * "No of pax" * Ksh;
                //Amount := "No of days" * "No of pax" * Ksh;
                "Amount Including VAT" := "No of days" * "No of pax" * Ksh;
            end;
        }
        field(172774; "other currency"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Other Currency" := "No of days" * "No of pax" * "other currency";
            end;
        }
        field(172775; "Total Ksh"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172776; "Total Other Currency"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172777; "Mission Expense Category"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text" where(Type2 = const("GL Category"));
        }
        field(172778; keyResultAreas; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Performance start';
        }
        field(172779; keyActivities; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172780; performanceMeasures; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172781; commentsOnAchievedResults; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172782; target; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172783; actualAchieved; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172784; percentageOfTarget; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172785; rating; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172786; weightingRating; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172787; weighting; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172788; appraisalType; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Sections start';
            OptionCaption = 'Technical Capacity,Organisation and planning skills,Efficiency and Effectiveness,Communication,Leadership';
            OptionMembers = "Technical Capacity","Organisation and planning skills","Efficiency and Effectiveness",Communication,Leadership;
        }
        field(172789; appraisalDescription; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172790; staffRating; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(172791; supervisorRating; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(172792; personalDescription; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Personal Qualities start';
        }
        field(172793; score; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172794; comments; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172795; reflectionDescription; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Start refelctions';
        }
        field(172796; selfAppraisal; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172797; supervisorsFeedback; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172798; capacity; Text[200])
        {
            DataClassification = ToBeClassified;
            Description = 'Start capacity needs';
        }
        field(172799; completionDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(172800; capacityNeedsDescription; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172801; remedialMeasures; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172802; planning; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172803; personResponsible; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172804; agreedActionPoints; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172805; timelines; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(172806; date; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = '// Activity details';
        }
        field(172807; departureTime; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(172808; departurePlace; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(172809; arrivalTime; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(172810; arrivalPlace; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(172811; remarks; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(172812; dateFrom; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Accomodation detailld';
        }
        field(172813; dateTo; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(172814; accomodtionCatered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(172815; locationOfStay; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(172817; noOfNights; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(172818; "location."; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MelsAndInc';
        }
        field(172819; noOfDays; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(172820; "Travel Line Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172821; "Expense Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(172822; amountToRefund; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172823; "Withholding Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172824; "Withholding Tax Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Withholding Tax Setup".Code;

        }
        field(172825; "Withholding Tax Rate %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172826; "Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172827; "Remaining Budget Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172828; "Committed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172829; "Actual Incurred Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172830; Difference; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(1720831; "Description 3"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(1720832; "Description 4"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(1720833; "Description 5"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(1720834; "Description 6"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(1720835; "Line Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(172001; "Consultancy Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172003; "Withholdingg Tax(Consultancy/Professional)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172004; "Imprest Account No"; Code[20])
        {
            TableRelation = "Customer"."No.";
        }
        field(172005; "Imprest Account Name"; Text[50])
        {

        }
        field(172006; "Budget Speed key"; Code[2000])
        {
            TableRelation = "Donors Budget Matrix line"."Budget Line No Code";

            trigger OnValidate()
            var
                DonorBudgetMatrix: Record "Donors Budget Matrix line";
                StandardText: Record "Standard Text";
                GL: Record "G/L Account";
                NewLineNo: Integer;
            begin
                DonorBudgetMatrix.Reset();
                DonorBudgetMatrix.SetRange(DonorBudgetMatrix."Budget Line No Code", "Budget Speed key");
                if DonorBudgetMatrix.FindFirst() then begin
                    DonorBudgetMatrix.CalcFields("Committed Amount");
                    Rec.Init();

                    rec."Budget Speed key" := DonorBudgetMatrix."Budget Line No Code";
                    Rec.Type := Type::"G/L Account";
                    Rec."Document Type" := "Document Type"::Quote;
                    Rec."Buy-from Vendor No." := 'VND_0001';
                    Rec."No." := DonorBudgetMatrix."GL Account No";
                    Rec.Description := DonorBudgetMatrix."GL Account Name";
                    Validate(Rec."No.");
                    Rec.Quantity := '1';
                    Rec."Outstanding Quantity" := '1';
                    Rec."Qty. to Invoice" := '1';
                    Rec."Qty. to Receive" := '1';
                    Rec."Shortcut Dimension 1 Code" := DonorBudgetMatrix."Fund No Code";

                    Rec."Shortcut Dimension 2 Code" := DonorBudgetMatrix."Budget Code2";
                    Rec."ShortcutDimCode[3]" := DonorBudgetMatrix."Donor Code";
                    Rec."ShortcutDimCode[4]" := DonorBudgetMatrix."Programme Code";
                    Rec."ShortcutDimCode[5]" := DonorBudgetMatrix."Staff Code";
                    Rec."ShortcutDimCode[6]" := DonorBudgetMatrix."Output Code";
                    Rec."ShortcutDimCode[7]" := DonorBudgetMatrix."Cost Category Code";
                    Rec."ShortcutDimCode[8]" := DonorBudgetMatrix."Grant Code";
                    Rec."Committed Amount" := DonorBudgetMatrix."Committed Amount";
                    Rec."Budget Amount" := DonorBudgetMatrix."Total Budget Amount";

                    StandardText.Description := DonorBudgetMatrix."GL Account Name";

                    Rec."Budget Line description" := DonorBudgetMatrix."Budget Line Description.";
                    Rec."Budget Balance" := DonorBudgetMatrix."Total Budget Amount" - DonorBudgetMatrix."Committed Amount";
                    Rec.Insert()
                end;

                Quantity := 1;
                PurchHeader.Reset();
                PurchHeader.SetRange("No.", "Document No.");
                if PurchHeader.FindFirst() then begin
                    "Currency Code" := PurchHeader."Currency Code";
                end;


                //end;
                //end;
            end;
            //

        }
        field(172008; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172009; "Bank Account Number"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172010; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172011; "Budget Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172012; "Budget Line description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172013; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172014; "Country"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('COUNTRY')
                                                          );
        }
        field(172015; "Amount In Foreign"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172016; "Gross Amount Subject To Withnolding"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172018; "Budget Line Codes"; Code[1000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Entry"."Global Dimension 2 Code";
            trigger OnValidate()
            var

                GLBudgetEntry: Record "G/L Budget Entry";
            begin

                if GLBudgetEntry.Get("Shortcut Dimension 2 Code") then
                    "Shortcut Dimension 2 Code" := GLBudgetEntry."Global Dimension 2 Code";
                "Budget Line description" := GLBudgetEntry."Budget Line Description";

            end;
        }
        field(172017; "Account No New"; Code[100])
        {

            TableRelation = if ("Claim Type" = const(" ")) "Standard Text"
            else
            if ("Claim Type" = const("G/L Account"), "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else
            if ("Claim Type" = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
            else
            if ("Claim Type" = const(Supplier)) Vendor
            else
            if ("Claim Type" = const(Customer)) Customer;

            trigger OnValidate()
            begin

                case "Claim Type" of
                    "Claim Type"::" ":
                        CopyFromStandardText();
                    "Claim Type"::"G/L Account":
                        CopyFromGLAccount(Rec);
                    "Claim Type"::Customer:
                        CustomerAccount(Rec);
                    "Claim Type"::Supplier:

                        VendorAccount(Rec);

                end;
                IsHandled := false;
                OnBeforeValidateVATProdPostingGroup(Rec, xRec, IsHandled);
                if not IsHandled then
                    Validate("VAT Prod. Posting Group");
                UpdatePrepmtSetupFields();

                UpdateVATAmounts()
            end;



        }
        field(172019; "Type New"; Enum "Purchase Line Type")
        {
            trigger OnValidate()
            var
                Banks: Record "Bank Account";
                Vendor: Record Vendor;
                Customer: Record Customer;
                COA: Record "G/L Account";
            begin
            end;
        }
        field(172020; "Claim Type"; Enum "Claim type")
        {
            trigger OnValidate()
            var
                Banks: Record "Bank Account";
                Vendor: Record Vendor;
                Customer: Record Customer;
                COA: Record "G/L Account";
            begin

            end;
        }
        field(172021; "Function Name"; Text[2014])
        {

        }
        field(172022; "Budget Center Name"; Text[2014])
        {

        }
        field(172023; "Activity Discription"; Text[2014])
        {

        }
        field(172031; "VAT Rate"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account"."VAT Prod. Posting Group" where("No." = field("Account No New")));
        }
        field(172025; Rate; Integer)
        {
            trigger OnValidate()
            begin
                // "Direct Unit Cost" := Quantity * Rate;
                // Rec."Line Amount" := Rec."Direct Unit Cost" * Rec.Rate * Rec.Quantity;
                // Rec."Amount Including VAT" := Rec."Direct Unit Cost" * Rec.Rate * Rec.Quantity;
                // Validate("Direct Unit Cost");
            end;
        }

        field(172026; "Account Type"; Option)
        {
            OptionMembers = ,"G/L Account",Supplier,Customer,Bank;

            // CalcFormula = lookup("G/L Account"."VAT Prod. Posting Group" where("No." = field("Account No New")));
        }
        field(172027; "Account No."; Code[20])
        {
            //OptionMembers = ,"G/L Account",Supplier,Customer,Bank;
            TableRelation = IF ("Account Type" = CONST("")) "Standard Text" ELSE
            IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting)) ELSE
            IF ("Account Type" = CONST("G/L Account")) "G/L Account" ELSE
            IF ("Account Type" = CONST(Supplier)) Vendor ELSE
            IF ("Account Type" = CONST(Customer)) Customer ELSE
            IF ("Account Type" = CONST(Bank)) "Bank Account";
            // CalcFormula = lookup("G/L Account"."VAT Prod. Posting Group" where("No." = field("Account No New")));
        }

        field(172028; "Applies-to Doc. Type"; option)
        {
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;

        }

        field(172029; "Applies-to Doc. No."; code[20])
        {
            trigger
            OnValidate()

            BEGIN



                IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." <> '') AND
                ("Applies-to Doc. No." <> '')
             THEN BEGIN
                    SetAmountToApply("Applies-to Doc. No.", "Account No.");
                    SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
                END ELSE
                    IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." = '') THEN
                        SetAmountToApply("Applies-to Doc. No.", "Account No.")
                    ELSE
                        IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND ("Applies-to Doc. No." = '') THEN
                            SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
            END;

            trigger OnLookup()
            var
                OK: Boolean;
            begin
                WITH Rec DO BEGIN
                    // Amount:=0;
                    // "VAT Amount":=0;

                    //VALIDATE(Amount);
                    //VALIDATE("VAT Amount");

                    PayToVendorNo := "Account No.";
                    //  Message(PayToVendorNo);
                    VendLedgEntry.SETCURRENTKEY("Vendor No.", Open);
                    VendLedgEntry.SETRANGE("Vendor No.", "Account No.");
                    VendLedgEntry.SETRANGE(Open, TRUE);
                    if VendLedgEntry.Findset then begin
                        IF "Applies-to ID" = '' THEN
                            "Applies-to ID" := "Document No.";
                        IF "Applies-to ID" = '' THEN
                            ERROR(
                              Text000,
                              FIELDCAPTION("Document No."), FIELDCAPTION("Applies-to ID"));
                        //PurchHeader.reset;
                        PurchHeader.get(PurchHeader."Document Type"::Quote, "Document No.");
                        //ApplyVendEntries."SetPVLine-Delete"(PVLine,PVLine.FIELDNO("Applies-to ID"));
                        ApplyVendEntries.SetPurch(PurchHeader, VendLedgEntry, Rec.FIELDNO("Applies-to ID"));
                        ApplyVendEntries.SETRECORD(VendLedgEntry);
                        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                        ApplyVendEntries.LOOKUPMODE(TRUE);
                        OK := ApplyVendEntries.RUNMODAL = ACTION::LookupOK;
                        CLEAR(ApplyVendEntries);
                        IF NOT OK THEN
                            EXIT;
                    end;

                    VendLedgEntry.RESET;
                    VendLedgEntry.SETCURRENTKEY("Vendor No.", Open);
                    VendLedgEntry.SETRANGE("Vendor No.", "Account No.");
                    VendLedgEntry.SETRANGE(Open, TRUE);
                    VendLedgEntry.SETRANGE("Applies-to ID", UserId);
                    IF VendLedgEntry.FIND('-') THEN BEGIN
                        "Applies-to Doc. Type" := 0;
                        "Applies-to Doc. No." := '';
                        Amount := VendLedgEntry."Amount to Apply";
                    END ELSE
                        "Applies-to ID" := '';
                END;

                //Calculate  Total To Apply
                VendLedgEntry.RESET;
                VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, "Applies-to ID");
                VendLedgEntry.SETRANGE("Vendor No.", PayToVendorNo);
                VendLedgEntry.SETRANGE(Open, TRUE);
                VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                IF VendLedgEntry.FIND('-') THEN BEGIN
                    VendLedgEntry.CALCSUMS("Amount to Apply");
                    Amount := ABS(VendLedgEntry."Amount to Apply");
                    // VALIDATE(Amount);
                END;
                //  "VAT Amount" := 0;
                "Applies-to Doc. Type" := VendLedgEntry."Document Type";
                "Applies-to Doc. No." := VendLedgEntry."Document No.";
                "Applies-to ID" := '';
                MODIFY;
                //  AddApplicationEntries();

            end;


        }


        field(172030; "Applies-to ID"; CODE[20])
        {

        }
        field(172032; "Unit Cost (LCY) New"; Decimal)
        {
            Caption = 'Unit Cost (LCY)';
        }
        field(172033; "Amount New"; Decimal)
        {

            Caption = 'Amount';
            // Editable = false;
        }
        field(172034; "Line Amount New"; Decimal)
        {


            Caption = 'Line Amount';
            Editable = false;
            trigger OnValidate()
            begin
                "Line Amount New" := Quantity * "Direct Unit Cost";
            end;
        }
        field(172035; "Extended Description 2"; Text[1000])
        {
            Caption = 'Extended Description 2';
            DataClassification = ToBeClassified;
        }
        field(172036; "Consultancy Fee 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172037; "Withholding Tax Code 2"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Withholding Tax Setup".Code;

        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
            begin
                PurchHeader.Reset();
                PurchHeader.SetRange("No.", Rec."Document No.");
                if PurchHeader.Find('-') then
                    if (PurchHeader."Currency Code" <> '') and ("Unit Cost (LCY)" <> 0) then begin

                        PurchHeader.TestField("Currency Factor");
                        Rec."Unit Cost (LCY)" :=
                          CurrExchRate.ExchangeAmtFCYToLCY(
                            Today, PurchHeader."Currency Code",
                            Rec."Direct Unit Cost", PurchHeader."Currency Factor");

                        Rec.Amount := Rec."Unit Cost (LCY)" * Rec.Quantity;
                    end else
                        if (PurchHeader."Currency Code" <> '') and ("Unit Cost (LCY) New" <> 0) then begin

                            PurchHeader.TestField("Currency Factor");
                            Rec."Unit Cost (LCY) New" :=
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                Today, PurchHeader."Currency Code",
                                Rec."Direct Unit Cost", PurchHeader."Currency Factor");

                            Rec."Amount New" := Rec."Unit Cost (LCY) New" * Rec.Quantity;
                            // Rec."Line Amount New" := Rec."Direct Unit Cost" * Rec.Quantity;
                        end;
                //  Rec.Modify();
                if (PurchHeader."Currency Code" <> '') and ("Unit Cost (LCY) New" <> 0) then begin

                    PurchHeader.TestField("Currency Factor");
                    Rec."Unit Cost (LCY) New" :=
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        Today, PurchHeader."Currency Code",
                        Rec."Direct Unit Cost", PurchHeader."Currency Factor");

                    // Rec."Amount New" := Rec."Unit Cost (LCY) New" * Rec.Quantity;
                    Rec."Line Amount New" := Rec."Direct Unit Cost" * Rec.Quantity;
                end;
                //  Rec.Modify();
            end;
        }
        modify("Direct Unit Cost")
        {
            Caption = 'Amount Per Unit';
            CaptionClass = 'Amount Per Unit';
            trigger OnAfterValidate()
            begin
                PurchHeader.Reset();
                PurchHeader.SetRange("No.", Rec."Document No.");
                if PurchHeader.Find('-') then
                    if (PurchHeader."Currency Code" <> '') and ("Unit Cost (LCY)" <> 0) then begin

                        PurchHeader.TestField("Currency Factor");
                        Rec."Unit Cost (LCY)" :=
                          CurrExchRate.ExchangeAmtFCYToLCY(
                            Today, PurchHeader."Currency Code",
                            Rec."Direct Unit Cost", PurchHeader."Currency Factor");

                        Rec.Amount := Rec."Unit Cost (LCY)" * Rec.Quantity;
                    end else
                        if (PurchHeader."Currency Code" <> '') and ("Unit Cost (LCY) New" <> 0) then begin

                            PurchHeader.TestField("Currency Factor");
                            Rec."Unit Cost (LCY) New" :=
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                Today, PurchHeader."Currency Code",
                                Rec."Direct Unit Cost", PurchHeader."Currency Factor");

                            Rec."Amount New" := Rec."Unit Cost (LCY) New" * Rec.Quantity;
                            // Rec."Line Amount New" := Rec."Direct Unit Cost" * Rec.Quantity;
                        end;
                //  Rec.Modify();
                if (PurchHeader."Currency Code" <> '') and ("Unit Cost (LCY) New" <> 0) then begin

                    PurchHeader.TestField("Currency Factor");
                    Rec."Unit Cost (LCY) New" :=
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        Today, PurchHeader."Currency Code",
                        Rec."Direct Unit Cost", PurchHeader."Currency Factor");

                    // Rec."Amount New" := Rec."Unit Cost (LCY) New" * Rec.Quantity;
                    Rec."Line Amount New" := Rec."Direct Unit Cost" * Rec.Quantity;
                end;
                //   Rec.Modify();
            end;

        }




    }


    procedure SetAmountToApply(var AppliesToDocNo: Code[30]; var "Account No.": Code[30])
    begin
        VendLedgEntry.SETCURRENTKEY("Document No.");
        VendLedgEntry.SETRANGE("Document No.", AppliesToDocNo);
        VendLedgEntry.SETRANGE("Vendor No.", VendorNo);
        VendLedgEntry.SETRANGE(Open, TRUE);
        IF VendLedgEntry.FINDFIRST THEN BEGIN
            IF VendLedgEntry."Amount to Apply" = 0 THEN BEGIN
                VendLedgEntry.CALCFIELDS("Remaining Amount");
                VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
            END ELSE
                VendLedgEntry."Amount to Apply" := 0;
            VendLedgEntry."Accepted Payment Tolerance" := 0;
            VendLedgEntry."Accepted Pmt. Disc. Tolerance" := FALSE;
            CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
        END;


    end;


    procedure LookUpAppliesToDocVend(AccNo: Code[20])
    begin
        CLEAR(VendLedgEntry);
        VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date");
        IF AccNo <> '' THEN
            VendLedgEntry.SETRANGE("Vendor No.", AccNo);
        VendLedgEntry.SETRANGE(Open, TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
            VendLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
            VendLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
            IF VendLedgEntry.ISEMPTY THEN BEGIN
                VendLedgEntry.SETRANGE("Document Type");
                VendLedgEntry.SETRANGE("Document No.");
            END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
            VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
            IF VendLedgEntry.ISEMPTY THEN
                VendLedgEntry.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::Reminder THEN BEGIN
            VendLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
            IF VendLedgEntry.ISEMPTY THEN
                VendLedgEntry.SETRANGE("Document Type");
        END;
        IF "Applies-to Doc. No." <> '' THEN BEGIN
            VendLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
            IF VendLedgEntry.ISEMPTY THEN
                VendLedgEntry.SETRANGE("Document No.");
        END;
        IF Amount <> 0 THEN BEGIN
            VendLedgEntry.SETRANGE(Positive, Amount < 0);
            IF VendLedgEntry.ISEMPTY THEN;
            VendLedgEntry.SETRANGE(Positive);
        END;
        //  ApplyVendEntries.SetGenJnlLine(Rec, Rec.FIELDNO("Applies-to Doc. No."));
        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
        ApplyVendEntries.SETRECORD(VendLedgEntry);
        ApplyVendEntries.LOOKUPMODE(TRUE);
        IF ApplyVendEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ApplyVendEntries.GETRECORD(VendLedgEntry);
            IF AccNo = '' THEN BEGIN
                AccNo := VendLedgEntry."Vendor No.";
                // IF "Bal. Account Type" = "Bal. Account Type"::Vendor THEN
                //  VALIDATE("Bal. Account No.",AccNo)
                // ELSE
                //  VALIDATE("Account No.",AccNo);
            END;
            //SetAmountWithVendLedgEntry;
            "Applies-to Doc. Type" := VendLedgEntry."Document Type";
            "Applies-to Doc. No." := VendLedgEntry."Document No.";
            "Applies-to ID" := '';
        END;


    end;

    var
        PayToVendorNo: code[40];
        VendorNo: code[40];
        ApplyVendEntries: Page "Apply Vendor Entries";
        VendLedgEntry: record "Vendor Ledger Entry";
        IsHandled: Boolean;
        Text000: label 'You cannot rename a %1.';
        Text001: label 'You cannot change %1 because the order line is associated with sales order %2.';
        Text002: label 'Prices including VAT cannot be calculated when %1 is %2.';
        Text003: label 'You cannot purchase resources.';
        Text004: label 'must not be less than %1';
        Text006: label 'You cannot invoice more than %1 units.';
        Text007: label 'You cannot invoice more than %1 base units.';
        Text008: label 'You cannot receive more than %1 units.';
        Text009: label 'You cannot receive more than %1 base units.';
        Text010: label 'You cannot change %1 when %2 is %3.';
        Text011: label ' must be 0 when %1 is %2';
        Text012: label 'must not be specified when %1 = %2';
        Text016: label '%1 is required for %2 = %3.';
        Text017: label '\The entered information may be disregarded by warehouse operations.';
        Text018: label '%1 %2 is earlier than the work date %3.';
        Text020: label 'You cannot return more than %1 units.';
        Text021: label 'You cannot return more than %1 base units.';
        Text022: label 'You cannot change %1, if item charge is already posted.';
        Text023: label 'You cannot change the %1 when the %2 has been filled in.';
        Text029: label 'must be positive.';
        Text030: label 'must be negative.';
        Text031: label 'You cannot define item tracking on this line because it is linked to production order %1.';
        Text032: label '%1 must not be greater than the sum of %2 and %3.';
        Text033: label 'Warehouse ';
        Text034: label 'Inventory ';
        Text035: label '%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.';
        Text037: label 'cannot be %1.';
        Text038: label 'cannot be less than %1.';
        Text039: label 'cannot be more than %1.';
        Text040: label 'You must use form %1 to enter %2, if item tracking is used.';
        ItemChargeAssignmentErr: label 'You can only assign Item Charges for Line Types of Charge (Item).';
        Text172000: label 'You cannot change %1 when the purchase order is associated to a production order.';
        PurchHeader: Record "Purchase Header";
        PurchLine2: Record "Purchase Line";
        GLAcc: Record "G/L Account";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        VATPostingSetup: Record "VAT Posting Setup";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        UnitOfMeasure: Record "Unit of Measure";
        ItemCharge: Record "Item Charge";
        SKU: Record "Stockkeeping Unit";
        WithholdingTaxSetup: Record "Withholding Tax Setup";
        WorkCenter: Record "Work Center";
        InvtSetup: Record "Inventory Setup";
        Location: Record Location;
        GLSetup: Record "General Ledger Setup";
        CalChange: Record "Customized Calendar Change";
        TempJobJnlLine: Record "Job Journal Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        UOMMgt: Codeunit "Unit of Measure Management";
        AddOnIntegrMgt: Codeunit AddOnIntegrManagement;
        DimMgt: Codeunit DimensionManagement;
        DistIntegration: Codeunit "Dist. Integration";
        CatalogItemMgt: Codeunit "Catalog Item Management";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        //PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        CalendarMgmt: Codeunit "Calendar Management";
        CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
        DeferralUtilities: Codeunit "Deferral Utilities";
        PostingSetupMgt: Codeunit PostingSetupManagement;
        TrackingBlocked: Boolean;
        Vendor: Record Vendor;
        Customer: Record Customer;

        StatusCheckSuspended: Boolean;
        GLSetupRead: Boolean;
        UnitCostCurrency: Decimal;
        UpdateFromVAT: Boolean;
        Text042: label 'You cannot return more than the %1 units that you have received for %2 %3.';
        Text043: label 'must be positive when %1 is not 0.';
        Text044: label 'You cannot change %1 because this purchase order is associated with %2 %3.';
        Text046: label '%3 will not update %1 when changing %2 because a prepayment invoice has been posted. Do you want to continue?', Comment = '%1 - product name';
        Text047: label '%1 can only be set when %2 is set.';
        Text048: label '%1 cannot be changed when %2 is set.';
        PrePaymentLineAmountEntered: Boolean;
        Text049: label 'You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?';
        Text050: label 'Cancelled.';
        Text051: label 'must have the same sign as the receipt';
        Text052: label 'The quantity that you are trying to invoice is greater than the quantity in receipt %1.';
        Text053: label 'must have the same sign as the return shipment';
        Text054: label 'The quantity that you are trying to invoice is greater than the quantity in return shipment %1.';
        AnotherItemWithSameDescrQst: label 'Item No. %1 also has the description "%2".\Do you want to change the current item no. to %1?', Comment = '%1=Item no., %2=item description';
        AnotherChargeItemWithSameDescQst: label 'Item charge No. %1 also has the description "%2".\Do you want to change the current item charge no. to %1?', Comment = '%1=Item charge no., %2=item charge description';
        PurchSetupRead: Boolean;
        CannotFindDescErr: label 'Cannot find %1 with Description %2.\\Make sure to use the correct type.', Comment = '%1 = Type caption %2 = Description';
        CommentLbl: label 'Comment';
        LineDiscountPctErr: label 'The value in the Line Discount % field must be between 0 and 100.';
        PurchasingBlockedErr: label 'You cannot purchase this item because the Purchasing Blocked check box is selected on the item card.';
        CannotChangePrepaidServiceChargeErr: label 'You cannot change the line because it will affect service charges that are already invoiced as part of a prepayment.';
        StandardText: Record "Standard Text";
        exp: Code[100];

    local procedure CopyFromGLAccount(var TempPurchaseLine: Record "Purchase Line" temporary)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;


        GLAcc.Get("Account No New");
        GLAcc.CheckGLAcc();
        if not "System-Created Entry" then
            GLAcc.TestField("Direct Posting", true);
        Description := GLAcc.Name;
        "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
        "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
        "Tax Group Code" := GLAcc."Tax Group Code";
        "Allow Invoice Disc." := false;
        "Allow Item Charge Assignment" := false;
        InitDeferralCode();

    end;

    local procedure CustomerAccount(var TempPurchaseLine: Record "Purchase Line" temporary)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;


        Customer.Get("Account No New");

        if not "System-Created Entry" then
            Description := Customer.Name;


    end;

    local procedure VendorAccount(var TempPurchaseLine: Record "Purchase Line" temporary)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;


        Vendor.Get("Account No New");

        if not "System-Created Entry" then
            Description := Vendor.Name;


    end;

    local procedure CopyFromStandardText()
    var
        StandardText: Record "Standard Text";
        GLNo: Record "G/L Account";
    begin
        "Tax Area Code" := '';
        "Tax Liable" := false;
        StandardText.Get("No.");
        Description := StandardText.Description;


    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateVATProdPostingGroup(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
    end;

}

