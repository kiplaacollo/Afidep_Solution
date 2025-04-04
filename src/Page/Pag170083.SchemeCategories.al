Page 170083 "Scheme Categories"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Scheme Categories";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                field("Scheme Number"; Rec."Scheme Number")
                {
                    ApplicationArea = Basic;
                }
                field("Scheme Category"; Rec."Scheme Category")
                {
                    ApplicationArea = Basic;
                }
                field(Inpatient; Rec.Inpatient)
                {
                    ApplicationArea = Basic;
                }
                field(Maternity; Rec.Maternity)
                {
                    ApplicationArea = Basic;
                }
                field(Outpatient; Rec.Outpatient)
                {
                    ApplicationArea = Basic;
                }
                field(Optical; Rec.Optical)
                {
                    ApplicationArea = Basic;
                }
                field(Dental; Rec.Dental)
                {
                    ApplicationArea = Basic;
                }
                field("Last Expense"; Rec."Last Expense")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

