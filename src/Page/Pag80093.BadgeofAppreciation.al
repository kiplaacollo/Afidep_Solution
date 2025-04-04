Page 80093 "Badge of Appreciation"
{
    Caption = 'Badge of Appreciation';
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appreciation Title";Rec."Appreciation Title")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Picture";Rec."Employee Picture")
                {
                    ApplicationArea = Basic;
                }
                field("Appreciation Narration";Rec."Appreciation Narration")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
    }
}

