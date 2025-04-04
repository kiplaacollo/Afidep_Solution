table 50028 "Staff Cue"
{
    Caption = 'Staff Dashboard Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(7; "Purchase Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order),
                                                         "Assigned User ID" = FIELD("User ID Filter")));
            Caption = 'LPO';
            FieldClass = FlowField;
        }

        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(22; "Travel/Expenditure New "; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST(Open), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Imprest Accounting')));
            Caption = 'Travel/Expenditure New';
            FieldClass = FlowField;
        }
        field(23; "Travel/Expenditure Pending Approval"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST("Pending Approval"), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Imprest Accounting')));
            Caption = 'Travel/Expenditure Pending Approval';
            FieldClass = FlowField;
        }
        field(24; "Travel/Expenditure Approved"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST(Released), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Imprest Accounting')));
            Caption = 'Travel/Expenditure Approved';
            FieldClass = FlowField;
        }
        field(25; "Travel/Expenditure Vouchers Posted"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST(Released), "Assigned User ID" = FIELD("User ID Filter"), Posted = filter(true), "AU Form Type" = filter('Imprest Accounting')));
            Caption = 'Travel/Expenditure Vouchers Posted';
            FieldClass = FlowField;
        }
        field(26; "Imprest Requisition New"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST(Open), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Imprest Requisition')));
            FieldClass = FlowField;
        }
        field(27; "Imprest Requisition Pending Approval"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST("Pending Approval"), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Imprest Requisition')));
            FieldClass = FlowField;
        }
        field(28; "Imprest Requisition Approved"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST(Released), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Imprest Requisition')));
            FieldClass = FlowField;
        }
        field(32; "Purchase Request New - All"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST(Open), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Purchase Request')));
            FieldClass = FlowField;
        }
        field(33; "Purchase Request Pending Approval - All"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST("Pending Approval"), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Purchase Request')));
            FieldClass = FlowField;
        }
        field(34; "Purchase Request Approved - All"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST(Released), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Purchase Request')));
            FieldClass = FlowField;
        }

        field(35; "Leave Application New"; Integer)
        {
            CalcFormula = Count("HR Leave Application" WHERE(Status = CONST(new), "User ID" = FIELD("User ID Filter")));
            FieldClass = FlowField;
        }
        field(36; "Leave Application Pending Approval"; Integer)
        {
            CalcFormula = Count("HR Leave Application" WHERE(Status = CONST("Pending Approval"), "User ID" = FIELD("User ID Filter")));
            FieldClass = FlowField;
        }
        field(37; "Leave Application Approved"; Integer)
        {
            CalcFormula = Count("HR Leave Application" WHERE(Status = CONST(Approved), "User ID" = FIELD("User ID Filter")));
            FieldClass = FlowField;
        }
        field(38; "Leave Application Posted"; Integer)
        {
            CalcFormula = Count("HR Leave Application" WHERE(Status = CONST(Posted), "User ID" = FIELD("User ID Filter")));
            FieldClass = FlowField;
        }
        field(39; "Leave Application Rejected"; Integer)
        {
            CalcFormula = Count("HR Leave Application" WHERE(Status = CONST(Rejected), "User ID" = FIELD("User ID Filter")));
            FieldClass = FlowField;
        }
        field(40; "Payment Voucher New - All"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST(Open), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Payment Voucher')));
            FieldClass = FlowField;
        }
        field(41; "Payment Voucher Pending Ap"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST("Pending Approval"), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Payment Voucher')));
            FieldClass = FlowField;
        }
        field(42; "Payment Voucher Approved - All"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Status = CONST(Released), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Payment Voucher')));
            FieldClass = FlowField;
        }
        field(43; "Payment Voucher Posted - All"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Posted = filter(true), "Assigned User ID" = FIELD("User ID Filter"), "AU Form Type" = filter('Payment Voucher')));
            FieldClass = FlowField;
        }
        field(44; "Imprest Accounting Approved K"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Posted = filter(false), Status = CONST(Released), "AU Form Type" = filter('Imprest Accounting'), "Shortcut Dimension 1 Code" = filter('KENYA')));
            FieldClass = FlowField;
        }
        field(45; "Imprest Accounting Approved M"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Posted = filter(false), Status = CONST(Released), "AU Form Type" = filter('Imprest Accounting'), "Shortcut Dimension 1 Code" = filter('MALAWI')));
            FieldClass = FlowField;
        }


    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

