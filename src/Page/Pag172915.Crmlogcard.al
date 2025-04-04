//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172915 "Crm log card"
{
    PageType = Card;
    SourceTable = "General Equiries.";
    SourceTableView = where(Send = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                // field("CaseEmployer:=TRUE;"; Rec."Calling As")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Equiring As';
                //     Importance = Promoted;
                //     OptionCaption = ',As Member,As Employer';
                //     Visible = false;
                // }
                field("<Equiring For>"; Rec."Calling For")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                    Caption = 'Enquiring For';
                }
                field(Departments; Rec.Departments)
                {
                    ApplicationArea = Basic;
                }
                field("Contact Mode"; Rec."Contact Mode")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Captured On"; Rec."Captured On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Employee Information")
            {
                Visible = false;
                field("Member No"; Rec."Member No")
                {
                    Caption = 'No.';
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Name';
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Current Deposits"; Rec."Current Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                Visible = false;
                field(Control22; Rec."Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if Rec."Employment Info" = Rec."employment info"::Employed then begin
                            EmployerCodeEditable := true;
                            DepartmentEditable := true;
                            TermsofEmploymentEditable := true;
                            ContractingEditable := false;
                            EmployedEditable := false;
                            OccupationEditable := false;
                            PositionHeldEditable := true;
                            EmploymentDateEditable := true;
                            EmployerAddressEditable := true;
                            NatureofBussEditable := false;
                            IndustryEditable := false;
                            BusinessNameEditable := false;
                            PhysicalBussLocationEditable := false;
                            YearOfCommenceEditable := false;



                        end else
                            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                                ContractingEditable := true;
                                EmployerCodeEditable := false;
                                DepartmentEditable := false;
                                TermsofEmploymentEditable := false;
                                OccupationEditable := false;
                                PositionHeldEditable := false;
                                EmploymentDateEditable := false;
                                EmployerAddressEditable := false;
                                NatureofBussEditable := false;
                                IndustryEditable := false;
                                BusinessNameEditable := false;
                                PhysicalBussLocationEditable := false;
                                YearOfCommenceEditable := false;
                            end else
                                if Rec."Employment Info" = Rec."employment info"::Others then begin
                                    OthersEditable := true;
                                    ContractingEditable := false;
                                    EmployerCodeEditable := false;
                                    DepartmentEditable := false;
                                    TermsofEmploymentEditable := false;
                                    OccupationEditable := false;
                                    PositionHeldEditable := false;
                                    EmploymentDateEditable := false;
                                    EmployerAddressEditable := false
                                end else
                                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                                        OccupationEditable := true;
                                        EmployerCodeEditable := false;
                                        DepartmentEditable := false;
                                        TermsofEmploymentEditable := false;
                                        ContractingEditable := false;
                                        EmployedEditable := false;
                                        NatureofBussEditable := true;
                                        IndustryEditable := true;
                                        BusinessNameEditable := true;
                                        PhysicalBussLocationEditable := true;
                                        YearOfCommenceEditable := true;
                                        PositionHeldEditable := false;
                                        EmploymentDateEditable := false;
                                        EmployerAddressEditable := false

                                    end;




                        /*IF "Identification Document"="Identification Document"::"Nation ID Card" THEN BEGIN
                          PassportEditable:=FALSE;
                          IDNoEditable:=TRUE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Passport Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=FALSE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Aliens Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=TRUE;
                        END;*/

                    end;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = EmployedEditable;
                }
                field("Employer Address"; Rec."Employer Address")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerAddressEditable;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation / Depot';
                    Editable = DepartmentEditable;
                }
                field("Terms of Employment"; Rec."Terms of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = TermsofEmploymentEditable;
                    ShowMandatory = true;
                }
                field("Date of Employment"; Rec."Date of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentDateEditable;
                }
                field("Position Held"; Rec."Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = PositionHeldEditable;
                }
                field("Expected Monthly Income"; Rec."Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyIncomeEditable;
                }
                field("Nature Of Business"; Rec."Nature Of Business")
                {
                    ApplicationArea = Basic;
                    Editable = NatureofBussEditable;
                }
                field(Industry; Rec.Industry)
                {
                    ApplicationArea = Basic;
                    Editable = IndustryEditable;
                }
                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = Basic;
                    Editable = BusinessNameEditable;
                }
                field("Physical Business Location"; Rec."Physical Business Location")
                {
                    ApplicationArea = Basic;
                    Editable = PhysicalBussLocationEditable;
                }
                field("Year of Commence"; Rec."Year of Commence")
                {
                    ApplicationArea = Basic;
                    Editable = YearOfCommenceEditable;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                }
                field("Others Details"; Rec."Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
                }
            }
            group("Referee Details")
            {
                Caption = 'Referee Details';
                Visible = false;
                field("Referee Member No"; Rec."Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee Name"; Rec."Referee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee ID No"; Rec."Referee ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Case Information")
            {
                field("Type of Cases"; Rec."Type of Cases")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        LoanNoVisible := false;
                        VarFosaAccountVisible := false;
                        if Rec."Type of Cases" = 'LOAN' then begin
                            LoanNoVisible := true;
                        end;

                        if Rec."Type of Cases" = 'FOSA' then begin
                            VarFosaAccountVisible := true;
                        end;
                    end;
                }
                group(FosaNo)
                {
                    Visible = VarFosaAccountVisible;
                }
                field("Fosa account"; Rec."Fosa account")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account No';
                    Visible = false;
                }
                group(LoanNo)
                {
                    Visible = LoanNoVisible;
                    field("Loan No"; Rec."Loan No")
                    {
                        ApplicationArea = Basic;
                        Visible = LoanNoVisible;
                    }
                }
                field("Employer Cases types"; Rec."Employer Cases types")
                {
                    ApplicationArea = Basic;
                    Editable = CaseEmployer;
                    Visible = false;
                }
                field("Case Description"; Rec.Description)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Caller Reffered To"; Rec."Caller Reffered To")
                {
                    ApplicationArea = Basic;
                    Caption = ' Escalate Case to:';
                }
                field("Escalated User Email"; Rec."Escalated User Email")
                {
                    ApplicationArea = Basic;
                }
                field("Case Resolution Details"; Rec."Case Resolution Details")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Editable = false;

                }
                field("Date of Escalation"; Rec."Date of Escalation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time of Escalation"; Rec."Time of Escalation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Resolved"; Rec."Date Resolved")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Resolved"; Rec."Time Resolved")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resolved User"; Rec."Resolved User")
                {
                    ApplicationArea = Basic;
                    Caption = 'Resolved By';
                    Editable = false;
                }
            }
            group("Employer Information")
            {
                Visible = false;
                field("Company No"; Rec."Company No")
                {
                    ApplicationArea = Basic;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = Basic;
                }
                field("Company Address"; Rec."Company Address")
                {
                    ApplicationArea = Basic;
                }
                field("Company postal code"; Rec."Company postal code")
                {
                    ApplicationArea = Basic;
                }
                field("Company Telephone"; Rec."Company Telephone")
                {
                    ApplicationArea = Basic;
                }
                field("Company Email"; Rec."Company Email")
                {
                    ApplicationArea = Basic;
                }
                field("Company website"; Rec."Company website")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            // part(Control41; "Member Statistics FactBox")
            // {
            //     Caption = 'BOSA Statistics FactBox';
            //     SubPageLink = "No." = field("Member No");
            // }
            // part(Control37; "FOSA Statistics FactBox")
            // {
            //     SubPageLink = "No." = field("Fosa account");
            // }
        }
    }

    actions
    {
        area(creation)
        {

            action("Escalate Case")
            {
                ApplicationArea = Basic;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Check if Issue already escalated
                    if Rec."Date of Escalation" <> 0D then begin
                        Error('Case already Escalated to %1', Rec."Caller Reffered To");
                    end;


                    Rec.TestField("Caller Reffered To");

                    //Get Case Information===============================================================================================
                    // IF "Calling As"="Calling As"::"As Member" THEN

                    if Confirm('Create a case  for ' + Rec."Member Name" + '.The case  will be given a new case Number. Continue?', false) = true then begin
                        //Create Invest Account
                        if CaseSetup.Get then begin
                            CaseSetup.TestField(CaseSetup."Cases nos");
                            CaseNO := NoSeriesMgt.GetNextNo(CaseSetup."Cases nos", 0D, true);
                            if CaseNO <> '' then begin
                                CASEM.Init;
                                CASEM."Case Number" := CaseNO;
                                CASEM."Member No." := Rec."Member No";
                                CASEM."Member No" := Rec."Member No";
                                CASEM."Member Name" := Rec."Member Name";
                                CASEM."Loan Balance" := Rec."Loan Balance";
                                CASEM."Share Capital" := Rec."Share Capital";
                                CASEM."Current Deposits" := Rec."Current Deposits";
                                CASEM."ID No" := Rec."ID No";
                                CASEM.Gender := Rec.Gender;
                                CASEM."FOSA Account." := Rec."Fosa account";
                                CASEM."Account Name." := Rec."Member Name";
                                CASEM."Loan No" := Rec."Loan No";
                                CASEM."Date of Complaint" := Today;
                                CASEM."Type of cases" := Rec."Type of Cases";
                                CASEM."Case Description" := Rec.Description;
                                CASEM."Time Sent" := Time;
                                CASEM."Date Sent" := Today;
                                CASEM."Case Received  Date" := Today;
                                CASEM."Captured On" := Rec."Captured On";
                                CASEM."Captured By" := Rec."Captured By";
                                CASEM."Date of Escalation" := Rec."Date of Escalation";
                                CASEM."Time of Escalation" := Rec."Time of Escalation";
                                CASEM."Receive date" := Today;
                                CASEM."Caller Reffered To" := Rec."Caller Reffered To";
                                CASEM."Case Description" := Rec.Description;
                                CASEM."Employment Info" := Rec."Employment Info";
                                CASEM."Employer Code" := Rec."Employer Code";
                                CASEM."Employer Name" := Rec."Employer Name";
                                CASEM."Others Details" := Rec."Others Details";
                                CASEM."Employment Terms" := Rec."Employment Terms";
                                CASEM."Employer Type" := Rec."Employer Type";
                                CASEM."Business Name" := Rec."Business Name";
                                CASEM."Nature Of Business" := Rec."Nature Of Business";
                                CASEM."Expected Monthly Income" := Rec."Expected Monthly Income";
                                CASEM.Industry := Rec.Industry;
                                CASEM."Physical Business Location" := Rec."Physical Business Location";
                                CASEM."Date of Employment" := Rec."Date of Employment";
                                CASEM."Year of Commence" := Rec."Year of Commence";
                                CASEM."Date of Employment" := Rec."Date of Employment";
                                CASEM."Referee Member No" := Rec."Referee Member No";
                                CASEM."Referee Name" := Rec."Referee Name";
                                CASEM."Referee ID No" := Rec."Referee ID No";
                                CASEM."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                                CASEM."Initiated Enquiry No" := Rec.No;
                                CASEM."Date of Escalation" := Today;
                                CASEM."Time of Escalation" := Time;
                                CASEM.Status := CASEM.Status::Escalated;
                                CASEM."Resource Assigned" := Rec."Caller Reffered To";
                                if CASEM."Case Number" <> '' then
                                    Rec.Send := true;

                                //Update Case Details==============================================
                                ObjCaseDetails.Reset;
                                ObjCaseDetails.SetRange(ObjCaseDetails."Case No", Rec.No);
                                if ObjCaseDetails.FindSet then begin
                                    repeat
                                        ObjCaseDetails2.Init;
                                        ObjCaseDetails2."Case No" := CaseNO;
                                        ObjCaseDetails2."Case Type" := ObjCaseDetails."Case Type";
                                        ObjCaseDetails2."Case Details" := ObjCaseDetails."Case Details";
                                        ObjCaseDetails2.Insert;
                                    until ObjCaseDetails.Next = 0;
                                end;
                                //End Update Case Details==============================================
                            end;
                            CASEM.Insert(true);
                            Message('Member Case successfully Escalated ');


                            FnSendEmailNotification();
                        end;
                    end;
                    //END;

                    //Company Case============================================================================================================
                    if Rec."Calling As" = Rec."calling as"::"As Employer" then begin
                        if (Rec."Calling For" = Rec."calling for"::Appreciation) or (Rec."Calling For" = Rec."calling for"::Complaint) or (Rec."Calling For" = Rec."calling for"::" ") or (Rec."Calling For" = Rec."calling for"::"ERP Support") or (Rec."Calling For" = Rec."calling for"::"IT Support") then begin
                            Rec.TestField("Employer Cases types");
                            Rec.TestField("Query Code");
                            Sure := Confirm('Create a case  for ' + Rec."Member Name" + '.The case  will be given a new case Number. Continue?');
                            if Sure then begin

                                if CaseSetup.Get then begin
                                    CaseSetup.TestField(CaseSetup."Cases nos");
                                    CaseNO := NoSeriesMgt.GetNextNo(CaseSetup."Cases nos", 0D, true);
                                    if CaseNO <> '' then begin
                                        CASEM.Init;
                                        CASEM."Case Number" := CaseNO;
                                        CASEM."Company No" := Rec."Query Code";
                                        CASEM."Company Name" := Rec."Company Name";
                                        CASEM."Company Address" := Rec."Company Address";
                                        CASEM."Company Email" := Rec."Company Email";
                                        CASEM."Date of Complaint" := Today;
                                        CASEM."Case Received  Date" := Today;
                                        CASEM."Company postal code" := Rec."Company postal code";
                                        CASEM."Company Telephone" := Rec."Company Telephone";
                                        CASEM."Type of cases" := Rec."Employer Cases types";
                                        CASEM."Time Sent" := Time;
                                        CASEM."Date Sent" := Today;
                                        CASEM."Receive date" := Today;
                                        CASEM."Caller Reffered To" := Rec."Caller Reffered To";
                                        CASEM."Case Description" := Rec.Description;
                                        if CASEM."Case Number" <> '' then
                                            Rec.Send := true;
                                        Message('Employer Case created ');
                                    end;
                                    CASEM.Insert(true);
                                end;
                            end;
                        end;
                    end;
                end;
            }
            action("Mark Resolved")
            {
                ApplicationArea = Basic;
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Case Resolution Details");
                    if Rec.Status = Rec.Status::Resolved then begin
                        Error('Case already resolved');
                    end;


                    //Create Case Under Case Management Table================================================================
                    if CaseSetup.Get then begin
                        CaseSetup.TestField(CaseSetup."Cases nos");
                        CaseNO := NoSeriesMgt.GetNextNo(CaseSetup."Cases nos", 0D, true);
                        if CaseNO <> '' then begin
                            CASEM.Init;
                            CASEM."Case Number" := CaseNO;
                            CASEM."Member No." := Rec."Member No";
                            CASEM."Member No" := Rec."Member No";
                            CASEM."Member Name" := Rec."Member Name";
                            CASEM."Loan Balance" := Rec."Loan Balance";
                            CASEM."Share Capital" := Rec."Share Capital";
                            CASEM."Current Deposits" := Rec."Current Deposits";
                            CASEM."ID No" := Rec."ID No";
                            CASEM.Gender := Rec.Gender;
                            CASEM."FOSA Account." := Rec."Fosa account";
                            CASEM."Account Name." := Rec."Member Name";
                            CASEM."Loan No" := Rec."Loan No";
                            CASEM."Date of Complaint" := Today;
                            CASEM."Type of cases" := Rec."Type of Cases";
                            CASEM."Case Description" := Rec.Description;
                            CASEM."Time Sent" := Time;
                            CASEM."Date Sent" := Today;
                            CASEM."Case Received  Date" := Today;
                            CASEM."Captured On" := Rec."Captured On";
                            CASEM."Captured By" := Rec."Captured By";
                            CASEM."Date of Escalation" := Rec."Date of Escalation";
                            CASEM."Time of Escalation" := Rec."Time of Escalation";
                            CASEM."Receive date" := Today;
                            CASEM."Caller Reffered To" := Rec."Caller Reffered To";
                            CASEM."Case Description" := Rec.Description;
                            CASEM."Employment Info" := Rec."Employment Info";
                            CASEM."Employer Code" := Rec."Employer Code";
                            CASEM."Employer Name" := Rec."Employer Name";
                            CASEM."Others Details" := Rec."Others Details";
                            CASEM."Employment Terms" := Rec."Employment Terms";
                            CASEM."Employer Type" := Rec."Employer Type";
                            CASEM."Business Name" := Rec."Business Name";
                            CASEM."Nature Of Business" := Rec."Nature Of Business";
                            CASEM."Expected Monthly Income" := Rec."Expected Monthly Income";
                            CASEM.Industry := Rec.Industry;
                            CASEM."Physical Business Location" := Rec."Physical Business Location";
                            CASEM."Date of Employment" := Rec."Date of Employment";
                            CASEM."Year of Commence" := Rec."Year of Commence";
                            CASEM."Date of Employment" := Rec."Date of Employment";
                            CASEM."Referee Member No" := Rec."Referee Member No";
                            CASEM."Referee Name" := Rec."Referee Name";
                            CASEM."Referee ID No" := Rec."Referee ID No";
                            CASEM.Status := CASEM.Status::Escalated;
                            CASEM."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                            CASEM."Case Resolution Details" := Rec."Case Resolution Details";
                            CASEM."Date Resolved" := Today;
                            CASEM."Time Resolved" := Time;
                            CASEM."Resolved User" := UserId;
                            CASEM.Status := CASEM.Status::Resolved;
                            CASEM.Insert;
                            if CASEM."Case Number" <> '' then
                                Rec.Send := true;

                            //Update Case Details==============================================
                            ObjCaseDetails.Reset;
                            ObjCaseDetails.SetRange(ObjCaseDetails."Case No", Rec.No);
                            if ObjCaseDetails.FindSet then begin
                                repeat
                                    ObjCaseDetails2.Init;
                                    ObjCaseDetails2."Case No" := CaseNO;
                                    ObjCaseDetails2."Case Type" := ObjCaseDetails."Case Type";
                                    ObjCaseDetails2."Case Details" := ObjCaseDetails."Case Details";
                                    ObjCaseDetails2.Insert;
                                until ObjCaseDetails.Next = 0;
                            end;
                            //End Update Case Details==============================================
                        end;
                    end;
                    //CASEM.INSERT(TRUE);
                    if Confirm('Are you sure you want to mark this case as resolved?', false) = true then begin
                        Rec.Status := Rec.Status::Resolved;
                        Rec."Date Resolved" := Today;
                        Rec."Time Resolved" := Time;
                    end;

                    Message('Member Case Resolved successfully');

                end;
            }
            action("Additional Case Details")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Case Details";
                RunPageLink = "Case No" = field(No);
            }


        }
    }

    trigger OnAfterGetRecord()
    begin
        AsEmployer := false;
        Asmember := false;
        AsNonmember := false;
        Asother := false;
        Ascase := false;
        CaseEmployer := false;
        CaseEnabled := false;
        if Rec."Calling As" = Rec."calling as"::"As Member" then begin
            Asmember := true;
            AsEmployer := true;
            Ascase := true;
            CaseEnabled := true;

        end;
        if Rec."Calling As" = Rec."calling as"::"As Non Member" then begin
            AsNonmember := true;
            Asother := true;
        end;
        if Rec."Calling As" = Rec."calling as"::"As Employer" then begin
            AsEmployer := true;
            Asother := true;
            Ascase := true;
            CaseEmployer := true;
        end;

        if Rec."Employment Info" = Rec."employment info"::Employed then begin
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                ContractingEditable := false;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if Rec."Employment Info" = Rec."employment info"::Others then begin
                    OthersEditable := false;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                        OccupationEditable := false;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := false;
                        IndustryEditable := false;
                        BusinessNameEditable := false;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := false;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;


        LoanNoVisible := false;
        VarFosaAccountVisible := false;
        if Rec."Type of Cases" = 'LOAN' then begin
            LoanNoVisible := true;
        end;

        if Rec."Type of Cases" = 'FOSA' then begin
            VarFosaAccountVisible := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        AsEmployer := false;
        Asmember := false;
        AsNonmember := false;
        Asother := false;
        Ascase := false;
        CaseEmployer := false;
        CaseEnabled := false;

        if Rec."Calling As" = Rec."calling as"::"As Member" then begin
            Asmember := true;
            AsEmployer := false;
            Ascase := true;
            CaseEnabled := true;

        end;
        if Rec."Calling As" = Rec."calling as"::"As Employer" then begin
            AsEmployer := true;
            Ascase := true;
            CaseEmployer := true;

        end;

        if Rec."Employment Info" = Rec."employment info"::Employed then begin
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                ContractingEditable := false;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if Rec."Employment Info" = Rec."employment info"::Others then begin
                    OthersEditable := false;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                        OccupationEditable := false;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := false;
                        IndustryEditable := false;
                        BusinessNameEditable := false;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := false;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;

        LoanNoVisible := false;
        VarFosaAccountVisible := false;
        if Rec."Type of Cases" = 'LOAN' then begin
            LoanNoVisible := true;
        end;

        if Rec."Type of Cases" = 'FOSA' then begin
            VarFosaAccountVisible := true;
        end;
    end;

    var
        Cust: Record Customer;
        // PvApp: Record "Member Ledger Entry";
        CustCare: Record "General Equiries.";
        CQuery: Record "General Equiries.";
        //  employer: Record "Sacco Employers";
        //   membApp: Record "Membership Applications";
        //   LeadM: Record "Lead Management";
        entry: Integer;
        vend: Record Vendor;
        CASEM: Record "Cases Management";
        AsEmployer: Boolean;
        Asmember: Boolean;
        AsNonmember: Boolean;
        Asother: Boolean;
        Ascase: Boolean;
        // Leadacc: Record "Lead Management";
        // LeadAcc2: Record "Lead Management";
        OK: Boolean;
        LeadSetup: Record "Crm General Setup.";
        LeadNo: Code[10];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CaseNO: Code[10];
        CaseSetup: Record "Crm General Setup.";
        Sure: Boolean;
        Yah: Boolean;
        CaseEnabled: Boolean;
        CaseEmployer: Boolean;
        EmploymentInfoEditable: Boolean;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmployerCodeEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        OccupationEditable: Boolean;
        OthersEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        LoanNoVisible: Boolean;
        ObjCaseDetails: Record "Case Details";
        ObjCaseDetails2: Record "Case Details";
        CaseNotification: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Case Resolution Notification</p><p style="font-family:Verdana,Arial;font-size:9pt">You have been assigned a Member case no: %2  belonging to Member No  %3  by %4. Login to the case management module to see full details of the case,</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%5</p></br><br><p><b><i>%6</i></b></p>';
        CaseNotification12: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Case Resolution Notification</p><p style="font-family:Verdana,Arial;font-size:9pt">You have been assigned a Member case no: %2  belonging to Member No  %3  by %4. Login to the case management module to see full details of the case,</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%5</p></br><br><p><b><i>%6</i></b></p>';

        VarFosaAccountVisible: Boolean;
        ObjUser: Record User;
        VarEscalatedtoEmail: Text[50];
        Recipient: List of [Text];
        companyinfo: Record "Company Information";

    local procedure FnSendEmailNotification()
    var
        // SMTPSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        //SMTPSetup.Get();



        ObjUser.Reset;
        ObjUser.SetRange(ObjUser."User Name", Rec."Caller Reffered To");
        if ObjUser.Find('-') then begin
            VarEscalatedtoEmail := ObjUser."Contact Email";
        end;

        if VarEscalatedtoEmail <> '' then
            Recipient.Add(VarEscalatedtoEmail);
        //Message(format(Recipient));
        // CompanyInfo.get();
        // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Case Resolution Assignment Notification', '', true);
        // SMTPMail.AppendBody(StrSubstNo(CaseNotification12, "Caller Reffered To", No, "Member No", UserId, UserId, CompanyInfo.Name));
        // SMTPMail.AppendBody('<br><br>');
        // SMTPMail.AddAttachment(FileName, Attachment);
        // SMTPMail.Send;
        // Message('Email Sent sent');
    end;
}