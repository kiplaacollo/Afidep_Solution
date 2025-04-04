Table 50013 "Target Setting Header"
{

    fields
    {
        field(1;"Workplan No";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                /* IF "Workplan No" <>xRec."Workplan No" THEN BEGIN
                PerformanceSetup.GET;
                NoSeriesMgt.TestManual(PerformanceSetup."Workplan Application Nos");
                "No. Series" := '';
                END;*/

            end;
        }
        field(2;"Workplan Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3;"Staff No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmployees.Reset;
                HREmployees.SetRange(HREmployees."No.","Staff No");
                if HREmployees.FindFirst then begin
                "Staff Name":=HREmployees."First Name"+' '+HREmployees."Last Name";
                end;
            end;
        }
        field(4;"Staff Name";Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;Period;Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6;"Staff Department";Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('DEPARTMENTS'));
        }
        field(7;"No. Series";Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8;User;Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;Status;Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Posted';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected,Posted;
        }
    }

    keys
    {
        key(Key1;"Workplan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
         if "Workplan No" = '' then begin
         PerformanceSetup.Get();
         PerformanceSetup.TestField(PerformanceSetup."Workplan Application Nos");
         NoSeriesMgt.InitSeries(PerformanceSetup."Workplan Application Nos",xRec."No. Series",0D,"Workplan No","No. Series");
         end;
        "Workplan Date":=Today;
        HREmployees.Reset;
        HREmployees.SetRange(HREmployees."User ID",UserId);
        if HREmployees.FindFirst then begin
        "Staff No":=HREmployees."No.";
        "Staff Name":=HREmployees."First Name"+' '+HREmployees."Last Name";
        end;
        User:=UserId;
        AppraisalPeriods.Reset;
        AppraisalPeriods.SetRange(AppraisalPeriods.Open,true);
        if AppraisalPeriods.FindFirst then begin
        Period:=AppraisalPeriods.Code;
        end;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PerformanceSetup: Record "PMS Setup";
        Employees: Record Employee;
        WPPeriods: Record "Appraisal Periods";
        Users: Record "User Setup";
        HREmployees: Record "HR Employees";
        AppraisalPeriods: Record "Appraisal Periods";
}

