table 170463 "Award Restriction"
{
    // Serenic Navigator - (c)Copyright Serenic Software, Inc. 1999-2013.
    // By opening this object you acknowledge that this object includes confidential information
    // and intellectual property of Serenic Software, Inc., and that this work is protected by US
    // and international copyright laws and agreements.
    // ------------------------------------------------------------------------------------------


    fields
    {
        field(1; "Award No."; Code[10])
        {
            Caption = 'Award No.';
            NotBlank = true;
            TableRelation = Award;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                //  UpdateDimension;
            end;
        }
        field(15; "Award Currency Code"; Code[10])
        {
            Caption = 'Award Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(20; "Fund Filter"; Code[250])
        {
            Caption = 'Fund Filter';
            TableRelation = Donors;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(25; "Global Dimension 1 Filter"; Code[250])
        {
            CaptionClass = '1,4,1';
            Caption = 'Global Dimension 1 Filter';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(30; "Global Dimension 2 Filter"; Code[250])
        {
            CaptionClass = '1,4,2';
            Caption = 'Global Dimension 2 Filter';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35; "Global Dimension 3 Filter"; Code[250])
        {
            CaptionClass = '1,4,3';
            Caption = 'Global Dimension 3 Filter';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(40; "Global Dimension 4 Filter"; Code[250])
        {
            CaptionClass = '1,4,4';
            Caption = 'Global Dimension 4 Filter';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(45; "Global Dimension 5 Filter"; Code[250])
        {
            CaptionClass = '1,4,5';
            Caption = 'Global Dimension 5 Filter';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50; "Global Dimension 6 Filter"; Code[250])
        {
            CaptionClass = '1,4,6';
            Caption = 'Global Dimension 6 Filter';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(55; "Global Dimension 7 Filter"; Code[250])
        {
            CaptionClass = '1,4,7';
            Caption = 'Global Dimension 7 Filter';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(60; "Global Dimension 8 Filter"; Code[250])
        {
            CaptionClass = '1,4,8';
            Caption = 'Global Dimension 8 Filter';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(65; "G/L Account Filter"; Code[250])
        {
            Caption = 'G/L Account Filter';
            TableRelation = "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //  AVManagement.CheckGLAccountFilterToSetup("G/L Account Filter", FIELDCAPTION("G/L Account Filter"));
            end;
        }
        field(70; "Allow Posting From"; Date)
        {
            Caption = 'Allow Posting From';

            trigger OnValidate()
            begin

                //// IF ("Allow Posting From" <> 0D) AND ("Allow Posting To" <> 0D) AND ("Allow Posting From" > "Allow Posting To") THEN
                // ERROR(SNText005,FIELDCAPTION("Allow Posting From"),FIELDCAPTION("Allow Posting To"));

                //  Award.GET("Award No.");
                //  IF ("Allow Posting From" < Award."Allow Posting From") AND ("Allow Posting From" <> 0D) THEN
                //    ERROR(SNText002,Award."Allow Posting From");
            end;
        }
        field(75; "Allow Posting To"; Date)
        {
            Caption = 'Allow Posting To';

            trigger OnValidate()
            begin
                //IF ("Allow Posting To" <> 0D) AND ("Allow Posting From" > "Allow Posting To") THEN
                //  ERROR(SNText005,FIELDCAPTION("Allow Posting From"),FIELDCAPTION("Allow Posting To"));

                // Award.GET("Award No.");
                // IF ("Allow Posting To" > Award."Allow Posting To") AND (Award."Allow Posting To" <> 0D) THEN
                // ERROR(SNText003,Award."Allow Posting To");
            end;
        }
        field(80; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(85; "Date Created"; Date)
        {
            Caption = 'Date Created';
            Editable = false;
        }
        field(90; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(95; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(100; "Award No. Filter"; Code[10])
        {
            Caption = 'Award No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Award;
        }
        field(105; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(800; "Internal Control No. Filter"; Code[50])
        {
            Caption = 'Internal Control No. Filter';
            FieldClass = FlowFilter;
        }
        field(900; "Obligations (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            // CalcFormula = Sum("Detailed AV Ledger Entry"."Amount (LCY)" WHERE (AV Entry Type=CONST(Obligation),
            //  Entry Type=FILTER(Initial Entry|Modification),
            //  Award/Subaward No.=FIELD(Award No.),
            //                                                                               Award Restriction Code=FIELD(Code)));
            CaptionClass = '20,Obligations';
            Caption = 'Obligations (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(901; "Obligations (RCY)"; Decimal)
        {

            CaptionClass = '21,Obligations';
            Caption = 'Obligations (RCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(902; "Obligations (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionClass = '22,Obligations,' + "Award No.";
            Caption = 'Obligations (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(905; "Posted Expenses (LCY)"; Decimal)
        {
            AutoFormatType = 1;


            CaptionClass = '20,Posted Expenses';
            Caption = 'Posted Expenses (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(906; "Posted Expenses (RCY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '21,Posted Expenses';
            Caption = 'Posted Expenses (RCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(907; "Posted Expenses (ACY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '22,Posted Expenses,' + "Award No.";
            Caption = 'Posted Expenses (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(910; "Subaward (LCY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '20,Subaward';
            Caption = 'Subaward (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(911; "Subaward (RCY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '21,Subaward';
            Caption = 'Subaward (RCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(912; "Subaward (ACY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '22,Subaward,' + "Award No.";
            Caption = 'Subaward (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(915; "Pending Expenses (LCY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '20,Pending Expenses';
            Caption = 'Pending Expenses (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(916; "Pending Expenses (RCY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '21,Pending Expenses';
            Caption = 'Pending Expenses (RCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(917; "Pending Expenses (ACY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '22,Pending Expenses,' + "Award No.";
            Caption = 'Pending Expenses (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(920; "Subaward Obligations (LCY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '20,Subaward Obligations';
            Caption = 'Subaward Obligations (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(921; "Subaward Obligations (RCY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '21,Subaward Obligations';
            Caption = 'Subaward Obligations (RCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(922; "Subaward Obligations (ACY)"; Decimal)
        {
            AutoFormatType = 1;

            CaptionClass = '22,Subaward Obligations,' + "Award No.";
            Caption = 'Subaward Obligations (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }

       

    }

    keys
    {
        key(Key1; "Award No.", "Code")
        {
        }
        key(Key2; "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }



    trigger OnInsert()
    begin
        InitRecord;
        //DimensionIntegration(Rec);
        //SetAwardCurrency(Rec);

        "Created By" := USERID;
        "Date Created" := TODAY;
    end;

    trigger OnModify()
    begin
        //  DimensionIntegration(Rec);
        //  SetAwardCurrency(Rec);

        "Last Modified By" := USERID;
        "Last Date Modified" := TODAY;
    end;

    // Last Date Modified" := TODAY;
    // end;

    var

        Award: Record "170430";
        AwardRestriction: Record "170463";
        DimensionValue: Record "349";
        AwardRestriction2: Record "170463";
        DimDescription: Text[50];
        FileAttachment: Record "170502";
        SNText001: Label 'You cannot delete an award restriction with ledger entries.  ';
        SNText002: Label 'Allow Posting From is before Allow Posting From, %1, on the Award.';
        SNText003: Label 'Allow Posting To is after Allow Posting To, %1, on the Award.';
        SNText005: Label '%1 must be before %2.';
        SNText006: Label 'Used in multiple Awards.';
        // AVManagement: Codeunit "131071";
        SNText007: Label 'You cannot rename an award restriction with ledger entries.  ';

    procedure InitRecord()
    begin
        IF NOT Award.GET("Award No.") THEN
            EXIT;



        SetHiddenFilters();
    end;

    procedure SetHiddenFilters()
    begin


        IF NOT Award.GET("Award No.") THEN
            EXIT;




    end;

    procedure SetAwardCurrency(var AwardRestriction: Record "170463")
    var
        Award: Record "170430";
    begin
        WITH AwardRestriction DO BEGIN
            IF NOT Award.GET("Award No.") THEN
                EXIT;
            //"Award Currency Code" := Award."Currency Code";
        END;
    end;

    procedure DimensionIntegration(var AwardRestriction: Record "170463")
    var
        DimensionValue: Record "349";
    begin

    end;

    procedure UpdateDimension()
    begin

    end;
}

