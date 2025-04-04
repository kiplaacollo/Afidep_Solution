table 172765 EngagementsPlanner
{
    Caption = 'EngagementsPlanner';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Code[100])
        {
            Caption = 'Name';
        }
        field(3; Priority; Option)
        {
            OptionMembers = "",P1,P2,P3,P4;
        }
        field(4; Location; Code[50])
        {
            Caption = 'Location';
        }
        field(5; "Target type"; Code[100])
        {
            Caption = 'Target type';
        }
        field(6; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(7; "Level of giving"; Text[2040])
        {
            Caption = 'Level of giving';
        }
        field(8; "Website "; Text[100])
        {
            Caption = 'Website ';
        }
        field(9; "Key decision makers"; Text[2048])
        {
            Caption = 'Key decision makers';
        }
        field(10; "Fundraising method"; Text[2048])
        {
            Caption = 'Fundraising method';
        }
        field(11; "Stage of process"; Option)
        {
            Caption = 'Stage of process';
            OptionMembers = "","Research and Evaluation","Raising Awareness","Engagement","Asking for a Commitment","Retention and New Engagement";
        }
        field(12; "Amount asked"; Text[2048])
        {
            Caption = 'Amount asked';
        }
        field(13; "Ask date"; Text[100])
        {
            Caption = 'Ask date';
        }
        field(14; "Likelihood of gift"; Option)
        {
            OptionMembers = "","30%","50%","80%";
        }
        field(15; "Timing of gift completion"; Text[100])
        {
            Caption = 'Timing of gift completion';
        }
        field(16; "Estimated funds"; Text[100])
        {
            Caption = 'Estimated funds';
        }
        field(17; "Next steps"; Text[2048])
        {
            Caption = 'Next steps';
        }
        field(18; "Timeline of activity"; Code[50])
        {
            Caption = 'Timeline of activity';
        }
        field(19; Who; Code[50])
        {
            Caption = 'Who';
        }
        field(20; "Quartely updates"; Text[2048])
        {
            Caption = 'Quartely updates';
        }


        field(21; Converted; Boolean) { }

        field(22; "Year first submitted"; Text[2048])
        {
            Caption = 'Year first submitted';
        }
        field(23; "Year of decision"; Text[2048])
        {
            Caption = 'Year of decision';
        }
        field(24; "Engagement + deadline"; Text[2048])
        {
            Caption = 'Engagement + deadline';
        }
        field(25; "Funder"; code[50])
        {
            TableRelation = Contact WHERE(Type = FILTER('Company'));
            Caption = 'Organisation';
            trigger OnValidate()
            var
                Cont: Record Contact;
            begin
                Cont.Reset();
                Cont.SetRange(Cont."No.", Funder);
                if Cont.FindFirst() then begin
                    "Funder Name" := Cont.Name;
                    "About funder" := Cont."About funder";
                    "Funding history" := Cont."Funding history";
                    "Funding history with afidep" := Cont."Funding history with afidep";
                end;
            end;
        }
        field(26; "About funder"; Text[2048])
        {
            Caption = 'About Organisation';
        }
        field(27; "Duration"; Text[2048])
        {
            Caption = 'Duration in months';
        }
        field(43; "focus area code"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('THEMATIC'));
            trigger
            OnValidate()
            var
                Dim: Record "Dimension Value";
            begin
                Dim.Reset();
                Dim.SetRange(Code, "focus area code");
                if Dim.FindFirst() then begin
                    "Focus area" := Dim.Name;
                end;
            end;
        }
        field(28; "Focus area"; Text[100])
        {
            //OptionMembers = "","Population Dynamics and Demographic Dividend (PDDD)","Health and Wellbeing (HWB)","Environment and Climate Change (ECC)","Governance and Accountability (GA)","Gender Equality (GE)"," Education and Skills Development (ESD)","Evidence Informed Decision Making (EIDM)","Organisational Strengthening (OS): Cross-Cutting","Other";
        }
        field(29; "Success likelihood"; Text[2048])
        {
            Caption = 'Success likelihood';
        }
        field(30; "Role"; Text[2048])
        {
            Caption = 'Role';
        }
        field(31; "Oportunity value"; Text[2048])
        {
            Caption = 'Oportunity value';
        }
        field(32; "Status"; Text[100])
        {
            Caption = 'Status';
        }
        field(35; "Interest"; option)
        {
            OptionMembers = "","Low","High";
        }
        field(34; "Influence"; option)
        {
            OptionMembers = "","Low","High";
        }
        field(37; "Actions"; Text[100])
        {
            Caption = 'Actions';
        }

        field(36; "Funding history"; Text[2048])
        {
            Caption = 'Funding history';
        }

        field(38; "Funding history with afidep"; Text[2048])
        {
            //  Caption = 'Funding history';
        }

        field(39; "Afidep interest"; Text[2048])
        {
            // Caption = 'Funding history';
        }
        field(40; "Funder Name"; code[50])
        {
            Caption = 'Funder Name';

        }
        field(41; "Partner Type"; Option)
        {
            OptionMembers = "","Donor","Implementing","Government","CSO","Media","Others","Foundation","Bilateral","MultiLateral",Science;
            //OptionCaption = ',Donor,Implementing,Government,CSO,Media,Others';
        }
        field(42; "Value (US$)"; Decimal)
        {
            Caption = 'Value (US$)';
        }
        field(47; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(44; Agenda; Text[2048])
        {
            Caption = 'Agenda';
        }
        field(45; "Key items"; Text[2048])
        {
            Caption = 'Key items discussed';
        }
        field(46; "Other notes"; Text[2048])
        {
            Caption = 'Other notes';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        noseries: Codeunit NoSeriesManagement;
        setup: record ResourceMobilizationSetup;
    begin
        setup.get();
        Code := noseries.GetNextNo(setup.Engagement, TODAY, TRUE);

    end;
}
