table 170043 "Project Budget"
{
    Caption = 'Project Budget';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[50])
        {
            Caption = 'No';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECTS'));
            trigger
            OnValidate()
            var
                Dimension: Record "Dimension Value";
            begin
                Dimension.Reset();
                Dimension.SetRange(Code, No);
                if Dimension.FindFirst() then begin

                    Title := Dimension.Name;
                end;
            end;
        }
        field(2; Title; Text[2048])
        {
            Caption = 'Title';
            Editable = false;
        }
        field(3; "Title 2"; Text[2048])
        {
            Caption = 'Title 2';
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = ',Project';
            OptionMembers = "",Project;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(7; "Agreement No"; Code[50])
        {
            Caption = 'Agreement No';
        }
        field(8; "Sub Award No"; Code[50])
        {
            Caption = 'Sub Award No';
        }
        field(9; "Person Responsible"; Code[50])
        {
            Caption = 'Person Responsible';
            TableRelation = "HR Employees"."No.";
        }
        field(10; "Branch Code"; Code[50])
        {
            Caption = 'Branch Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('BRANCH'));
        }
        field(11; "Period Performance"; Option)
        {
            Caption = 'Period Performance';
            OptionMembers = " ","One Year","Two Years","Multiple Years";
        }
        field(12; Objective; Code[50])
        {
            Caption = 'Objective';
        }
        field(13; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionMembers = " ",Blocked;
        }
        field(14; "Responsibility Center"; Code[50])
        {
            Caption = 'Responsibility Center';
        }
        field(15; "Email"; Code[50])
        {
            Caption = 'Email ';
        }
        field(16; "Approval Satus"; Option)
        {
            Caption = 'Aprroval Satus';
            OptionCaption = 'Open,Approved';
            OptionMembers = open,Approved;
        }
        field(17; "Amount Awarded"; Decimal)
        {
            Caption = 'Amount Awarded';
        }
        field(18; "Remaining Balance"; Decimal)
        {
            Caption = 'Remaining Balance';
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Dimension Value"."Budget Amount" where(Code = field(No)));
            Editable = false;
        }
        field(20; "Received Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Project Budget"."Amount Awarded" where(No = field(No)));
            Editable = false;
        }
        field(21; "Burn rate %"; Decimal)
        {

        }
        field(22; Commentary; Text[2048])
        {

        }
        field(23; Funding; Option)
        {
            OptionMembers = "","Staff costs","Travel costs"," Accomodation and subsistence","Consultancy","Partner's costs","Other Direct costs","Overheads";
            OptionCaption = ',Staff costs,Travel costs, Accomodation and subsistence,Consultancy,Partners costs,Other Direct costs,Overheads';
        }

    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
