page 50084 "Portal Document upload"
{
    Caption = 'Portal Document upload';
    PageType = ListPart;
    SourceTable = "Portal Document upload";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Url; Rec.Url)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Url field.';
                }
                field(Uploaded; Rec.Uploaded)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Uploaded field.';
                }
            }
        }
    }
}
