Table 170106 "HR Job Application Profiles"
{
    Caption = 'HR Job Applications';

    fields
    {
        field(1;"Application No";Code[50])
        {
        }
        field(2;"First Name";Text[100])
        {
        }
        field(3;"Middle Name";Text[50])
        {
        }
        field(4;"Last Name";Text[50])
        {

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
            end;
        }
        field(5;Initials;Text[15])
        {
        }
        field(7;"Search Name";Code[50])
        {
        }
        field(8;"Postal Address";Text[80])
        {
        }
        field(9;"Residential Address";Text[80])
        {
        }
        field(10;City;Text[30])
        {
        }
        field(11;"Post Code";Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12;County;Text[30])
        {
        }
        field(13;"Home Phone Number";Text[30])
        {
        }
        field(14;"Cell Phone Number";Text[30])
        {
        }
        field(15;"Work Phone Number";Text[30])
        {
        }
        field(16;"Ext.";Text[7])
        {
        }
        field(17;"E-Mail";Text[80])
        {
        }
        field(19;Picture;Blob)
        {
            SubType = Bitmap;
        }
        field(20;"ID Number";Text[30])
        {

            trigger OnValidate()
            begin
                /*HRJobApp.RESET;
                HRJobApp.SETRANGE(HRJobApp."ID Number","ID Number");
                IF HRJobApp.FIND('-') THEN BEGIN
                  ERROR('This ID Number has been used in a prior Job Application.');
                END;
                */

            end;
        }
        field(21;Gender;Option)
        {
            OptionMembers = Male,Female;
        }
        field(22;"Country Code";Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(23;Status;Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(24;Comment;Boolean)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(25;"Fax Number";Text[30])
        {
        }
        field(26;"Marital Status";Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(27;"Ethnic Origin";Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(28;"First Language (R/W/S)";Code[10])
        {
            TableRelation = "Scheme Balances"."Employee No" where ("Medical Period"=filter('1'));
        }
        field(29;"Driving Licence";Code[10])
        {
        }
        field(30;Disabled;Option)
        {
            OptionMembers = No,Yes," ";
        }
        field(31;"Health Assesment?";Boolean)
        {
        }
        field(32;"Health Assesment Date";Date)
        {
        }
        field(33;"Date Of Birth";Date)
        {

            trigger OnValidate()
            begin
                if "Date Of Birth" >=Today then begin
                    Error('Date of Birth cannot be after %1',Today);
                end;
            end;
        }
        field(34;Age;Text[80])
        {
        }
        field(35;"Second Language (R/W/S)";Code[10])
        {
            TableRelation = "Scheme Balances"."Employee No" where ("Medical Period"=filter('1'));
        }
        field(36;"Additional Language";Code[10])
        {
            TableRelation = "Scheme Balances"."Employee No" where ("Medical Period"=filter('1'));
        }
        field(37;"Primary Skills Category";Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(38;Level;Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(39;"Termination Category";Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(40;"Postal Address2";Text[30])
        {
        }
        field(41;"Postal Address3";Text[20])
        {
        }
        field(42;"Residential Address2";Text[30])
        {
        }
        field(43;"Residential Address3";Text[20])
        {
        }
        field(44;"Post Code2";Code[20])
        {
            TableRelation = "Post Code";
        }
        field(45;Citizenship;Code[10])
        {
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                Country.Reset;
                Country.SetRange(Country.Code,Citizenship);
                if Country.Find('-') then
                begin
                    "Citizenship Details":=Country.Name;
                end;
            end;
        }
        field(46;"Disabling Details";Text[50])
        {
        }
        field(47;"Disability Grade";Text[30])
        {
        }
        field(48;"Passport Number";Text[30])
        {
        }
        field(49;"2nd Skills Category";Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50;"3rd Skills Category";Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(51;Region;Code[10])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));
        }
        field(52;"First Language Read";Boolean)
        {
        }
        field(53;"First Language Write";Boolean)
        {
        }
        field(54;"First Language Speak";Boolean)
        {
        }
        field(55;"Second Language Read";Boolean)
        {
        }
        field(56;"Second Language Write";Boolean)
        {
        }
        field(57;"Second Language Speak";Boolean)
        {
        }
        field(58;"PIN Number";Code[20])
        {
        }
        field(59;"Job Applied For";Code[30])
        {
            Editable = false;
            TableRelation = "HR Medical Schemes"."Scheme No";

            trigger OnValidate()
            begin
                if ObjHrJobs.Get("Job Applied For") then
                  begin
                    "Job Applied for Description":=ObjHrJobs."Medical Insurer";
                    end;
            end;
        }
        field(60;"Employee Requisition No";Code[20])
        {
            // TableRelation = "Board Members".Field3968 where (Field25=const(No),
            //                                                  text=const('2'));

            trigger OnValidate()
            begin

                HREmpReq.Reset;
                HREmpReq.SetRange(HREmpReq."Requisition No.","Employee Requisition No");
                if HREmpReq.Find('-') then
                "Job Applied For":=HREmpReq."Member Name";
            end;
        }
        field(61;"Total Score";Decimal)
        {
            FieldClass = Normal;
        }
        field(62;Shortlist;Boolean)
        {
        }
        field(63;Qualified;Boolean)
        {
            Editable = true;
        }
        field(64;Stage;Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(65;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(66;"Employee No";Code[20])
        {
            TableRelation = "Units Mass Update".No;

            trigger OnValidate()
            begin
                //COPY EMPLOYEE DETAILS FROM EMPLOYEE TABLE
                /*Employee.RESET;
                IF Employee.GET("Employee No") THEN BEGIN
                "First Name":=Employee.Property;
                "Middle Name":=Employee."Property Name";
                "Last Name":=Employee.Date;
                "Search Name":=Employee."Updated By";
                "Postal Address":=Employee."No. Series";
                "Residential Address":=Employee.Ammenity;
                City:=Employee.Amount;
                "Post Code":=Employee."Post Code";
                County:=Employee.County;
                "Home Phone Number":=Employee."Home Phone Number";
                "Cell Phone Number":=Employee."Cell Phone Number";
                "Work Phone Number":=Employee."Work Phone Number";
                "Ext.":=Employee."Ext.";
                "E-Mail":=Employee."E-Mail";
                "ID Number":=Employee."ID Number";
                Gender:=Employee.Gender;
                "Country Code":=Employee.Citizenship;
                "Fax Number":=Employee."Fax Number";
                "Marital Status":=Employee."Marital Status";
                "Ethnic Origin":=Employee."Ethnic Origin";
                "First Language (R/W/S)":=Employee."First Language (R/W/S)";
                //"Driving Licence":=Employee."Has Driving Licence";
                Disabled:=Employee.Disabled;
                "Health Assesment?":=Employee."Health Assesment?";
                "Health Assesment Date":=Employee."Health Assesment Date";
                "Date Of Birth":=Employee."Date Of Birth";
                Age:=Employee.Age;
                "Second Language (R/W/S)":=Employee."Second Language (R/W/S)";
                "Additional Language":=Employee."Additional Language";
                Citizenship:=Employee.Citizenship;
                "Passport Number":=Employee."Passport Number";
                "First Language Read":=Employee."First Language Read";
                "First Language Write":=Employee."First Language Write";
                "First Language Speak":=Employee."First Language Speak";
                "Second Language Read":=Employee."Second Language Read";
                "Second Language Write":=Employee."Second Language Write";
                "Second Language Speak":=Employee."Second Language Speak";
                "PIN Number":=Employee."PIN No.";
                
                "Applicant Type":="Applicant Type"::Internal;
                MODIFY;
                
                            //DELETE QUALIFICATIONS PREVIOUSLY COPIED
                            AppQualifications.RESET;
                            AppQualifications.SETRANGE(AppQualifications."Application No","Application No");
                            IF AppQualifications.FIND('-') THEN
                            AppQualifications.DELETEALL;
                
                            //GET EMPL0YEE QUALIFICATIONS
                            EmpQualifications.RESET;
                            EmpQualifications.SETRANGE(EmpQualifications."Employee No.",Employee.No);
                            IF EmpQualifications.FIND('-') THEN
                            EmpQualifications.FINDFIRST;
                            BEGIN
                            AppQualifications.RESET;
                
                                REPEAT
                                AppQualifications.INIT;
                                AppQualifications."Application No":="Application No";
                                AppQualifications."Employee No.":="Employee No";
                                AppQualifications."Qualification Type":=EmpQualifications."Qualification Type";
                                AppQualifications."Qualification Code":=EmpQualifications."Qualification Code";
                                AppQualifications."Qualification Description":=EmpQualifications."Qualification Description";
                                AppQualifications."From Date":=EmpQualifications."From Date";
                                AppQualifications."To Date":=EmpQualifications."To Date";
                                AppQualifications.Type:=EmpQualifications.Type;
                                AppQualifications."Institution/Company":=EmpQualifications."Institution/Company";
                                AppQualifications.INSERT();
                
                                UNTIL EmpQualifications.NEXT = 0;
                            END
                END;
                */
                /*
                END ELSE BEGIN
                "First Name":='';
                "Middle Name":='';
                "Last Name":='';
                "Search Name":='';
                "Postal Address":='';
                "Residential Address":='';
                City:=Employee.City;
                "Post Code":='';
                County:='';
                "Home Phone Number":='';
                "Cell Phone Number":='';
                "Work Phone Number":='';
                "Ext.":='';
                "E-Mail":='';
                "ID Number":='';
                
                "Country Code":='';
                "Fax Number":='';
                
                "First Language (R/W/S)":='';
                //"Driving Licence":=Employee."Has Driving Licence";
                
                "Health Assesment Date":=0D;
                "Date Of Birth":=0D;
                Age:='';
                "Second Language (R/W/S)":='';
                "Additional Language":='';
                "Postal Address2":='';
                "Postal Address3":='';
                "Residential Address2":='';
                "Residential Address3":='';
                "Post Code2":='';
                Citizenship:='';
                "Passport Number":='';
                "First Language Read":=FALSE;
                "First Language Write":=FALSE;
                "First Language Speak":=FALSE;
                "Second Language Read":=FALSE;
                "Second Language Write":=FALSE;
                "Second Language Speak":=FALSE;
                "PIN Number":='';
                
                "Applicant Type":="Applicant Type"::External;
                MODIFY;
                
                //DELETE QUALIFICATIONS PREVIOUSLY COPIED
                AppQualifications.RESET;
                AppQualifications.SETRANGE(AppQualifications."Application No","Application No");
                IF AppQualifications.FIND('-') THEN
                AppQualifications.DELETEALL;
                
                //DELETE APPLICANT REFEREES
                AppRefferees.RESET;
                AppRefferees.SETRANGE(AppRefferees."Job Application No","Application No");
                IF AppRefferees.FIND('-') THEN
                AppRefferees.DELETEALL;
                
                //DELETE APPLICANT HOBBIES
                AppHobbies.RESET;
                AppHobbies.SETRANGE(AppHobbies."Job Application No","Application No");
                IF AppHobbies.FIND('-') THEN
                AppHobbies.DELETEALL;
                
                END;
                */

            end;
        }
        field(67;"Applicant Type";Option)
        {
            Editable = false;
            OptionCaption = 'External,Internal';
            OptionMembers = External,Internal,AMPATH;
        }
        field(68;"Interview Invitation Sent";Boolean)
        {
            Editable = false;
        }
        field(69;"Date Applied";Date)
        {
        }
        field(70;"Citizenship Details";Text[60])
        {
        }
        field(71;Expatriate;Boolean)
        {
        }
        field(72;"Total Score After Interview";Decimal)
        {
        }
        field(73;"Total Score After Shortlisting";Decimal)
        {
        }
        field(74;"Date of Interview";Date)
        {
        }
        field(75;"From Time";Time)
        {
        }
        field(76;"To Time";Time)
        {
        }
        field(77;Venue;Text[100])
        {
        }
        field(78;"Job Applied for Description";Text[100])
        {
        }
        field(79;"Regret Notice Sent";Boolean)
        {
        }
        field(80;"Interview Type";Option)
        {
            OptionCaption = 'Writen,Practicals,Oral';
            OptionMembers = Writen,Practicals,Oral;
        }
        field(81;"Qualification Status";Option)
        {
            OptionCaption = ' ,Qualified,UnQualified';
            OptionMembers = " ",Qualified,UnQualified;
        }
        field(82;"Registration Cert No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(83;"Current Physical Address";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(84;"Post Office No.";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(85;"Post Office Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }
        field(86;Town;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(87;"Office No.";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(88;"Curr. Landlord Name";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(89;"Contact Person";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(90;"Company Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Private,Limited Liability,Partnership,Sole Proprietorship';
            OptionMembers = ,Private,"Limited Liability",Partnership,"Sole Proprietorship";
        }
        field(91;"Incorporation Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(92;Username;Text[40])
        {
        }
        field(93;Password;Text[40])
        {
        }
        field(94;SpecialReq;Text[250])
        {
        }
        field(95;Use;Text[250])
        {
        }
        field(96;SQrFeet;Decimal)
        {
        }
        field(97;ServiceOfferd;Text[100])
        {
        }
        field(98;ServiceOfferd1;Text[100])
        {
        }
        field(99;Serviceofferd2;Text[100])
        {
        }
        field(100;NoOFpersonel;Integer)
        {
        }
        field(101;ApplyPremise;Integer)
        {

            trigger OnValidate()
            begin
                /*
                  IF ApplyPremise=1 THEN BEGIN
                  HrApp.RESET;
                   HrApp.SETRANGE(HrApp.Username, Username);
                   IF HrApp.FIND('-') THEN BEGIN
                   PremiseApp.INIT;
                   PremiseApp.Apply:=HrApp.Username;
                
                   PremiseApp.INSERT;
                
                  END;
                  END;
                  */

            end;
        }
    }

    keys
    {
        key(Key1;"ID Number")
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
        // IF  "Application No" = '' THEN BEGIN
        //  HRSetup.GET;
        //  HRSetup.TESTFIELD(HRSetup."Job Application Nos");
        //  NoSeriesMgt.InitSeries(HRSetup."Job Application Nos",xRec."No. Series",0D,"Application No","No. Series");
        // END;

        "Date Applied":=Today;
    end;

    var
        HREmpReq: Record "Board Members";
        Employee: Record "Units Mass Update";
        HRSetup: Record "HR Medical Dependants";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpQualifications: Record "HR Employee Qualifications";
        AppQualifications: Record "HR Applicant Qualifications";
        AppRefferees: Record "HR Applicant Referees";
        AppHobbies: Record "HR Applicant Hobbies";
        HRJobApp: Record "HR Job Applications";
        Country: Record "Country/Region";
        ObjHrJobs: Record "HR Medical Schemes";
        OPen: Time;
        Close: Text;
        HrApp: Record "HR Job Application Profiles";


    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
          exit("First Name" + ' ' + "Last Name")
        else
          exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
}

