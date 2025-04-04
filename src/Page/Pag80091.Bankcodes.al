Page 80091 "Bank codes"
{
    PageType = List;
    SourceTable = "Payroll Bank Codes_AU";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }


                field("Bank Name"; Rec."Bank Name")
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

