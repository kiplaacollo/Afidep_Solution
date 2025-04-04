Table 172047 "Exit Interviews"
{

    fields
    {
        field(53; "Application Code"; Code[20])
        {
            Editable = false;
            //
            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Exit Interview Nos");
                    "No series" := '';
                end;
            end;
        }
        field(1; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";
        }
        field(2; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Designation; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "main reason(s) for your exit"; Text[2000])
        {
            Caption = '1. Please describe in detail the main reason(s) for your exit.';
            DataClassification = ToBeClassified;
        }
        field(5; "overall impression"; Text[2000])
        {
            Caption = '2. Describe your overall impression of TI-Kenya as an employer.';
            DataClassification = ToBeClassified;
        }
        field(6; "clear objectives"; Text[2000])
        {
            Caption = '3.Did you have clear objectives regarding your performance and did your supervisor provide adequate support to fulfill these objectives?';
            DataClassification = ToBeClassified;
        }
        field(7; "your performance reviewed"; Text[2000])
        {
            Caption = '4.How often was your performance reviewed and did you receive constructive feedback to help you improve your performance?';
            DataClassification = ToBeClassified;
        }
        field(8; "received enough recognition"; Text[2000])
        {
            Caption = '5.Do you feel that you received enough recognition for your work? Explain ¬';
            DataClassification = ToBeClassified;
        }
        field(9; "career aspirations"; Text[2000])
        {
            Caption = '6.Did you feel that your career aspirations were being met in TI-Kenya? Explain';
            DataClassification = ToBeClassified;
        }
        field(10; "relationship with your"; Text[2000])
        {
            Caption = '7.Describe your relationship with your line supervisor(s). ';
            DataClassification = ToBeClassified;
        }
        field(11; "with your immediate team"; Text[2000])
        {
            Caption = '8.Describe your relationship with your immediate team/colleagues. ';
            DataClassification = ToBeClassified;
        }
        field(12; "greatest accomplishments"; Text[2000])
        {
            Caption = '9.What were your greatest accomplishments while working for TI-Kenya? ';
            DataClassification = ToBeClassified;
        }
        field(13; "perception on TI-Kenya’s"; Text[2000])
        {
            Caption = '10.What is your perception on TI-Kenya’s conditions of service and benefits? ';
            DataClassification = ToBeClassified;
        }
        field(14; "most fulfilling"; Text[2000])
        {
            Caption = '11.What did you find most fulfilling about working in TI-Kenya?';
            DataClassification = ToBeClassified;
        }
        field(15; "most frustrating"; Text[2000])
        {
            Caption = '12.What did you find most frustrating about working in TI-Kenya?';
            DataClassification = ToBeClassified;
        }
        field(16; "better place"; Text[2000])
        {
            Caption = '13.What would you change, if anything, to make TI-Kenya a better place to work in?';
            DataClassification = ToBeClassified;
        }
        field(17; "TI-Kenya in the future"; Text[2000])
        {
            Caption = '14.Would you consider working at TI-Kenya in the future? Under what circumstances?';
            DataClassification = ToBeClassified;
        }
        field(18; "next step"; Text[2000])
        {
            Caption = '15.What is the next step after TI Kenya? ';
            DataClassification = ToBeClassified;
        }
        field(19; "constructive feedback"; Text[2000])
        {
            Caption = '16.Please add any other constructive feedback on your experience at TI-Kenya.';
            DataClassification = ToBeClassified;
        }
        field(20; "Intervire Conducted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Interview Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Date of Exit"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Position; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Department; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Start date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Termination date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Salary (per annum)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Line Manager"; Text[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."First Name";
        }
        field(30; "Reason 1 For leaving"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Further education","Domestic reasons","To improve salary","Transfer of spouse/marriage",Redundancy,"Health problems","Disciplinary case","Departure from Country",Retirement,"To improve benefits","To improve career prospects","Job dissatisfaction","To reduce traveling time","Poor working relationships","End of Contract","Stressful working condition","Change career","Lack of training opportunities","Poor organisation policies","Other reasons";
        }
        field(32; "Reason 3 For leaving"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Further education","Domestic reasons","To improve salary","Transfer of spouse/marriage",Redundancy,"Health problems","Disciplinary case","Departure from Country",Retirement,"To improve benefits","To improve career prospects","Job dissatisfaction","To reduce traveling time","Poor working relationships","End of Contract","Stressful working condition","Change career","Lack of training opportunities","Poor organisation policies","Other reasons";
        }
        field(31; "Reason 2 For leaving"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Further education","Domestic reasons","To improve salary","Transfer of spouse/marriage",Redundancy,"Health problems","Disciplinary case","Departure from Country",Retirement,"To improve benefits","To improve career prospects","Job dissatisfaction","To reduce traveling time","Poor working relationships","End of Contract","Stressful working condition","Change career","Lack of training opportunities","Poor organisation policies","Other reasons";
        }
        field(33; Organization; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Other Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "The work I was doing on the whole was approximately what I was originally expected to be doing."; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
            NotBlank = true;
        }
        field(36; "I had  ample opportunities to use initiative"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(37; "The work I was doing was interesting and challenging"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(38; "Overall, I was satisfied with the general conditions"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(39; "I was able to make full use of my skills and abilities"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(40; "There was team spirit in the organisation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(41; "There was too much pressure on my job"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(42; "I had ample opportunities for personal training and development"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(43; "I received adequate support from my line manager"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(44; "I was satisfied with my salary"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(45; "I found the policies and procedures fair."; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(46; "I had the necessary freedom to make my own decisions"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(47; "I had opportunities to discuss my performance with my line manager."; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(48; "I received communication to enable me know what was going on in other parts of the organisation."; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(49; "Overall, I felt involved in the work of  AFIDEP"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";


        }
        field(50; "New Position"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Other Reasons for Leaving"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = '';
            OptionMembers = "","Improved working conditions","Equitable application of policies e.g. backsliding on policies such as sabbatical","Appropriate reward and recognition of people contributing under exceptional circumstances and risks","Other  ( state)";
        }
        field(52; status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,HOD Approval,HR Approval,Final Approval,Rejected,Canceled,Approved,On leave,Resumed,Posted';
            OptionMembers = New,"Pending Approval","HOD Approval","HR Approval",MDApproval,Rejected,Canceled,Approved,"On leave",Resumed,Posted;

        }
        field(54; "No series"; Code[30])
        {
        }
        field(55; "Reason 1 Remarks"; Text[150])
        {
        }
        field(56; "Reason 2 Remarks"; Text[150])
        {
        }
        field(57; "Reason 3 Remarks"; Text[150])
        {
        }
        field(58; "State Reason For Leaving"; Text[150])
        {
        }
        field(68; "Branch Code"; Code[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }

    }

    keys
    {
        key(Key1; "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Exit Interview Nos");
            NoSeriesMgt.InitSeries(HRSetup."Exit Interview Nos", xRec."No series", 0D, "Application Code", "No series");
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

