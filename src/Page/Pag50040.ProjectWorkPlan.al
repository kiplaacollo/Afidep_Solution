Page 50040 "Project Work Plan"
{
    Caption = 'Dimension Values';
    DataCaptionFields = "Dimension Code";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Project Implementation Plan";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Dimension Value Type"; Rec."Dimension Value Type")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Indent Dimension Values")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Indent Dimension Values';
                    Image = Indent;
                    RunObject = Codeunit "Dimension Value-Indent";
                    RunPageOnRec = true;
                    ToolTip = 'Indent dimension values between a Begin-Total and the matching End-Total one level to make the list easier to read.';
                }
                action("Project Budget")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Project Budget';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Project Budget";
                    RunPageLink = "Dimension Code" = const('BUDGET LINES'),
                                  "Project Code" = field(Code);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NameIndent := 0;
        FormatLine;
    end;

    trigger OnOpenPage()
    var
        DimensionCode: Code[20];
    begin
        if Rec.GetFilter(Rec."Dimension Code") <> '' then
            DimensionCode := Rec.GetRangeMin(Rec."Dimension Code");
        if DimensionCode <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Dimension Code", DimensionCode);
            Rec.FilterGroup(0);
        end;
    end;

    var
        [InDataSet]
        Emphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;

    local procedure FormatLine()
    begin
        Emphasize := Rec."Dimension Value Type" <> Rec."dimension value type"::Standard;
        NameIndent := Rec.Indentation;
    end;
}

