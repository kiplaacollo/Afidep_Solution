Table 170032 "Scheme Balances"
{
    DrillDownPageID = "HR Medical Scheme Members List";
    LookupPageID = "HR Medical Scheme Members List";

    fields
    {
        field(1;"Medical Period";Code[40])
        {
            TableRelation = "HR Medical Schemes"."Scheme No";
        }
        field(2;"Employee No";Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(9;"Cumm.Amount Spent In";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=const(Inpatient)));
            FieldClass = FlowField;
        }
        field(10;"Out-Patient Limit";Decimal)
        {
        }
        field(11;"In-patient Limit";Decimal)
        {
        }
        field(13;"Cumm.Amount Spent Out";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=const(Outpatient)));
            FieldClass = FlowField;
        }
        field(14;"Balance Out-Patient";Decimal)
        {
        }
        field(15;"Balance In-Patient";Decimal)
        {
        }
        field(17;"Scheme Name";Text[50])
        {
        }
        field(19;"Optical Limit";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20;"Dental Limit";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21;"Maternity Limit";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23;"Optical Spent";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=filter(Optical),
                                                                          Claimed=filter(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24;"Dental Spent";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=filter(Dental),
                                                                          Claimed=const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25;"Maternity Spent";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=filter(Maternity),
                                                                          Claimed=const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26;"Closed By";Code[80])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Medical Period","Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Medscheme: Record "HR Medical Schemes";
        Emp: Record "HR Employees";
        SCategory: Record "Scheme Categories";
}

