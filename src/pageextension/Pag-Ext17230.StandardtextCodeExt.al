pageextension 17230 "Standard text Code Ext" extends "Standard Text Codes"
{
    layout
    {
        addafter(Description)
        {
            field("GL Account"; Rec."G/L Account")
            {

            }
        }
    }
}
