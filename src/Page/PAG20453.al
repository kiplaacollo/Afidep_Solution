page 20453 "Project Tracker Card"
{
    // Serenic Navigator - (c)Copyright Serenic Software, Inc. 1999-2013.
    // By opening this object you acknowledge that this object includes confidential information
    // and intellectual property of Serenic Software, Inc., and that this work is protected by US
    // and international copyright laws and agreements.
    // ------------------------------------------------------------------------------------------

    Caption = 'Project card';
    PageType = Document;
    PopulateAllFields = true;
    RefreshOnActivate = true;
    SourceTable = 170430;
    SourceTableView = SORTING("Document Type")
                      WHERE("Document Type" = CONST(Award));
    DeleteAllowed = false;
    InsertAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                Enabled = false;
                field("No."; Rec."No.")
                {
                    //Editable = "NoEditable";



                }
                field("Global Dimension 5 Code"; Rec."Global Dimension 5 Code")
                {
                    // Editable = GlobalDimension4CodeEditable;
                }

                field(Name; Rec.Name)
                {
                    Caption = 'Name of project(Short Title)';
                    ToolTip = 'Create A project first';

                    trigger OnValidate()
                    var
                        dimnsionval: Record "Dimension Value";
                    BEGIN
                        dimnsionval.get('PROJECTS', rEC."No.");

                        //dimnsionval.Code := Rec."No.";
                        // dimnsionval."Global Dimension No." := 2;
                        //dimnsionval."Dimension Code" := 'PROJECTS';
                        dimnsionval.Name := Rec.Name;
                        dimnsionval."Dimension Value Type" := dimnsionval."Dimension Value Type"::Standard;
                        dimnsionval.Modify;


                    END;

                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description(Long Title)';
                    trigger OnValidate()
                    var
                        dimnsionval: Record "Dimension Value";
                    BEGIN
                        dimnsionval.get('PROJECTS', rEC."No.");

                        //dimnsionval.Code := Rec."No.";
                        // dimnsionval."Global Dimension No." := 2;
                        //dimnsionval."Dimension Code" := 'PROJECTS';
                        dimnsionval.Description := Rec.Description;
                        dimnsionval."Dimension Value Type" := dimnsionval."Dimension Value Type"::Standard;
                        dimnsionval.Modify;


                    END;
                }

                field("Description 2"; Rec."Description 2")
                {
                    Visible = false;
                }
                field(SponsoringFunderNo; Rec."Sponsoring Funder No.")
                {
                    TableRelation = "Dimension Value".Code where("Dimension Code" = const('DONOR'),
                                                          Blocked = const(false));
                    trigger OnValidate()
                    var
                        dimnsionval: Record "Dimension Value";
                    BEGIN
                        IF dimnsionval.Get(Rec."Sponsoring Funder No.") then
                            rec."Sponsoring Funder Name" := dimnsionval.Name;
                        Rec.Modify(true);
                    end;

                }
                field("Sponsoring Funder Name"; Rec."Sponsoring Funder Name")
                {
                    // DrillDown = false;
                    Editable = false;
                    TableRelation = "Dimension Value".Name where("Dimension Code" = const('DONOR'),
                                                          Blocked = const(false));
                    trigger OnValidate()
                    var
                        dimnsionval: Record "Dimension Value";
                    BEGIN
                        IF dimnsionval.Get(Rec."Sponsoring Funder No.") then
                            rec."Sponsoring Funder Name" := dimnsionval.Name;
                        Rec.Modify(true);
                    end;
                }
                field("Originating Funder No."; Rec."Originating Funder No.")
                {
                    Visible = false;
                }
                field("Originating Funder Name"; Rec."Originating Funder Name")
                {
                    DrillDown = false;
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    Caption = 'Search Name(Short Title)';
                }
                field("Start Date"; Rec."Start Date")
                {

                    trigger OnValidate()
                    begin
                        // StartDateOnAfterValidate;
                    end;
                }
                field("End Date"; Rec."End Date")
                {

                    trigger OnValidate()
                    begin
                        //IF "Allow Posting To" = 0D THEN
                        // VALIDATE("Allow Posting To","End Date");
                    end;
                }
                field(Type; Rec.Type)
                {
                }
                field(Class; Rec.Class)
                {
                    Caption = 'Likelihood';
                    Visible = false;
                }




                field(Blocked; Rec.Blocked)
                {
                }


            }
            group(Metrics)
            {
                Editable = false;
                Enabled = false;

                field("Amount awarded"; Rec."Amount awarded")
                {

                }
                field("Amount invoiced to donors"; Rec."Amount invoiced to donors")
                {
                    //
                }
                field("Budgeted cost"; Rec."Budgeted cost")
                {

                }
                field("Received amount"; rec."Received amount")
                {

                }
                field("Total ependiture"; Rec."Total expenditure")
                {

                }
                field("Remaining amount"; Rec."Remaining amount")
                {
                    Editable = false;
                }
                field("% Utilization"; Rec."% Utilization")
                {
                    Editable = false;
                }

            }

            group(Reference)
            {
                Caption = 'Reference';
                Visible = false;
                field("Funder's Reference No."; Rec."Funder's Reference No.")
                {

                }
                field("Reference No."; Rec."Reference No.")
                {
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                }
                field("CFDA Number"; Rec."CFDA Number")
                {
                }
                field("Appropriation Number"; Rec."Appropriation Number")
                {
                }
                field("Subaward Clearance Threshold"; Rec."Subaward Clearance Threshold")
                {
                    //Visible = SubAwardClearanceThresholdVisi;
                }
                field("Publication Code"; Rec."Publication Code")
                {
                }
                field("Publication Page No."; Rec."Publication Page No.")
                {
                }
                field("Publication Date"; Rec."Publication Date")
                {
                }
                field("Line Item Flexibility %"; Rec."Line Item Flexibility %")
                {
                }
            }
            group(Rules)
            {
                Caption = 'Rules';
                Visible = false;
                field("Restriction Checking"; Rec."Restriction Checking")
                {
                }
                field("Revenue Recognition Code"; Rec."Revenue Recognition Code")
                {
                    //  LookupPageID = "Rev. Rec. Rule List";
                }
                field("Indirect Cost Recovery Code"; Rec."Indirect Cost Recovery Code")
                {
                    // LookupPageID = "IDC Rule List";
                }
                field("Invoice Rule Code"; Rec."Invoice Rule Code")
                {
                    //LookupPageID = "Invoice Rule List";
                }
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                }
                field("Fiscal Year Start Date"; Rec."Fiscal Year Start Date")
                {
                }
                field("Matching Required"; Rec."Matching Required")
                {
                }
                field("Allow Matching Excess"; Rec."Allow Matching Excess")
                {
                    ToolTip = 'Allow posting to exceed match amount';
                }
                field("Matching Award Rate Code"; Rec."Matching Award Rate Code")
                {

                    trigger OnValidate()
                    begin
                        //  MatchingAwardRateCodeOnAfterVa;
                    end;
                }
            }
            part("Notification Users"; "Notification Users")
            {
                SubPageLink = "Proposal No." = FIELD("No.");
            }
            part("Award notifications"; 17259)
            {
                Caption = 'Project notifications';
                SubPageLink = "Award No" = FIELD("No.");
            }
            part("Countries/Regions"; 17301)
            {
                Visible = false;
                Caption = 'Countries/Regions';
                SubPageLink = "Award No" = FIELD("No.");
            }
            part("Project Team"; 17302)
            {
                SubPageLink = "Proposal No." = FIELD("No.");
            }
            part("Project Partners"; 17288)
            {
                Visible = false;
                Caption = 'Project Partners';
                SubPageLink = "Proposal Code" = FIELD("No.");
            }

            part("Project Indicators"; "Project Indicators")

            {
                Caption = 'Project Indicators';
                SubPageLink = "Award No" = FIELD("No.");
            }


            group("Required Matching Amount")
            {
                Visible = false;



            }
            group(Audit)
            {
                Caption = 'Audit';
                Visible = false;
                field("Created By"; Rec."Created By")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    Importance = Promoted;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Importance = Promoted;
                }
                field("Source Company Name"; Rec."Source Company Name")
                {
                }
            }
        }
        area(factboxes)
        {





        }
    }

    actions
    {
        area(navigation)
        {

            action(Convet)
            {
                Visible = false;
                ApplicationArea = Dimensions;
                Caption = 'Create project from award';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                //ToolTip = 'Shows the budget of specific projects';

                var
                    dimnsionval: Record "Dimension Value";
                BEGIN
                    dimnsionval.reset;
                    dimnsionval.SetRange(code, Rec."No.");
                    if not dimnsionval.find('-') then begin
                        dimnsionval.Init();

                        dimnsionval.Code := Rec."No.";
                        dimnsionval."Global Dimension No." := 2;
                        dimnsionval."Dimension Code" := 'PROJECTS';
                        dimnsionval."Thematic Code" := Rec."Global Dimension 5 Code";
                        dimnsionval.Insert(true);
                        Message('Dimension project code' + rec."No." + ' and name' + rec.Name + 'Has been created successfull ');
                    end else begin
                        error('Dimension project already exists');
                    end;


                END;

            }
            action(Project3)
            {
                Visible = false;
                ApplicationArea = Dimensions;
                Caption = 'Exp Category';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Dimension Values";
                RunPageLink = "Dimension Code" = const('EXPCATEGORIES'), "Project Code" = field("No.");
                ToolTip = 'Shows the budget of specific projects';
            }
            action(Project2)
            {
                Visible = false;
                ApplicationArea = Dimensions;
                Caption = 'Budget Upload';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Project List Afidep";
                RunPageLink = "Dimension Code" = const('BUDGETLINES'), "Project Code" = field("No.");
                ToolTip = 'Shows the budget of specific projects';
            }
            action(Project)
            {
                Visible = false;
                ApplicationArea = Dimensions;
                Caption = 'Budget Report';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Project Budget";
                RunPageLink = "Dimension Code" = const('BUDGETLINES'), "Project Code" = field("No.");
                ToolTip = 'Shows the budget of specific projects';
            }






            action("<Action1102628000>")
            {
                Caption = 'Milestones ';
                Image = BOMVersions;
                RunObject = Page Milestones;
                RunPageLink = "Award No." = FIELD("No.");

            }

            action("File Attachments")
            {
                Caption = 'File Attachments';
                Image = Attachments;


            }


            action("<Action1102628071>")
            {
                Caption = 'Terms && Conditions';
                Image = BulletList;

                trigger OnAction()
                begin
                    TermsConditions;
                end;
            }



            action("Change status to active")
            {
                Visible = false;
                Caption = 'Change status to active';
                Image = Approval;

                trigger OnAction()
                begin
                    Rec.Blocked := Rec.Blocked::" ";
                end;
            }

            action("Change status to Closed")
            {
                Visible = false;
                Caption = 'Change status to closed';
                Image = Approval;

                trigger OnAction()
                begin
                    Rec.Blocked := Rec.Blocked::Closed;
                end;
            }


            action("<Action1102628084>")
            {
                Visible = false;
                Caption = 'Restrictions';
                Image = Confirm;
                RunObject = Page 17420;
                RunPageLink = "Award No." = FIELD("No.");
            }


            group(Activity)
            {
                Caption = 'Activity';
                Image = Entries;
                group(Entries)
                {
                    Caption = 'Entries';
                    Image = Entries;


                }
                action("<Action1102628072>")
                {
                    Caption = 'Milestones';
                    Image = TaskList;
                    // RunObject = Page MILESTONES;
                    // RunPageLink = "Award No."=FIELD("No.");
                }



                group(Matching)
                {
                    Caption = 'Matching';
                    Image = Relationship;


                }




            }
        }
        area(processing)
        {
            group(FunctionButtonAdvance)
            {
                Caption = 'F&unctions';
                Image = "Action";
                Visible = FALSE;
                action("<Action1102633048>")
                {
                    Caption = 'Create &Lines';
                    Image = ChangeToLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /*IF "Proposal No." <> '' THEN BEGIN
                          MESSAGE(SNText001);
                          EXIT;
                        END;
                        
                        IF Phase = Phase::Awarded THEN BEGIN
                          MESSAGE(SNText003);
                          EXIT;
                        END;*/



                    end;
                }







            }
        }
    }











    var
        GLSetup: Record "98";

        MatchingAmounts: array[3] of Decimal;

        RCYMatchingAmountVisible: Boolean;

        ACYMatchingAmountVisible: Boolean;

        CurrencyCodeVisible: Boolean;

        SubAwardClearanceThresholdVisi: Boolean;

        NoEditable: Boolean;

        FundNoEditable: Boolean;

        GlobalDimension1CodeEditable: Boolean;

        GlobalDimension2CodeEditable: Boolean;

        GlobalDimension3CodeEditable: Boolean;

        GlobalDimension4CodeEditable: Boolean;

        GlobalDimension5CodeEditable: Boolean;

        GlobalDimension6CodeEditable: Boolean;

        GlobalDimension7CodeEditable: Boolean;

        GlobalDimension8CodeEditable: Boolean;
        SNText002: Label 'The selected function cannot be performed until Create Lines has been processed.';

        CurrencyCodeEditable: Boolean;
        SNText003: Label 'Additional entries cannot be entered using Create Lines when the status is Awarded.  \The estimate can be updated by processing a modification.';

        ModificationEnabled: Boolean;
        SNText004: Label 'Sponsoring Funder No. must have a value for the Award before you can open the Create Lines page.';

    procedure ActivateFields()
    begin





    end;

    procedure Drilldown(AwardNo: Code[20]; EntryType: Option " ",Proposal,,Estimate,,Obligation,,Modification,,,,Subaward,,,"Indirect Cost",Revenue,Disbursement,Receipt)
    //  AVLedgEntry: Record "170444";
    begin

    end;

    procedure TermsConditions()
    begin
        //   EFExtendedFieldsMgt.TermsAndCondOpenEFDetails("No.", '', '');
    end;

    local procedure NoOnAfterValidate()
    begin
        ActivateFields;
    end;

    local procedure StartDateOnAfterValidate()
    begin
        //  IF "Allow Posting From" = 0D THEN
        //   VALIDATE("Allow Posting From","Start Date");
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.UPDATE(FALSE);
        // AVManagement.CalcMatching("No.",MatchingAmounts,'');
    end;

    local procedure MatchingAwardRateCodeOnAfterVa()
    begin
        CurrPage.UPDATE(TRUE);
        // AVManagement.CalcMatching("No.",MatchingAmounts,'');
    end;



    trigger
    OnOpenPage()
    begin
        IF Rec."No." <> '' THEN BEGIN
            rec.CalcFields("Budgeted cost", "Total expenditure");

            Rec."Remaining amount" := Rec."budgeted cost" - rec."Total expenditure";
            if Rec."Budgeted cost" <> 0 then
                Rec."% Utilization" := Round((rec."Total expenditure" / Rec."Budgeted cost") * 100, 0.01, '>');

            REC.Modify();
            CurrPage.Update();
        END;
    end;
}

