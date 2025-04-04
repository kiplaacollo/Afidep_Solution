page 17392 "RFQ Subform"
{
    PageType = ListPart;
    SourceTable = "Purchase Quote Line";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                    Caption = ' Specifications';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                }
                field("PRF No"; Rec."PRF No")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Specification")
            {
                Caption = 'Set Specification';

                trigger OnAction()
                var
                    PParams: Record "170166";
                begin
                    PParams.RESET;
                    PParams.SETRANGE(PParams."Document Type", Rec."Document Type");
                    PParams.SETRANGE(PParams."Document No.", Rec."Document No.");
                    PParams.SETRANGE(PParams."Line No.", Rec."Line No.");
                    PAGE.RUN(90780, PParams);
                end;
            }
        }
    }
}

