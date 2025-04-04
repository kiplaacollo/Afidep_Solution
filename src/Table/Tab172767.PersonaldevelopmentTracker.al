table 172767 "Personal development Tracker"
{
    Caption = 'Personal development Tracker';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(3; "Total call"; Decimal)
        {
            Caption = 'Total call';
        }
        field(4; Duarion; Code[10])
        {
            Caption = 'Duarion';
        }
        field(5; Lead; Text[40])
        {
            Caption = 'Lead';
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
        field(6; "Focus area"; Text[100])
        {
            //OptionMembers = "","Population Dynamics and Demographic Dividend (PDDD)","Health and Wellbeing (HWB)","Environment and Climate Change (ECC)","Governance and Accountability (GA)","Gender Equality (GE)"," Education and Skills Development (ESD)","Evidence Informed Decision Making (EIDM)","Organisational Strengthening (OS): Cross-Cutting","Other";
        }
        field(7; Funder; Code[50])
        {
            Caption = 'Funder';

            TableRelation = Contact."No." where(type = filter("Contact Type"::Company));
            trigger OnValidate()
            var
                Cont: Record Contact;
            begin
                Cont.Reset();
                Cont.SetRange(Cont."No.", Funder);
                if Cont.FindFirst() then begin
                    "Funder Name" := Cont.Name;
                end;
            end;
        }
        field(8; "Funder type"; Code[50])
        {
            Caption = 'Funder type';
            TableRelation = "Funder types";
        }
        field(9; "Funder profile"; Code[20])
        {
            Caption = 'Funder profile';
        }
        field(10; Partner; Text[2048])
        {
            Caption = 'Organisation';
        }
        field(11; "Year submitted"; Integer)
        {
            Caption = 'Year submitted';
        }
        field(12; "Year grant given or denied"; Integer)
        {
            Caption = 'Year grant given or denied';
        }
        field(13; "Annual allocations"; Decimal)
        {
            Caption = 'Annual allocations';
        }
        field(15; Engagement; text[250])
        {
            Caption = 'Opportunity Name';
        }
        field(16; Gonogodecision; Code[20])
        {

        }

        field(14; "Status"; Option)
        {
            OptionMembers = "New","Pending approval","Approved","Converted";

        }


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

        field(26; "About funder"; Text[2048])
        {
            Caption = 'About Organisation';
        }
        field(27; "Duration"; Text[2048])
        {
            Caption = 'Duration in months';
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
        field(32; "Partner Type"; Option)
        {
            OptionMembers = "","Donor",INGO,NGO,"Research Center","Government","CSO","Media","Others",University,"Private Sector";
            //OptionCaption = ',Donor,Implementing,Government,CSO,Media,Others';
        }
        field(33; "Value (US$)"; Decimal)
        {
            Caption = 'Value (US$)';
        }
        field(34; "Likelihood of gift"; Option)
        {
            OptionMembers = "","30%","50%","80%";
        }
        field(35; "Decision Status"; Option)
        {
            OptionMembers = "",Awarded,"Committed","Shortlisted","Waitlisted",Lost,"Pending FeedBack",Dropped,Other;

        }
        field(36; "Funder Name"; Code[200])
        {
        }
        field(37; "Afidep Role"; Option)
        {
            OptionMembers = ,Lead,Patner,Others;
            OptionCaption = ',Lead,Patner,Others';
        }
        field(38; "Donor Type"; Option)
        {
            OptionMembers = "","Foundation","Bilateral","MultiLateral",Science,Other;
            //OptionCaption = ',Donor,Implementing,Government,CSO,Media,Others';
        }
        field(39; "AFIDEP Budget"; Decimal)
        {

        }
        field(40; "Lead source"; Text[2048])
        {
            Caption = 'Lead source ';
        }
        field(41; Notes; Text[2048])
        {
            // Caption = 'Lead source ';
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
        Code := noseries.GetNextNo(setup.Professionaldevelopment, TODAY, TRUE);

    end;
}
