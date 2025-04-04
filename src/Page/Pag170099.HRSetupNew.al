Page 170099 "HR Setup New"
{
    SourceTable = "HR Setups";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Interview Nos"; Rec."Exit Interview Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Succession Planning Nos."; Rec."Succession Planning Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Claims Nos"; Rec."Medical Claims Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Incident Nos."; Rec."Incident Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Investigation Nos."; Rec."Investigation Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Advocate Nos."; Rec."Advocate Nos.")
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

