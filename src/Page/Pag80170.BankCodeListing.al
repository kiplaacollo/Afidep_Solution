page 80170 "Bank Codes Listing"
{
    Caption = 'Bank Codes Listing';
    PageType = List;
    SourceTable = "Bank Code Listing";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bank Narration"; Rec."Bank Narration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Narration field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
                field("Branch Address"; Rec."Branch Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Address field.';
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telephone field.';
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fax Number field.';
                }
                
            }
        }
    }
}
