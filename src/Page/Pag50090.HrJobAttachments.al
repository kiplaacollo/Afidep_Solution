page 50098 "Job App Attachments List"
{
    PageType = ListPart;
    SourceTable = "Job Attachments";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job ID"; Rec."Job ID") { ApplicationArea = Basic; }
                field(Description; Rec.Description) { ApplicationArea = Basic; }

                // Clickable link / button
                field(OpenAttachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                    Caption = 'Open';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        OpenAttachmentOrFolder();   // call helper
                    end;
                }
            }
        }
    }

    local procedure OpenAttachmentOrFolder()
    var
        BasePath: Text[250];
        FullPath: Text[250];
    begin
        // 1) Base path where all Job folders sit
        BasePath := '\\AfidepERP\JobApplicationDocuments\';

        // === OPTION A – open folder (uncomment this, comment OPTION B) ===
        // FullPath := BasePath + Rec."Job ID";

        // === OPTION B – open specific file (uncomment if Attachment = file name) ===
        FullPath := BasePath + Rec."Job ID" + '\' + Rec.Attachment;

        // Open in default program / File Explorer
        HYPERLINK(FullPath);
    end;
}
