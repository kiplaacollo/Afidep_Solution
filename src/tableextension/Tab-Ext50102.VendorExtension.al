tableextension 50102 "VendorExtension" extends Vendor
{
    fields
    {

        field(17204;"Vendor Type2";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Vendor,Landlord';
            OptionMembers = ,Vendor,Landlord;
        }
        field(17205;"ID Numbers2";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(17206;"Bank Account Number2";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17207;"Bank Name2";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17208;"Number Of Properties2";Integer)
        {
            CalcFormula = count("Property Details" where ("Property Owner"=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17209;"Contact Person2";Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(17210;"Vendor Category2";Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Categories".Code;

            trigger OnValidate()
            begin
                if SupplierCategories.Get("Vendor Category2") then
                  "Vendor Category Name2":=SupplierCategories.Description;
            end;
        }
        field(17211;"Vendor Category Name2";Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }

    
    
    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.';
        Text002: label 'You have set %1 to %2. Do you want to update the %3 price list accordingly?';
        Text003: label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "Purchases & Payables Setup";
        CommentLine: Record "Comment Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        //ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CustomizedCalendarChange: Record "Customized Calendar Change";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        LeadTimeMgt: Codeunit "Lead-Time Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CalendarManagement: Codeunit "Calendar Management";
        InsertFromContact: Boolean;
        Text004: label 'Contact %1 %2 is not related to vendor %3 %4.';
        Text005: label 'post';
        Text006: label 'create';
        Text007: label 'You cannot %1 this type of document when Vendor %2 is blocked with type %3';
        Text008: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.';
        Text009: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text010: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text011: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        SelectVendorErr: label 'You must select an existing vendor.';
        CreateNewVendTxt: label 'Create a new vendor card for %1.', Comment='%1 is the name to be used to create the customer. ';
        VendNotRegisteredTxt: label 'This vendor is not registered. To continue, choose one of the following options:';
        SelectVendTxt: label 'Select an existing vendor.';
        InsertFromTemplate: Boolean;
        PrivacyBlockedActionErr: label 'You cannot %1 this type of document when Vendor %2 is blocked for privacy.', Comment='%1 = action (create or post), %2 = vendor code.';
        PrivacyBlockedGenericTxt: label 'Privacy Blocked must not be true for vendor %1.', Comment='%1 = vendor code';
        ConfirmBlockedPrivacyBlockedQst: label 'If you change the Blocked field, the Privacy Blocked field is changed to No. Do you want to continue?';
        CanNotChangeBlockedDueToPrivacyBlockedErr: label 'The Blocked field cannot be changed because the user is blocked for privacy reasons.';
        PhoneNoCannotContainLettersErr: label 'You cannot enter letters in this field.';
        SupplierCategories: Record "Supplier Categories";



    
}
