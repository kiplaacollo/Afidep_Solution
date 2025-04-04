pageextension 50107 "PQuotelines" extends "Purchase Quote Subform"
{
    layout
    {
    
        addbefore(Type)
        {
           
        }
        
        modify("Item Reference No.") { Visible = false; }
        modify("Tax Area Code") { Visible = false; }
        modify("Tax Group Code") { Visible = false; }
        modify("Tax Liable") { Visible = false; }
        modify("Line Discount %") { Visible = false; }
        modify("Job Line Discount %") { Visible = false; }

    }

    actions
    {
    
    }

    var
        myInt: Integer;
}