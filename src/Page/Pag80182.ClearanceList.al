page 80182 "Clearance List"
{
    PageType = List;
    CardPageId = "Clearance Form";
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Clearance;

    layout
    {
        area(Content)
        {
            repeater(Control1)
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