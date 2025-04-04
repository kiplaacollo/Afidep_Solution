pageextension 17356 "Organisation Ext" extends "Contact Card"
{
    layout
    {
        addafter("Company Name")
        {
            field("About funder"; Rec."About funder")
            {
                Editable = true;
                ToolTip = 'Specifies the more information about the organisation.';
                MultiLine = true;
                caption = 'Organisation Brief';
                RowSpan = 10;
                Visible = OrgType;

            }
            field("Funding history"; Rec."Funding history")
            {
                Editable = true;
                MultiLine = true;
                RowSpan = 10;
                Caption = 'Funding history with similar / other organisations';
                Visible = OrgType;
            }
            field("Funding history with afidep"; Rec."Funding history with afidep")
            {
                MultiLine = true;
                RowSpan = 10;
                Editable = true;
                Caption = 'Funding hisotry with afidep';
                Visible = OrgType;
            }
        }
        addafter(General)
        {
            part(Contact; "Contact List part")
            {
                applicationArea = All;
                SubPageLink = "Company No." = field("Company No.");
            }//
        }
    }
    actions
    {

    }
    var
        OrgType: Boolean;

    trigger OnAfterGetRecord()
    begin
        UpdateOrgTypefVisibility();
    end;

    trigger OnOpenPage()
    begin
        UpdateOrgTypefVisibility();
    end;

    procedure UpdateOrgTypefVisibility()
    begin
        if Rec."Type" = Rec."Type"::Person then
            OrgType := false
        else
            if Rec."Type" = Rec."Type"::Company then
                OrgType := true;
    end;
}
