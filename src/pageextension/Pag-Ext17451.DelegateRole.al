pageextension 17451 "Delegate Role" extends "Approval Entries"
{
    layout
    {
        // Layout modifications if needed
    }

    actions
    {
        // Modify the visibility of the "Delegate" action
        modify("&Delegate")
        {
            Visible = AllowChangeRole;  // Show the Delegate action only if the user has delegation rights
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        NoPermission: Label 'You do not have permission to view approval entries. Please contact your system administrator!';
    begin
        // Initially, set the AllowChangeRole to false (default: no delegation rights)
        AllowChangeRole := false;

        // Get the current user's setup based on the UserId
        if UserSetup.Get(UserId) then begin
            // Check if the user has delegation rights
            if UserSetup."Delegation Rights" then begin
                AllowChangeRole := true;  // User has delegation rights
                exit;
            end;
        end;

        // If the user doesn't have delegation rights, show an error message
        //  Error(NoPermission);
    end;

    var
        AllowChangeRole: Boolean;  // Variable to control visibility of the Delegate action based on delegation rights
}
