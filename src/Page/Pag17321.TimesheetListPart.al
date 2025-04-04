Page 17321 "Timesheet ListPart"
{
    PageType = ListPart;
    SourceTable = "TE Time Sheet1";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.") { }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Project; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Project';
                }
                field(Description; Rec.Description)
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }

                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    CaptionClass = 'Deliverables / activity';
                    Caption = 'Deliverables / activity';

                }
                field(Task; Rec.Narration)
                {
                    ApplicationArea = Basic;
                }
                field(Hours; Rec.Hours)
                {
                    ApplicationArea = Basic;
                }


            }


        }

    }


    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

    end;

    procedure ValidateQuantity2(NewMatrixColumns: array[32] of Text[80]; var NewMatrixRecords: array[12] of Record "Dimension Code Buffer"; CurrentNoOfMatrixColumns: Integer)

    var

        i: Integer;
    begin


        for i := 1 to 12 do
            CellData[i] := 0;

        for i := 1 to 12 do begin
            if NewMatrixColumns[i] = '' then
                ColumnCaption[i] := ' '
            else
                ColumnCaption[i] := NewMatrixColumns[i];
        end;

    end;

    procedure ValidateQuantity(ColumnNo: Integer)
    var

        i: Integer;
    begin


        for i := 1 to 12 do
            CellData[i] := 0;

        for i := 1 to 12 do begin

        end;

    end;

    procedure PeriodTypeOnAfterValidate()
    begin
        // ValidateQuantity(CellData)
    end;


    var
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        varrvariant: Variant;
        BaseDate: Date;
        TimesheetLines: Record TimesheetLines;
        CellData: array[2500] of Decimal;
        ColumnCaption: array[2500] of Text[1024];

    procedure GenerateDaysOfMonth(StartDate: Date; Timesheetcode: Code[50]; NoOfDays: Integer)
    var
        CurrentDate: Date;
        Counter: Integer;
        DaysInMonth: Integer;
        TimesheetLines: Record TimesheetLines;
        "TE Time Sheet1": Record "TE Time Sheet1";
        CurrentMonth: Integer;

    begin
        CurrentDate := StartDate;
        "TE Time Sheet1".Reset();
        "TE Time Sheet1".SetRange("Document No.", Timesheetcode);
        if "TE Time Sheet1".Find('-') then begin
            "TE Time Sheet1".DeleteAll();
        end;

        for Counter := 1 to NoOfDays do begin



            "TE Time Sheet1".Init();
            "TE Time Sheet1"."Document No." := Timesheetcode;
            "TE Time Sheet1".Date := CurrentDate;
            "TE Time Sheet1".INSERT(TRUE);
            Message('MESSAGE %1', CurrentDate);


            CurrentDate := CALCDATE('1D', CurrentDate); // Increment the date for the next cell


        end;

        CurrPage.UPDATE;
    end;

}

