Page 80054 "HR Employee Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Print,Functions,Employee,Attachments';
    SourceTable = "HR Employees";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group("General Details")
            {
                Caption = 'General Details';
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        // IF AssistEdit() THEN
                        CurrPage.Update;
                    end;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                // field("Supervisor ID";Rec."Supervisor ID")
                // {
                //     ApplicationArea = Basic;
                //     Importance = Promoted;
                //     Visible = false;
                //     Caption = 'User name';

                //     trigger OnValidate()
                //     begin
                //         SupervisorNames := GetSupervisor(Rec."User ID");
                //     end;
                // }
                field("Employee UserID"; Rec."Employee UserID")
                {
                    ApplicationArea = basic;
                    caption = 'User ID'
;
                }
                field("Resource No."; Rec."Resource No.")
                {

                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Passport Number"; Rec."Passport Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }

                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic;
                    Caption = 'Country / Region Code';
                    Editable = false;
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = false;
                    Caption = 'Reporting to Code';

                }
                field("Responsibility Center Name"; Rec."Responsibility Center Name")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Editable = false;
                    Caption = 'Reporting to Name';
                }
                field("Programme or Department Code"; Rec."Programme or Department Code") { }
                field("Programme or Department"; Rec."Programme or Department")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = Basic;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Ethnicity; Rec.Ethnicity)
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field("Place Of Birth"; Rec."Place Of Birth")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                }
                field(Division; Rec.Division)
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                }
                field("Portal Password"; Rec."Portal Password")
                {
                    Caption = 'New';
                    Editable = false;
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }

                field(Registered; Rec.Registered)
                {
                    ApplicationArea = Basic;
                    Caption = 'Enable Portal Access';
                }
                field("Fosa Account"; Rec."Fosa Account")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Visible = false;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor ';
                    Editable = true;
                    Visible = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        SupervisorNames := GetSupervisor(Rec."User ID");
                    end;
                }
                field("SMT Lead"; Rec."SMT Lead")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("HR Manager"; Rec."HR Manager")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                    trigger OnValidate()
                    var
                        users: Record User;
                    begin
                        //     users.Get(UserId);
                        //     if users.Find()
                        //     then
                        //         users.State := users.State::Disabled;


                        //     users.Modify();
                        //     Commit();
                    end;
                }

                field("Institutional Base"; Rec."Institutional Base")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }


                field(Travelaccountno; Rec.Travelaccountno)
                {
                    ApplicationArea = Basic;
                    Caption = 'Imprest Account';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Is Driver"; Rec."Is Driver")
                {
                    ToolTip = 'Specify the employee is a Driver';
                }
                field("Vehicle Registration Number"; Rec."Vehicle Registration Number")
                {
                    ToolTip = 'Specify the vehicle registration  No.';
                }
                field("Driving Licence"; Rec."Driving Licence")
                {
                    ToolTip = 'Specify the  Driver driving licence No.';

                }
                field("PIN No."; Rec."PIN No.")
                {

                }
            }
            group("Communication Details")
            {
                Caption = 'Communication Details';
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                }
                field("Ext."; Rec."Ext.")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = EMail;
                    ShowMandatory = true;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                // field(Signature; Rec.Signature)
                // {
                //     ApplicationArea = Basic;
                // }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field("First Language Read"; Rec."First Language Read")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("First Language Write"; Rec."First Language Write")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Second Language Read"; Rec."Second Language Read")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Additional Language"; Rec."Additional Language")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field("Number Of Dependants"; Rec."Number Of Dependants")
                {
                    ApplicationArea = Basic;
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = Basic;
                    Caption = 'Person with disability';
                }
                field("Health Assesment?"; Rec."Health Assesment?")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme No."; Rec."Medical Scheme No.")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Head Member"; Rec."Medical Scheme Head Member")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Medical Scheme Name"; Rec."Medical Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Out-Patient Limit"; Rec."Medical Out-Patient Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Medical In-Patient Limit"; Rec."Medical In-Patient Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Maximum Cover"; Rec."Medical Maximum Cover")
                {
                    ApplicationArea = Basic;
                }
                field("Medical No Of Dependants"; Rec."Medical No Of Dependants")
                {
                    ApplicationArea = Basic;
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                field("Bank Code Speed Key"; Rec."Bank Code Speed Key")
                {
                    ApplicationArea = basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = basic;
                }
                field("Bank Code New"; Rec."Bank Code New")
                {
                    ApplicationArea = basic;
                    Caption = 'Bank Code';
                }
                field("Branch Code New"; Rec."Branch Code New")
                {
                    ApplicationArea = basic;
                    Caption = 'Branch Code';
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = basic;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" >= Today then begin
                            Error('Invalid Entry');
                        end;
                        //DAge := Dates.DetermineAge("Date Of Birth", Today);
                    end;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Caption = 'Age';
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                    Importance = Promoted;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        //DService := Dates.DetermineAge("Date Of Join", Today);
                    end;
                }

                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Scheme Join Date"; Rec."Pension Scheme Join Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        //DPension := Dates.DetermineAge("Pension Scheme Join Date", Today);
                    end;
                }
                field("Medical Scheme Join Date"; Rec."Medical Scheme Join Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        //DMedical := Dates.DetermineAge("Medical Scheme Join Date", Today);
                    end;
                }
                field("Time Medical Scheme"; Rec."Time Medical Scheme")
                {
                    ApplicationArea = Basic;
                    Caption = 'Time On Medical Aid Scheme';
                    Editable = false;
                    Enabled = false;
                }
                field("Wedding Anniversary"; Rec."Wedding Anniversary")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Job Details")
            {
                Caption = 'Job Details';
                field("Job Specification>"; Rec."Job Specification")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Specification';
                    Importance = Promoted;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic;
                }
                field("Department Name"; Rec."Department Name")
                {

                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Terms of Service")
            {
                Caption = 'Terms of Service';
                field("Secondment Institution"; Rec."Secondment Institution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Secondment';
                }
                field("contract start date"; Rec."contract start date")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Duration"; Rec."Contract Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                    ApplicationArea = Basic;
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Donor Code"; Rec."Donor Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fund Code';
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("<KRA PIN No.>"; Rec."PIN No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'KRA PIN No.';
                    Importance = Promoted;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Housing Fund No."; Rec."Housing Fund No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Separation Details")
            {
                Caption = 'Separation Details';
                field("Date Of Leaving the Company"; Rec."Date Of Leaving the Company")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        /*
                        FrmCalendar.SetDate("Date Of Leaving the Company");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "Date Of Leaving the Company":= D;
                        //DAge:= Dates.DetermineAge("Date Of Birth",TODAY);
                        
                        */

                    end;
                }
                field("Termination Grounds"; Rec."Termination Grounds")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Leave Details/Medical Claims")
            {
                Caption = 'Leave Details/Medical Claims';
                field("Reimbursed Leave Days"; Rec."Reimbursed Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Allocated Leave Days"; Rec."Allocated Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Total (Leave Days)"; Rec."Total (Leave Days)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Total Leave Taken"; Rec."Total Leave Taken")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Acrued Leave Days"; Rec."Acrued Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Cash per Leave Day"; Rec."Cash per Leave Day")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Cash - Leave Earned"; Rec."Cash - Leave Earned")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Leave Type Filter"; Rec."Leave Type Filter")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Leave Period Filter"; Rec."Leave Period Filter")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Claim Limit"; Rec."Claim Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Amount Used"; Rec."Claim Amount Used")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Remaining Amount"; Rec."Claim Remaining Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Employees Factbox")
            {
                SubPageLink = "No." = field("No.");
            }
            systempart(Control1102755002; Outlook)
            {
            }
            systempart(Control1; Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Personal Information File")
                {
                    ApplicationArea = Basic;
                    Caption = 'Personal Information File';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(55585, true, true, HREmp);
                    end;
                }
                action("Leave Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Statement';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(80029, true, true, HREmp);
                    end;
                }
                action("Misc. Article Info")
                {
                    ApplicationArea = Basic;
                    Caption = 'Misc. Article Info';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Misc.Reset;
                        Misc.SetRange(Misc."Employee No.", Rec."No.");
                        if Misc.Find('-') then
                            Report.Run(5202, true, true, Misc);
                    end;
                }
                action("Confidential Info")
                {
                    ApplicationArea = Basic;
                    Caption = 'Confidential Info';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Conf.Reset;
                        Conf.SetRange(Conf."Employee No.", Rec."No.");
                        if Conf.Find('-') then
                            Report.Run(5203, true, true, Conf);
                    end;
                }
                action(Label)
                {
                    ApplicationArea = Basic;
                    Caption = 'Label';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(5200, true, true, HREmp);
                    end;
                }
                action(Addresses)
                {
                    ApplicationArea = Basic;
                    Caption = 'Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(5207, true, true, HREmp);
                    end;
                }
                action("Alt. Addresses")
                {
                    ApplicationArea = Basic;
                    Caption = 'Alt. Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(5213, true, true, HREmp);
                    end;
                }
                action("Phone Nos")
                {
                    ApplicationArea = Basic;
                    Caption = 'Phone Nos';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            Report.Run(5210, true, true, HREmp);
                    end;
                }
            }
            group("&Employee")
            {
                Caption = '&Employee';
                action("Employee Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Kin';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";

                    RunPageLink = "Employee Code" = field("No.");
                    RunPageView = where(Type = filter("Next of Kin"));
                }
                action("Family Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Family Details';
                    Image = Opportunity;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("No.");
                    RunPageView = where(Type = filter(Beneficiary));
                }
                action(Notify)
                {
                    ApplicationArea = Basic;
                    Caption = 'Notify IT';
                    Image = NewResource;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin
                        Message('Notification Sent to IT ');
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    // RunObject = Page "Human Resource Comment Sheet"; 
                    // RunPageLink = "Table Name"=const(Employee),
                    //               "No."=field("No.");
                }
                action("Attach ")
                {
                    ApplicationArea = Basic;
                    Enabled = true;
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        Hyperlink('http://192.168.4.52');
                        //"Term Sheet Attached":=TRUE;
                        Rec.Modify;
                    end;
                }
                action("Alternative Addresses")
                {
                    ApplicationArea = Basic;
                    Caption = 'Alternative Addresses';
                    Image = AlternativeAddress;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Alternative Address Card";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Misc. Articles")
                {
                    ApplicationArea = Basic;
                    Caption = 'Misc. Articles';
                    Image = ExternalDocument;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Misc. Articles Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Misc. Articles Overview';
                    Image = ViewSourceDocumentLine;
                    Promoted = true;
                    PromotedCategory = Category6;
                    // RunObject = Page "Misc. Articles Overview"; 
                }
                action("&Confidential Information")
                {
                    ApplicationArea = Basic;
                    Caption = '&Confidential Information';
                    Image = SNInfo;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    // RunObject = Page "Confidential Information";
                    // RunPageLink = "Employee No."=field("No.");
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&nfidential Info. Overview';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Info. Overview";
                }
                action(Timesheet)
                {
                    ApplicationArea = Basic;
                    Caption = 'Timesheet';
                    Image = AbsenceCalendar;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(5200),
                                  "No." = field("No.");
                }
                action("Process Exit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Process Exit';
                    Image = Voucher;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const(Employee),
                                  "No." = field("No.");
                }
            }
        }
        area(processing)
        {
            action("Set as Inactive")
            {
                ApplicationArea = Basic;
                Caption = 'Set as Inactive';
                Image = NewResource;
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to set as inactive') then begin
                        Rec.Status := Rec.Status::Inactive;
                        Rec.Modify;
                        Users.reset;
                        users.SetRange(users."User Name", Rec."Employee UserID");
                        if users.Find('-') then
                            // if Rec.Status = rec.Status::Inactive then
                            users.State := users.State::Disabled;
                        // else
                        //     if rec.Status = rec.Status::Active then
                        //         users.State := users.State::Enabled;
                        users.Modify();
                        Commit();
                    end;
                end;
            }
            action("Set as Active")
            {
                ApplicationArea = Basic;
                Caption = 'Set as Active';
                Image = NewResourceGroup;
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to set as Active') then begin
                        Rec.Status := Rec.Status::Active;
                        Rec.Modify;
                        Users.reset;
                        users.SetRange(users."User Name", Rec."Employee UserID");
                        if users.Find('-') then
                            // if Rec.Status = rec.Status::Inactive then
                            users.State := users.State::Enabled;
                        // else
                        //     if rec.Status = rec.Status::Active then
                        //         users.State := users.State::Enabled;
                        users.Modify();
                        Commit();
                    end;
                end;
            }
            action("Exit Interview")
            {
                ApplicationArea = Basic;
                Caption = 'Exit Interview';
                Image = NewOpportunity;
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                begin
                    if not ExitInterviews.Get(Rec."No.") then begin
                        ExitInterviews.Init;
                        ExitInterviews."Employee No" := Rec."No.";
                        ExitInterviews."Employee Name" := Rec."First Name" + '' + Rec."Middle Name" + '' + Rec."Last Name";
                        ExitInterviews.Designation := Rec."Job Title";
                        ExitInterviews."Intervire Conducted By" := UserId;
                        ExitInterviews."Interview Date" := Today;
                        ExitInterviews.Insert;
                        Commit;
                    end;


                end;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        //Recalculate Important Dates
        //   if (Rec."Date Of Leaving the Company" = 0D) then begin
        //     if  (Rec."Date Of Birth" <> 0D) then
        //     DAge:= Dates.DetermineAge("Date Of Birth",Today);
        //     if  ("Date Of Joining the Company" <> 0D) then
        //     DService:= Dates.DetermineAge("Date Of Joining the Company",Today);
        //     if  ("Pension Scheme Join Date" <> 0D) then
        //     DPension:= Dates.DetermineAge("Pension Scheme Join Date",Today);
        //     if  ("Medical Scheme Join Date" <> 0D) then
        //     DMedical:= Dates.DetermineAge("Medical Scheme Join Date",Today);
        //     Modify;
        //   end else begin
        //     if  ("Date Of Birth" <> 0D) then
        //     DAge:= Dates.DetermineAge("Date Of Birth","Date Of Leaving the Company");
        //     if  ("Date Of Joining the Company" <> 0D) then
        //     DService:= Dates.DetermineAge("Date Of Joining the Company","Date Of Leaving the Company");
        //     if  ("Pension Scheme Join Date" <> 0D) then
        //     DPension:= Dates.DetermineAge("Pension Scheme Join Date","Date Of Leaving the Company");
        //     if  ("Medical Scheme Join Date" <> 0D) then
        //     DMedical:= Dates.DetermineAge("Medical Scheme Join Date","Date Of Leaving the Company");
        //     //MODIFY;
        //   end;

        // //Recalculate Leave Days
        // Validate("Allocated Leave Days");
        // SupervisorNames:=GetSupervisor("User ID");
    end;

    trigger OnClosePage()
    begin
        /* TESTFIELD("First Name");
         TESTFIELD("Middle Name");
         TESTFIELD("Last Name");
         TESTFIELD("ID Number");
         TESTFIELD("Cellular Phone Number");
        */

    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        // if Rec."First Name" = '' then Error('Error First Name is not specified');
        //IF "Last Name"='' THEN ERROR('Error Last Name is not specified');
        //IF  THEN ERROR('Error General posting group is not specified');
    end;

    var
        Text001: label 'Do you want to replace the existing picture of %1 %2?';
        Text002: label 'Do you want to delete the picture of %1 %2?';
        Text003: label 'Welcome to Lotus Capital Limited';
        Text004a: label 'It is a great pleasure to welcome you to Moi Teaching and Referral Hospital. You are now part of an organization that has its own culture and set of values. On your resumption and during your on-boarding process,  to help you to understand and adapt quickly and easily to the LOTUS CAPITAL culture and values, HR Unit shall provide you with various important documents that you are encouraged to read and understand.';
        Text004b: label 'On behalf of the Managing Director, I congratulate you for your success in the interview process and I look forward to welcoming you on board LOTUS CAPITAL Limited.';
        Text004c: label 'Adebola SAMSON-FATOKUN';
        Text004d: label 'Strategy & Corporate Services';
        PictureExists: Boolean;
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        D: Date;
        "Filter": Boolean;
        prEmployees: Record "HR Employees";
        //Mail: Codeunit Mail;
        HREmp: Record "HR Employees";
        SupervisorNames: Text[60];
        Misc: Record "Misc. Article Information";
        Conf: Record "Confidential Information";
        //SMTP: Codeunit "SMTP Mail";
        CompInfo: Record "Company Information";
        Body: Text[1024];
        Filename: Text;
        Recordlink: Record "Record Link";
        NL: Char;
        LF: Char;
        objpostingGroup: Record "Payroll Posting Groups_AU";
        objDimVal: Record "Dimension Value";
        "Citizenship Text": Text[200];
        //  Dates: Codeunit "Dates Calculation";
        ExitInterviews: Record "Exit Interviews";
        users: Record User;


    procedure GetSupervisor(var sUserID: Code[50]) SupervisorName: Text[200]
    var
        UserSetup: Record "User Setup";
    begin
        if sUserID <> '' then begin
            UserSetup.Reset;
            if UserSetup.Get(sUserID) then begin

                SupervisorName := UserSetup."Approver ID";
                if SupervisorName <> '' then begin

                    HREmp.SetRange(HREmp."User ID", SupervisorName);
                    if HREmp.Find('-') then
                        SupervisorName := HREmp.FullName;

                end else begin
                    SupervisorName := '';
                end;


            end else begin
                //ERROR('User'+' '+ sUserID +' '+ 'does not exist in the user setup table');
                SupervisorName := '';
            end;
        end;
    end;


    procedure GetSupervisorID(var EmpUserID: Code[50]) SID: Text[200]
    var
        UserSetup: Record "User Setup";
        SupervisorID: Code[20];
    begin
        if EmpUserID <> '' then begin
            SupervisorID := '';

            UserSetup.Reset;
            if UserSetup.Get(EmpUserID) then begin
                SupervisorID := UserSetup."Approver ID";
                if SupervisorID <> '' then begin
                    SID := SupervisorID;
                end else begin
                    SID := '';
                end;
            end else begin
                Error('User' + ' ' + EmpUserID + ' ' + 'does not exist in the user setup table');
            end;
        end;
    end;
}

