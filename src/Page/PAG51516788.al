page 50088 "Contract Party List"
{
    PageType = ListPart;
    SourceTable = 172780;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Name';
                }
                field(Town; Rec.Town)
                {
                    Caption = 'Address';

                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field(Email; Rec.Email)
                {
                    ExtendedDatatype = EMail;
                }
                field("Tel No."; Rec."Tel No.")
                {
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Company Name';
                }
            }
        }
    }

    actions
    {
    }
}

