//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172925 "Crm Nos series Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = false;
    SourceTable = "Crm General Setup.";
    Editable = true;
    //enabled = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Lead Nos"; Rec."Lead Nos")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("General Enquiries Nos"; Rec."General Enquiries Nos")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cases nos"; Rec."Cases nos")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Crm logs Nos"; Rec."Crm logs Nos")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin

        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}




