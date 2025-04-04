Table 170112 "HR Profile Qualifications"
{
    Caption = 'HR Applicant Qualifications';
    DataCaptionFields = "Employee No.";
    // DrillDownPageID = UnknownPage53960;
    // LookupPageID = UnknownPage53960;

    fields
    {
        field(1;"Application No";Code[50])
        {
            Caption = 'Application No';
        }
        field(2;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
        }
        field(3;"Qualification Description";Code[80])
        {
            Caption = 'Qualification Description';
            NotBlank = true;

            trigger OnValidate()
            begin
                /*
                Qualifications.RESET;
                Qualifications.SETRANGE(Qualifications.Code,"Qualification Description");
                IF Qualifications.FIND('-') THEN
                "Qualification Code":=Qualifications.Description;
                */

            end;
        }
        field(4;"From Date";Date)
        {
            Caption = 'From Date';
        }
        field(5;"To Date";Date)
        {
            Caption = 'To Date';
        }
        field(6;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7;Description;Text[30])
        {
            Caption = 'Description';
        }
        field(8;"Institution/Company";Text[30])
        {
            Caption = 'Institution/Company';
        }
        field(9;Cost;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10;"Course Grade";Text[30])
        {
            Caption = 'Course Grade';
        }
        field(11;"Employee Status";Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(13;"Expiration Date";Date)
        {
            Caption = 'Expiration Date';
        }
        field(14;"Qualification Type";Code[20])
        {
            NotBlank = false;
            TableRelation = "Scheme Balances"."Employee No" where ("Medical Period"=filter('5'));
        }
        field(15;"Qualification Code";Text[200])
        {
            NotBlank = true;
            TableRelation = "Medical Periods"."Period Start Date" where ("Period Code"=field("Qualification Type"));

            trigger OnValidate()
            begin
            
            end;


        }
        field(16;"Score ID";Decimal)
        {
        }
        field(17;EntryNo;Integer)
        {
            AutoIncrement = true;
        }
        field(18;Period;Text[250])
        {

            trigger OnValidate()
            begin
                // Period:= Dates.DetermineAge("From Date","To Date");
            end;
        }
    }

    keys
    {
        key(Key1;EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        Validate(Period);
    end;

    var
        HRQualifications: Record "Medical Periods";
        Applicant: Record "HR Job Applications";
        Position: Code[20];
        Dates: Codeunit "HR Leave Jnl.-Post";

    local procedure CheckQualification()
    var
        Qualified: Boolean;
    begin
    end;
}

