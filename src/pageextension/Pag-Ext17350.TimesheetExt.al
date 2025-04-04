pageextension 17350 "Timesheet Ext" extends "Time Sheet Lines Subform"
{
    layout
    {

        modify("Job No.")
        {
            Visible = false;
        }
        modify("Job Task No.")
        {
            Visible = false;
        }
        modify(Description)
        {
            Visible = false;
        }
        addafter(Type)
        {
            field(Project; Rec.Project)
            {

            }
            field("Projecct decription"; Rec."Projecct decription")
            {

            }
        }

        addafter(Field7)
        {
            field(Field8; CellData[8])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[8];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(8);

                end;
            }

            field(Field9; CellData[9])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[9];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(9);

                end;
            }
            field(Field10; CellData[10])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[10];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(10);

                end;
            }
            field(Field11; CellData[11])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[11];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(11);

                end;
            }
            field(Field12; CellData[12])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[12];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(12);

                end;
            }
            field(Field13; CellData[13])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[13];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(13);

                end;
            }
            field(Field14; CellData[14])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[14];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(14);

                end;
            }
            field(Field15; CellData[15])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[15];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(15);

                end;
            }
            field(Field16; CellData[16])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[16];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(16);

                end;
            }
            field(Field17; CellData[17])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[17];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(17);

                end;
            }
            field(Field18; CellData[18])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[18];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(18);

                end;
            }
            field(Field19; CellData[19])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[19];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(19);

                end;
            }
            field(Field20; CellData[20])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[20];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(20);

                end;
            }
            field(Field21; CellData[21])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[21];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(21);

                end;
            }
            field(Field22; CellData[22])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[22];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(22);

                end;
            }
            field(Field23; CellData[23])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[23];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(23);

                end;
            }
            field(Field24; CellData[24])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[24];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(24);

                end;
            }
            field(Field25; CellData[25])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[25];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(25);

                end;
            }
            field(Field26; CellData[26])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[26];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(26);

                end;
            }

            field(Field27; CellData[27])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[27];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(27);

                end;
            }
            field(Field28; CellData[28])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[28];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(28);

                end;
            }
            field(Field29; CellData[29])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[29];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(29);

                end;
            }
            field(Field30; CellData[30])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[30];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(30);

                end;
            }
            field(Field31; CellData[31])
            {
                ApplicationArea = Jobs;
                BlankZero = true;
                CaptionClass = '3,' + ColumnCaption[31];
                DecimalPlaces = 0 : 2;
                Editable = AllowEdit;
                Width = 3;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    ValidateQuantity(31);

                end;
            }






        }
    }

    var
        ColumnCaption: array[200048] of Text[1024];
        TimeSheetDetail: Record "Time Sheet Detail";
        //ColumnRecords: array[32] of Record Date;
        TimeSheetMgt: Codeunit "Time Sheet Management";
        TimeSheetApprovalMgt: Codeunit "Time Sheet Approval Management";
        NoOfColumns: Integer;
        ColumnRecords: array[200048] of Record Date;
        CellData: array[200048] of Decimal;
        //ColumnCaption: array[2048] of Text[1024];
        //CellData: array[32] of Decimal;
        //ColumnCaption: array[32] of Text[1024];
        CurrTimeSheetNo: Code[20];
        SetWanted: Option Previous,Next;
        Text001: Label 'The type of time sheet line cannot be empty.';
        //AllowEdit: Boolean;
        DimensionCaptionTok: Label 'Dimensions';
        UnitOfMeasureCode: Code[10];


    local procedure UpdateControls()
    var
        i: Integer;
    begin
        i := 0;
        while i < NoOfColumns do begin
            i := i + 1;
            if (Rec."Line No." <> 0) and TimeSheetDetail.Get(
                 Rec."Time Sheet No.",
                 Rec."Line No.",
                 ColumnRecords[i]."Period Start")
            then
                CellData[i] := TimeSheetDetail.Quantity
            else
                CellData[i] := 0;
        end;
        AllowEdit := Rec.Status in [Rec.Status::Open, Rec.Status::Rejected];

        SubmitLineEnabled := Rec.Status = Rec.Status::Open;
        ReopenSubmittedLineEnabled := Rec.Status in [Rec.Status::Submitted, Rec.Status::Rejected];
        ApproveLineEnabled := Rec.Status = Rec.Status::Submitted;
        RejectLineEnabled := Rec.Status = Rec.Status::Submitted;
        ReopenApprovedLineEnabled := Rec.Status in [Rec.Status::Approved, Rec.Status::Rejected];
    end;



    procedure SetColumns2(TimeSheetNo: Code[20])
    var
        Calendar: Record Date;
    begin
        Clear(ColumnCaption);
        Clear(ColumnRecords);
        Clear(Calendar);
        Clear(NoOfColumns);

        GetTimeSheetHeader(TimeSheetNo);
        TimeSheetHeader.CalcFields("Unit of Measure");
        UnitOfMeasureCode := TimeSheetHeader."Unit of Measure";

        Calendar.SetRange("Period Type", Calendar."Period Type"::Date);
        Calendar.SetRange("Period Start", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
        if Calendar.FindSet() then
            repeat
                NoOfColumns += 1;
                ColumnRecords[NoOfColumns]."Period Start" := Calendar."Period Start";
                ColumnCaption[NoOfColumns] := TimeSheetMgt.FormatDate(Calendar."Period Start", 1);
            until Calendar.Next() = 0;
    end;



    local procedure GetTimeSheetHeader(TimeSheetNo: Code[20])
    begin
        TimeSheetHeader.Get(TimeSheetNo);

        //OnAfterGetTimeSheetHeader(TimeSheetHeader);
    end;

}
