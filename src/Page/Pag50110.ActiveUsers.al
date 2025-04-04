//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50110 "Active User"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = User;
    SourceTableView = where(State = filter(Enabled));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Security ID"; Rec."User Security ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = Basic;
                }
                field("License Type"; Rec."License Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'License Type';
                    //Visible = not IsSaaS;
                    ToolTip = 'Specifies the type of license that applies to the user. For more information, see License Types.';
                }
                field("Authentication Email"; Rec."Authentication Email")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the Microsoft account that this user signs into Microsoft 365 or SharePoint Online with.';
                    //Visible = IsSaaS;
                }
            }
        }
    }

    actions
    {
    }
}




