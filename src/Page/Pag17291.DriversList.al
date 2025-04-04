page 17291 "Drivers List"
{

    Caption = 'Drivers List';

    CardPageID = "Drivers Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employees";
    SourceTableView = where("Is Driver" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Employee UserID"; Rec."Employee UserID")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Travelaccountno; Rec.Travelaccountno)
                {
                    ApplicationArea = Basic;
                    Caption = 'Imprest Account No';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    
    }

    
    trigger OnOpenPage()
    begin
      

    end;

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
}


