pageextension 17450 "Admin Role" extends "User Settings"
{
    layout
    {
        modify(UserRoleCenter)
        {
            Visible = AllowChangeRole;
        }
        modify(Company)
        {
            Visible = AllowChangeCompany;
        }
        modify("Work Date")
        {
            Visible = AllowChangeDate;
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        NoPermission: Label 'You do not have permission to open the my setting page. Please contact your system administrator!';
    begin
        AllowChangeCompany := false;
        AllowChangeRole := false;
        AllowChangeDate := false;
        if UserSetup.Get(UserId) then begin
            if UserSetup."Keep Change" then begin
                AllowChangeRole := UserSetup.Changes;
                AllowChangeCompany := UserSetup."Company Change";
                AllowChangeDate := UserSetup."Change Work Date";
                exit;
            end;
            Error(NoPermission);
        end;
    end;

    var
        AllowChangeRole: Boolean;
        AllowChangeCompany: Boolean;
        AllowChangeDate: Boolean;
}

pageextension 1749 AccountSeetingExt extends "User Settings List"
{

    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        NoPermission: Label 'You do not have permission to open the my setting page. Please contact your system administrator!';
    begin
        AllowChangeCompany := false;
        AllowChangeRole := false;
        AllowChangeDate := false;
        if UserSetup.Get(UserId) then begin
            if UserSetup."Keep Change" then begin
                AllowChangeRole := UserSetup.Changes;
                AllowChangeCompany := UserSetup."Company Change";
                AllowChangeDate := UserSetup."Change Work Date";
                exit;
            end;
            Error(NoPermission);
        end;
    end;

    var
        AllowChangeRole: Boolean;
        AllowChangeCompany: Boolean;
        AllowChangeDate: Boolean;
}