pageextension 50108 "DocAttachments" extends "Document Attachment Details"
{
    layout
    {
        // Add changes to page layout here
        addbefore("File Extension")
        {
            field(Comments;Rec.Comments)
            {
                ApplicationArea = all;
                
            }

        }

    }

    actions
    {
       
    }

    var
        myInt: Integer;
}