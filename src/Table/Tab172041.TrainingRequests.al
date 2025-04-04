Table 172041 "Training Requests"
{

    fields
    {
        field(1;"Employee Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                //IF HREmployees.GET(emplo
            end;
        }
        field(2;"Employee Name";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Training Need";Text[250])
        {
            Caption = 'What is the training/development need?';
            DataClassification = ToBeClassified;
        }
        field(4;"Employees Involved";Text[250])
        {
            Caption = 'What are the names of employees involved in the training?';
            DataClassification = ToBeClassified;
        }
        field(5;"Business Linkage";Text[250])
        {
            Caption = 'How does this link with the business of NCCK and the responsibilities of your own programme/post?';
            DataClassification = ToBeClassified;
        }
        field(6;"Job Relation";Text[250])
        {
            Caption = 'Explain how the proposed training/development activity relates to your own job.';
            DataClassification = ToBeClassified;
        }
        field(7;"Hope to Learn";Text[250])
        {
            Caption = 'What do you hope to learn?';
            DataClassification = ToBeClassified;
        }
        field(8;"Details of Training";Text[250])
        {
            Caption = 'Details of training (Training dates, venue, organisation name and contact details)';
            DataClassification = ToBeClassified;
        }
        field(9;"Other Details";Text[250])
        {
            Caption = 'Other details (e.g. cost of training, accommodation, transport and related costs and grant available)';
            DataClassification = ToBeClassified;
        }
        field(10;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(11;"Application Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                  HRSetup.Get;
                  NoSeriesMgt.TestManual(HRSetup."Training Application Nos.");
                  "No series" := '';
                end;
            end;
        }
        field(17;"No series";Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Employee Code","Training Need","Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Application Code" = '' then
        begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Training Application Nos.");
          NoSeriesMgt.InitSeries(HRSetup."Training Application Nos.",xRec."No series",0D,"Application Code","No series");
        end;
    end;

    var
        HREmployees: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

