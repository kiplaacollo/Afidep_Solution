page 50089 "Portal Uploads"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SharePoint Intergration";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Document No"; Rec."Document No") { ApplicationArea = all; Editable = false; }
                field(LocalUrl; Rec.LocalUrl) { ApplicationArea = all; Visible = false; }
                field(Description; Rec.Description) { ApplicationArea = all; Editable = false; }
                field(Uploaded; Rec.Uploaded) { ApplicationArea = all; Editable = false; }
                field(Fetch_To_Sharepoint; Rec.Fetch_To_Sharepoint) { ApplicationArea = all; Editable = false; }
                field(Polled; Rec.Polled) { ApplicationArea = all; Editable = false; }
                field(Base_URL; Rec.Base_URL) { ApplicationArea = all; Visible = false; }
                field(SP_URL_Returned; Rec.SP_URL_Returned) { ApplicationArea = all; Editable = false; ExtendedDatatype = URL; }
                field(Failure_reason; Rec.Failure_reason) { ApplicationArea = all; Editable = false; }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}