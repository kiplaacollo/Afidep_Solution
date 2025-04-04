Table 170039 "HR Disciplinary Cases NCA"
{
    DrillDownPageID = "HR Disciplinary Cases List";
    LookupPageID = "HR Disciplinary Cases List";

    fields
    {
        field(1;"Case Number";Code[20])
        {
        }
        field(3;Date;Date)
        {
        }
        field(4;"Type of Complaint";Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where (Type=const("Disciplinary Case"));

            trigger OnValidate()
            begin
                LookUp.Reset;
                LookUp.SetRange(Type,LookUp.Type::"Disciplinary Case");
                LookUp.SetRange(Code,"Type of Complaint");
                if LookUp.Find('-') then
                  "Type of Complaint Description" := LookUp.Description
                else
                  Clear("Type of Complaint Description");
            end;
        }
        field(5;"Recommended Action";Code[20])
        {
            TableRelation = "HR Disciplinary Actions"."Action Code";

            trigger OnValidate()
            begin
                DisciActions.Reset;
                DisciActions.SetRange(DisciActions."Action Code","Recommended Action");
                if DisciActions.Find('-') then
                "Recommended Action Description":=DisciActions."Recommended Action";
            end;
        }
        field(6;"Description of Complaint";Text[250])
        {
        }
        field(7;Reporter;Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if "Accused Employee"=Reporter then
                Error('An employee cannot accuse his/her self');

                Emp.Reset;
                Emp.SetRange(Emp."No.",Reporter);
                if Emp.Find('-')then
                "Reporter Name":=Emp."First Name"+' '+Emp."Middle Name"+' '+Emp."Last Name";
            end;
        }
        field(8;"Witness #1";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.","Witness #1");
                if Emp.Find('-')then
                "Witness #1 Name":=Emp."First Name"+' '+Emp."Middle Name"+' '+Emp."Last Name";
            end;
        }
        field(9;"Witness #2";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.","Witness #2");
                if Emp.Find('-')then
                "Witness #2  Name":=Emp."First Name"+' '+Emp."Middle Name"+' '+Emp."Last Name";
            end;
        }
        field(10;"Action Taken";Code[20])
        {
            TableRelation = "HR Disciplinary Actions"."Action Code";

            trigger OnValidate()
            begin
                DisciActions.Reset;
                DisciActions.SetRange(DisciActions."Action Code","Action Taken");
                if DisciActions.Find('-') then
                "Taken Action Description":=DisciActions."Recommended Action";
            end;
        }
        field(11;"Date To Discuss Case";Date)
        {
        }
        field(12;"Document Link";Text[200])
        {
        }
        field(13;"Disciplinary Remarks";Text[250])
        {
        }
        field(14;Comments;Text[250])
        {
        }
        field(15;"Case Discussion";Boolean)
        {
        }
        field(16;"Body Handling The Complaint";Code[100])
        {
            TableRelation = "HR Committees".Code;

            trigger OnValidate()
            begin
                Committees.Reset;
                Committees.SetRange(Committees.Code,"Body Handling The Complaint");
                if Committees.Find('-') then
                "Body Handling Name":=Committees.Description;
            end;
        }
        field(17;Recomendations;Code[10])
        {
        }
        field(18;"HR/Payroll Implications";Integer)
        {
        }
        field(19;"Support Documents";Option)
        {
            OptionMembers = Yes,No;
        }
        field(20;"Policy Guidlines In Effect";Code[10])
        {
            TableRelation = "HR Policies".Code;

            trigger OnValidate()
            begin
                Policies.Reset;
                Policies.SetRange(Policies.Code,"Policy Guidlines In Effect");
                if Policies.Find('-') then
                "Policy Description":=Policies."Document Description";
            end;
        }
        field(21;Status;Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(22;"Mode of Lodging the Complaint";Text[30])
        {
        }
        field(23;"No. Series";Code[20])
        {
        }
        field(24;"Accused Employee";Code[30])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.","Accused Employee");
                if Emp.Find('-')then
                "Accused Employee Name":=Emp."First Name"+' '+Emp."Middle Name"+' '+Emp."Last Name";
            end;
        }
        field(25;Selected;Boolean)
        {
        }
        field(26;"Closed By";Code[20])
        {
        }
        field(27;"Body Handling Name";Text[50])
        {
        }
        field(28;"Policy Description";Text[50])
        {
        }
        field(29;"Taken Action Description";Text[50])
        {
        }
        field(30;"Recommended Action Description";Text[50])
        {
        }
        field(3963;"Responsibility Center";Code[10])
        {
        }
        field(3964;"Reporter Name";Text[40])
        {
        }
        field(3965;"Witness #1 Name";Text[50])
        {
        }
        field(3966;"Witness #2  Name";Text[50])
        {
        }
        field(3967;"Disciplinary Stage Status";Option)
        {
            Editable = false;
            OptionCaption = 'Reported,Under Investigation,In progress,Closed,Under review';
            OptionMembers = Reported,"Under Investigation","In progress",Closed,"Under review";
        }
        field(3968;"Document Type";Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Store Requisition,Employee Requisition,Leave Application,Transport Requisition,Training Requisition,Job Approval,Induction Approval,Disciplinary Approvals,Activity Approval';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval";
        }
        field(3969;"User ID";Code[50])
        {
        }
        field(3970;"Accused Employee Name";Text[100])
        {
        }
        field(3971;"Accussed By";Option)
        {
            OptionMembers = Employee,"Non-Employee";
        }
        field(3972;"Non Employee Reporter";Text[100])
        {

            trigger OnValidate()
            begin
                    if "Accussed By"="accussed by"::Employee then
                     Error('You are not allowed to Type Name if accused is an employee');
            end;
        }
        field(3973;Appealed;Boolean)
        {
        }
        field(50000;"Date of Complaint was Reported";Date)
        {
        }
        field(50001;"Severity Of the Complain";Option)
        {
            OptionMembers = Major,Minor;
        }
        field(50002;"Review Findings";Text[250])
        {
        }
        field(50003;"Action Duration Start Date";Date)
        {
        }
        field(50004;"Action Duration End  Date";Date)
        {
        }
        field(50005;"Manager/Supervisor";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                if Emp.Get("Manager/Supervisor") then
                "Manager/Supervisor Name" := Emp."First Name"+' '+Emp."Middle Name"+' '+Emp."Last Name"
                else
                "Manager/Supervisor Name" := '';
            end;
        }
        field(50006;"Manager/Supervisor Name";Text[100])
        {
        }
        field(50007;"Interdict Employee";Boolean)
        {
        }
        field(50008;"Interdiction Duration";Text[50])
        {
        }
        field(50009;"Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(50010;"Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(50011;"No. of Appeals";Integer)
        {
        }
        field(50012;"Violation Place";Text[30])
        {
        }
        field(50013;"Violation Date";Date)
        {
        }
        field(50014;"Violation Time";Time)
        {
        }
        field(50015;"Manager/Supervisor Statament";Text[250])
        {
        }
        field(50016;"Employee Statement";Text[250])
        {
        }
        field(50017;"Action Taken By Whom";Text[50])
        {
        }
        field(50018;"Action Taken By When";Date)
        {
        }
        field(50019;"Type of Complaint Description";Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Case Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Case Number" = '' then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Disciplinary Cases Nos.");
          NoSeriesMgt.InitSeries(HRSetup."Disciplinary Cases Nos.",xRec."No. Series",0D,"Case Number","No. Series");
        end;

         "User ID":=UserId;
         Date:=Today;
    end;

    trigger OnModify()
    begin
          /*IF Status=Status::"" THEN
          ERROR('You cannot modify a case Under Investigation');
           */

    end;

    var
        HRSetup: Record "HR Setups";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Emp: Record "HR Employees";
        Committees: Record "HR Committees";
        Policies: Record "HR Policies";
        LookUp: Record "HR Lookup Values";
        DisciActions: Record "HR Disciplinary Actions";
}

