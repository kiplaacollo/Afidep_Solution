//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50122 "HR Leave Period List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Leave Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code"; Rec."Period Code")
                {
                    ApplicationArea = Basic;
                }
                field("Period Description"; Rec."Period Description")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Locked"; Rec."Date Locked")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control1102755009; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Report 172233>")
            {
                ApplicationArea = Basic;
                Caption = '&Create Year';
                Ellipsis = true;
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Create Leave Year";
            }
            action("C&lose Year")
            {
                ApplicationArea = Basic;
                Caption = 'C&lose Year';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Leave Year-Close";
            }
        }
    }
}




