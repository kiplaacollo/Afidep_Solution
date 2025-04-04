tableextension 50101 "CustomerExtension" extends Customer
{
    fields
    {

        field(17207; "ID NO2"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17208; "KRA PIN2"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17209; Marketer2; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(17210; "Customer Type2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Customer,Unit';
            OptionMembers = ,Customer,Unit;
        }
        field(17211; "Unit Type2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit Types";
        }
        field(17212; "Unit ID4"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17213; "Tenant Full Name 33"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17214; Tenant22; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Tenants."No.";

            trigger OnValidate()
            begin
                Tenants.Reset;
                Tenants.SetRange(Tenants."No.", Tenant22);
                if Tenants.FindFirst then begin
                    "Tenant Full Name 33" := Tenants."Full Names";
                end;
            end;
        }
        field(17215; Property22; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Details".No;

            trigger OnValidate()
            var
                PropertyBillingLines: Record "Property Billing Lines";
                UnitBillingLines: Record "Unit Billing Lines";
            begin
                Properties.Reset;
                Properties.SetRange(Properties.No, Property22);
                if Properties.FindFirst then begin
                    "Property Name22" := Properties."Property Name";
                    PropertyBillingLines.Reset;
                    PropertyBillingLines.SetRange(PropertyBillingLines."Property Code", Properties.No);
                    if PropertyBillingLines.FindFirst then begin
                        repeat
                            UnitBillingLines.Init;
                            UnitBillingLines.EntryNo := PropertyBillingLines.EntryNo;
                            UnitBillingLines."Unit Code" := "No.";
                            UnitBillingLines.Ammenity := PropertyBillingLines.Ammenity;
                            UnitBillingLines.Description := PropertyBillingLines.Description;
                            UnitBillingLines.Rate := PropertyBillingLines.Rate;
                            UnitBillingLines.Insert;
                        until PropertyBillingLines.Next = 0;
                    end;
                end;

                "Account No2." := Property22 + Name;
            end;
        }
        field(17216; "Property Name22"; Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17217; "Account No2."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17218; "Unit Status3"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Vacant,Occupied';
            OptionMembers = ,Vacant,Occupied;
        }
        field(17219; "Date Of Birth2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17220; Location2; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17221; Age2; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17222; "User name2"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }

    }




    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: label 'Do you wish to create a contact for %1 %2?';
        SalesSetup: Record "Sales & Receivables Setup";
        CommentLine: Record "Comment Line";
        User: Record User;
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";

        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServiceItem: Record "Service Item";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CustomizedCalendarChange: Record "Customized Calendar Change";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        IdentityManagement: Codeunit "Identity Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CalendarManagement: Codeunit "Calendar Management";
        InsertFromContact: Boolean;
        Text003: label 'Contact %1 %2 is not related to customer %3 %4.';
        Text004: label 'post';
        Text005: label 'create';
        Text006: label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: label 'Cannot delete customer.';
        Text010: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';
        AllowPaymentToleranceQst: label 'Do you want to allow payment tolerance for entries that are currently open?';
        RemovePaymentRoleranceQst: label 'Do you want to remove payment tolerance from entries that are currently open?';
        CreateNewCustTxt: label 'Create a new customer card for %1', Comment = '%1 is the name to be used to create the customer. ';
        SelectCustErr: label 'You must select an existing customer.';
        CustNotRegisteredTxt: label 'This customer is not registered. To continue, choose one of the following options:';
        SelectCustTxt: label 'Select an existing customer';
        InsertFromTemplate: Boolean;
        LookupRequested: Boolean;
        OverrideImageQst: label 'Override Image?';
        PrivacyBlockedActionErr: label 'You cannot %1 this type of document when Customer %2 is blocked for privacy.', Comment = '%1 = action (create or post), %2 = customer code.';
        PrivacyBlockedGenericTxt: label 'Privacy Blocked must not be true for customer %1.', Comment = '%1 = customer code';
        ConfirmBlockedPrivacyBlockedQst: label 'If you change the Blocked field, the Privacy Blocked field is changed to No. Do you want to continue?';
        CanNotChangeBlockedDueToPrivacyBlockedErr: label 'The Blocked field cannot be changed because the user is blocked for privacy reasons.';
        PhoneNoCannotContainLettersErr: label 'You cannot enter letters in this field.';
        UserSetup: Record "User Setup";
        Properties: Record "Property Details";
        Tenants: Record Tenants;


}




