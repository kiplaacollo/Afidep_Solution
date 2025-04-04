table 172766 GonoGoDecision
{
    Caption = 'GonoGoDecision';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Call; Text[2048])
        {
            Caption = 'Call';
        }
        field(3; Donor; Code[30])
        {
            Caption = 'Organisation';

            TableRelation = Contact."No." where(type = filter("Contact Type"::Company));
            trigger OnValidate()
            var
                Cont: Record Contact;
            begin
                Cont.Reset();
                Cont.SetRange(Cont."No.", Donor);
                if Cont.FindFirst() then begin
                    "Donor Name" := Cont.Name;
                    "About funder" := Cont."About funder";

                end;
            end;
        }
        field(4; "Type"; option)
        {
            OptionMembers = "Expression of Interest","Concept Note","Full Proposal","Other";
            Caption = 'Type';
        }
        field(5; "Objective/goal"; Text[2048])
        {
            Caption = 'Objective/goal';
        }

        field(6; "Strategic fit"; Text[100])
        {
            //OptionMembers = "","Population Dynamics and Demographic Dividend (PDDD)"," Health and Wellbeing (HWB)"," Environment and Climate Change (ECC)"," Governance and Accountability (GA)"," Gender Equality (GE)"," Education and Skills Development (ESD)"," Evidence Informed Decision Making (EIDM)"," Organisational Strengthening (OS)"," Communications and Policy Engagement (CPE) Cross-Cutting",Other;
            Caption = 'Strategic fit ';
        }
        field(7; "Focus countries"; Text[2048])
        {
            Caption = 'Focus countries';
        }
        field(8; "Submission deadline date"; Date)
        {
            Caption = 'Submission deadline date';
        }
        field(9; "Submission deadline time"; Time)
        {
            Caption = 'Submission deadline time';
        }
        field(10; Budget; Text[2048])
        {
            Caption = 'Budget';
        }
        field(11; "Duration"; Text[200])
        {
            Caption = 'Duration';
        }
        field(12; "Technical skills"; Text[2048])
        {
            Caption = 'Technical skills';
        }
        field(13; Partners; Text[2048])
        {
            Caption = 'Partners';
        }
        field(14; Probability; Decimal)
        {
            Caption = 'Probability';
        }
        field(15; "Prospect type"; Option)
        {
            OptionMembers = "New","Current","Old";
            Caption = 'Prospect type';

        }
        field(16; Decision; Option)
        {
            OptionMembers = "Open","Pending approval","Go","No-go";
            Caption = 'Decision';
            Editable = false;
        }
        field(17; "Decision narration"; Text[2048])
        {
            Caption = 'Decision narration';
        }
        field(18; "Important links"; Text[200])
        {
            Caption = 'Important links';
        }
        field(19; Quarter; Text[10])
        {
            Caption = 'Quarter';
        }
        field(20; "Donor contact"; Text[200])
        {
            Caption = 'Donor contact';
        }
        field(21; News; Text[200])
        {
            Caption = 'News';
        }
        field(22; "Lead source"; Text[2048])
        {
            Caption = 'Lead source ';
        }
        field(23; Status; option)
        {
            Caption = 'Status';
            OptionMembers = "","Dropped","Submitted",Contracted,"Shortlisted/Waitlisted",Lost,Other;
            OptionCaption = ',Dropped,Submitted,Contracted,Shortlisted/Waitlisted,Lost,Other';
        }
        field(24; "Feed back"; Text[2048])
        {
            Caption = 'Feed back';
        }
        field(25; Engagement; text[250])
        {
            Caption = 'Opportunity Name';
        }
        FIELD(26; Converted; Boolean) { }
        field(27; "Proposal development"; text[250]) { }
        field(28; "Conflict of interest"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(29; "Additional information"; text[250]) { }
        field(30; "Partner Type"; Option)
        {
            OptionMembers = "","Donor",INGO,NGO,"Research Center","Government","CSO","Media","Others",University,"Private Sector";
            //OptionCaption = ',Donor,Implementing,Government,CSO,Media,Others';
        }
        field(31; "About funder"; Text[2048])
        {
            Caption = 'Organisation Brief';
        }
        field(32; "Value (US$)"; Decimal)
        {
            Caption = 'Value (US$)';
        }
        field(33; "Likelihood of gift"; Option)
        {
            OptionMembers = "","30%","50%","80%";
        }
        field(34; "Focus area code"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('THEMATIC'));
            trigger
            OnValidate()
            var
                Dim: Record "Dimension Value";
            begin
                Dim.Reset();
                Dim.SetRange(Code, "Focus area code");
                if Dim.FindFirst() then begin
                    "Strategic fit" := Dim.Name;
                end;
            end;
        }
        field(35; "Donor Name"; Code[200])
        {
            Caption = 'Organisation Name';
        }
        field(36; "Afidep Role"; Option)
        {
            OptionMembers = ,Lead,Patner,Others;
            OptionCaption = ',Lead,Patner,Others';
        }
        field(37; "Need Partners"; Option)
        {
            // Define the option values
            OptionMembers = " ",Yes,No;  // The first value is a blank value, followed by "Yes" and "No"
            Caption = 'Need Partners';
            // OptionCaptionML can be used for multilanguage support if needed
        }
        field(38; "Explain interest"; text[250])
        {
        }
        field(39; "Is There Risk"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(40; "Level of Risk"; Text[500])
        {
        }
        field(41; "Proposed Mitigation"; Text[500])
        {
        }
        field(42; "Current,Previous,Incumbents"; Text[2048])
        {
        }
        field(43; "Donor Type"; Option)
        {
            OptionMembers = "","Foundation","Bilateral","MultiLateral",Science,Other;
            //OptionCaption = ',Donor,Implementing,Government,CSO,Media,Others';
        }

    }
    keys
    {
        key(PK; "Code", Engagement)
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
        Code := noseries.GetNextNo(setup.Gonogodecision, TODAY, TRUE);

    end;
}
