//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172914 "Crm Log List"
{
    CardPageID = "Crm log card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "General Equiries.";
    SourceTableView = where(Send = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(Departments; Rec.Departments)
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Captured On"; Rec."Captured On")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }

            }
        }
        area(factboxes)
        {
            // part(Control2;"Member Statistics FactBox")
            // {
            //     Caption = 'BOSA Statistics FactBox';
            //     SubPageLink = "No." = field("Member No");
            // }
            // part(Control1;"FOSA Statistics FactBox")
            // {
            //     SubPageLink = "No." = field("Fosa account");
            // }
        }
    }

    actions
    {
    }
}




