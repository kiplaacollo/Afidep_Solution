Page 170079 "HR Medical Scheme Members List"
{
    CardPageID = "HR Medical Scheme Members Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Medical Scheme Members";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme No";Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee No";Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("First Name";Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name";Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(Designation;Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field("Scheme Join Date";Rec."Scheme Join Date")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Out-Patient";Rec."Balance Out-Patient")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Balance In-Patient";Rec."Balance In-Patient")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Out-Patient Limit";Rec."Out-Patient Limit")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("In-patient Limit";Rec."In-patient Limit")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

