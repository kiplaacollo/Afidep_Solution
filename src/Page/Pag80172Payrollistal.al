page 80172 "Payrol list"
{
    PageType = List;
    CardPageId = "Payroll card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Payroll;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field("Payroll Date"; Rec."Payroll Date")
                {
                    ToolTip = 'Specifies the value of the Payroll Date field.';
                }
                field("Payroll Period."; Rec."Payroll Period.")
                {
                    ToolTip = 'Specifies the value of the Payroll Period. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }

        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}