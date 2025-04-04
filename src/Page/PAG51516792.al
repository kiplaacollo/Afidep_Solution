page 50092 "Expired Contracts Card"
{
    Editable = false;
    SourceTable = 172774;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field("Serial No.";  Rec."Serial No.")
                {
                }
                field(Parties;  Rec.Parties)
                {
                }
                field("Record Type";  Rec."Record Type")
                {
                    LookupPageID = "Record Type List";
                    TableRelation = "Record Type";
                }
                field("Internal Contract Owner";  Rec."Internal Contract Owner")
                {
                }
                field("Contract type";  Rec."Contract type")
                {
                    LookupPageID =  "Contract type list";
                    TableRelation = "Contract Type";
                }
                field(Status;  Rec.Status)
                {
                }
            }
            group("Contract Information")
            {
                field("Renewal type";  Rec."Renewal type")
                {
                    LookupPageID = "Contract type list";
                    TableRelation = "Renewal Type";
                }
                field("Notify period";  Rec."Notify period")
                {
                }
                field(Notify;  Rec.Notify)
                {
                }
                field("Contract Title";  Rec."Contract Title")
                {
                    Caption = '<Contract Title>';
                    Enabled = false;
                    Visible = false;
                }
                field("Contract Description";  Rec."Contract Description")
                {
                    Caption = 'Contract Description';
                }
                field("Commencement date";  Rec."Commencement date")
                {
                }
                field("Expiry Date";  Rec."Expiry Date")
                {
                }
                field(Comments;  Rec.Comments)
                {
                }
            }
            part("Contract Party List"; 50088)
            {
            }
        }
    }

    actions
    {
    }
}

