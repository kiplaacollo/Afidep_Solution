page 80181 "Clearance Form"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Clearance;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Line Manager"; Rec."Line Manager")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
            group("EMPLOYEE CLEARANCE FORM")
            {
                field(Position; Rec.Position)
                {
                }
                field(Department; Rec.Department)
                {
                }
                field(Employment; Rec.Employment)
                {
                }
                field("Separation Date"; Rec."Separation Date")
                {
                }
            }
            group("Department /Program/ Section")
            {
                group("(Complete checklist below and return form along with requested materials to the HR Office.)")
                {
                    field("Acknowledged/signed separation"; Rec."Acknowledged/signed separation")
                    {
                    }
                    group("Termination resignation required forms:")
                    {
                        field("Hard/ soft copy reports"; Rec."Hard/ soft copy reports")
                        {
                        }
                        field("Updated list of reports"; Rec."Updated list of reports")
                        {
                        }
                        field("Completed Timesheets"; Rec."Completed Timesheets")
                        {
                        }
                        field("Finance Clearance note"; Rec."Finance Clearance note")
                        {
                        }
                    }
                }
            }
            group("ICT OFFICE SECTION")
            {
                group("The following items have been returned to office")
                {
                    field("Computer Equipment"; Rec."Computer Equipment")
                    {
                    }
                    field("Laptop password"; Rec."Laptop password")
                    {
                    }
                    field("Laptop bag, cable, Mouse"; Rec."Laptop bag, cable, Mouse")
                    {
                    }
                    field("Office Phone"; Rec."Office Phone")
                    {
                    }
                }
                group("ADMIN OFFICE SECTION")
                {
                    field("Library Books/Materials"; Rec."Library Books/Materials")
                    {
                    }
                    field("Office Keys"; Rec."Office Keys")
                    {
                    }
                }
            }
            group("HUMAN RESOURCE OFFICE SECTION ")
            {
                field("Medical card"; Rec."Medical card")
                {
                }
                field("Staff ID /Bus card"; Rec."Staff ID /Bus card")
                {
                }
                field("Handover confirmation"; Rec."Handover confirmation")
                {
                }
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
                enabled = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}