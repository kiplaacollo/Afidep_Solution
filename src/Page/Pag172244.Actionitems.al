page 172244 "Action items "
{
    ApplicationArea = All;
    Caption = 'Action items ';
    PageType = ListPart;
    SourceTable = "Action items meeting tacker";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Action item"; Rec."Action item")
                {
                    ToolTip = 'Specifies the value of the Action item field.';
                }
                field("Action by"; rec.ActionByStaff)
                {

                }

                field("Action by Whom"; Rec."Action by Whom Staff")
                {
                    ToolTip = 'Specifies the value of the Action by Whom field.';
                    TableRelation = "HR Employees"."No.";
                    trigger OnValidate()
                    var
                        emp: Record "HR Employees";
                    begin
                        emp.get(Rec."Action by Whom Staff");
                        Rec."Staff name" := emp."First Name" + ' ' + emp."Last Name";
                    end;

                }
                field("Staff Name"; Rec."Staff Name")
                {

                }
                field("By when"; Rec."By when")
                {
                    ToolTip = 'Specifies the value of the By when field.';
                }
            }
        }
    }
}
