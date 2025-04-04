Table 170025 "HR Medical Scheme Members"
{
    DrillDownPageID = "HR Medical Scheme Members List";
    LookupPageID = "HR Medical Scheme Members List";

    fields
    {
        field(1;"Scheme No";Code[20])
        {
            TableRelation = "HR Medical Schemes"."Scheme No";

            trigger OnValidate()
            begin

                         Medscheme.Reset;
                         Medscheme.SetRange(Medscheme."Scheme No","Scheme No");
                          if Medscheme.Find('-') then begin
                          "Scheme Name":=Medscheme."Scheme Name";
                         //"Out-Patient Limit":=Medscheme."Out-patient limit";
                         //"In-patient Limit":=Medscheme."In-patient limit";
                         //"Balance In-Patient":="In-patient Limit"-"Cumm.Amount Spent In";
                         //"Balance Out-Patient":="Out-Patient Limit"-"Cumm.Amount Spent Out";
                          end;
            end;
        }
        field(2;"Employee No";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                         Emp.Reset;
                         Emp.SetRange(Emp."No.","Employee No");
                         if Emp.Find('-') then begin
                         "First Name":=Emp."First Name";
                         "Middle Name":=Emp."Middle Name";
                         "Last Name":=Emp."Last Name";
                         Designation:=Emp."Job Title";
                         "Global Dimension 1":=Emp."Global Dimension 1 Code";
                         "Scheme Join Date":=Emp."Medical Scheme Join";
                          end;
            end;
        }
        field(3;"First Name";Text[30])
        {
        }
        field(4;"Last Name";Text[30])
        {
        }
        field(5;Designation;Text[50])
        {
        }
        field(6;"Global Dimension 1";Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(7;"Scheme Join Date";Date)
        {
        }
        field(8;"Scheme Anniversary";Date)
        {
        }
        field(9;"Cumm.Amount Spent In";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=const(Inpatient),
                                                                          Period=field("Period Code")));
            FieldClass = FlowField;
        }
        field(10;"Out-Patient Limit";Boolean)
        {
        }
        field(11;"In-patient Limit";Boolean)
        {
        }
        field(12;"Maximum Cover";Decimal)
        {
            Editable = false;
        }
        field(13;"Cumm.Amount Spent Out";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=const(Outpatient),
                                                                          Period=field("Period Code")));
            FieldClass = FlowField;
        }
        field(14;"Balance Out-Patient";Decimal)
        {
        }
        field(15;"Balance In-Patient";Decimal)
        {
        }
        field(16;"Middle Name";Text[30])
        {
        }
        field(17;"Scheme Name";Text[50])
        {
        }
        field(18;"Scheme Category";Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Scheme Subcategory"."Scheme Category";

            trigger OnValidate()
            begin
                SCategory.Reset;
                SCategory.SetRange(SCategory."Scheme Number","Scheme No");
                SCategory.SetRange(SCategory."Scheme Category","Scheme Category");
                if SCategory.FindFirst then begin
                // "In-patient Limit":=SCategory.Inpatient;
                // "Out-Patient Limit":=SCategory.Outpatient;
                "Optical Limit":=SCategory.Optical;
                "Dental Limit":=SCategory.Dental;
                "Maternity Limit":=SCategory.Maternity;
                "Last Expense":=SCategory."Last Expense";
                "Balance In-Patient":=SCategory.Inpatient-"Cumm.Amount Spent In";
                "Balance Out-Patient":=SCategory.Outpatient-"Cumm.Amount Spent Out";
                end;
            end;
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
        field(22;"Last Expense";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23;"Optical Spent";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=filter(Optical),
                                                                          Claimed=filter(true),
                                                                          Period=field("Period Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24;"Dental Spent";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=filter(Dental),
                                                                          Claimed=const(true),
                                                                          Period=field("Period Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25;"Maternity Spent";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=filter(Maternity),
                                                                          Claimed=const(true),
                                                                          Period=field("Period Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26;"Period Code";Code[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Scheme No","Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Period.Reset;
        Period.SetRange(Closed,false);
        if Period.FindLast then
        begin
        "Period Code":=Period."Period Code";
        end;
    end;

    var
        Medscheme: Record "HR Medical Schemes";
        Emp: Record "HR Employees";
        SCategory: Record "Scheme Categories";
        Period: Record "Medical Periods";
}

