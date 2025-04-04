page 80174 "Payrol list M"
{
    PageType = List;
    CardPageId = "Payroll M card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payroll M";

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