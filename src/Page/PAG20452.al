page 20452 "Project Tracker List"
{
    // Serenic Navigator - (c)Copyright Serenic Software, Inc. 1999-2013.
    // By opening this object you acknowledge that this object includes confidential information
    // and intellectual property of Serenic Software, Inc., and that this work is protected by US
    // and international copyright laws and agreements.
    // ------------------------------------------------------------------------------------------

    Caption = 'Award List';
    Editable = false;
    PageType = List;
    SourceTable = 170430;
    SourceTableView = WHERE("Document Type" = CONST(Award));
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(R)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Status';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Nom';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'Désignation 2';
                    Visible = false;
                }
                field("Sponsoring Funder Name"; Rec."Sponsoring Funder Name")
                {
                }

                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Sponsoring Funder No."; Rec."Sponsoring Funder No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Originating Funder No."; Rec."Originating Funder No.")
                {
                    Visible = false;
                }
                field("Global Dimension 4 Code"; Rec."Global Dimension 4 Code")
                {
                    Visible = false;
                }
                field(Phase; Rec.Phase)
                {
                    Visible = false;
                }
                field("AV Posting Group"; Rec."AV Posting Group")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 5 Code"; Rec."Global Dimension 5 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 6 Code"; Rec."Global Dimension 6 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 7 Code"; Rec."Global Dimension 7 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 8 Code"; Rec."Global Dimension 8 Code")
                {
                    Visible = false;
                }
                field("Inter-Company Name"; Rec."Inter-Company Name")
                {
                    Visible = false;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    Caption = 'Budget Amount';
                    Visible = false;
                }
                //
            }
        }
        area(factboxes)
        {


            systempart(Links; Links)
            {
            }
            systempart(Notes; Notes)
            {
            }


        }
    }

    actions
    {
        area(navigation)
        {
            group(Award)
            {
                Caption = '&Award';
                Image = SpecialOrder;
                action(mip2)
                {
                    Caption = 'Import Estimate Lines';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(80046, FALSE, TRUE);
                    end;
                }
                action(imp)
                {
                    Caption = 'Import Estimate Line Details';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(80047, FALSE, TRUE);
                    end;
                }


                action("File Attachments")
                {
                    Caption = 'File Attachments';
                    Image = Attachments;

                    trigger OnAction()
                    var
                        FileAttachment: Record "170502";
                    begin
                        FileAttachment.FILTERGROUP(10);
                        // FileAttachment.SETRANGE("Table ID",DATABASE::Award);
                        //  FileAttachment.SETRANGE("Primary Key Value 1","No.");
                        PAGE.RUN(0, FileAttachment);
                    end;
                }


                action("<Action1102628071>")
                {
                    Caption = 'Terms && Conditions';
                    Image = BulletList;

                    trigger OnAction()
                    begin
                        // TermsConditions;
                    end;
                }



                action("<Action1102628084>")
                {
                    Caption = 'Restrictions';
                    Image = Confirm;
                    RunObject = Page 17420;
                    RunPageLink = "Award No." = FIELD("No.");
                }

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
                    RunObject = Page 25004;
                    RunPageLink = "Award No." = FIELD("No.");
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
            action(New)
            {
                Caption = 'New';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page 20453;
                RunPageMode = Create;
                ShortCutKey = 'Shift+F7';
                Visible = NewVisible;
                Enabled = false;

            }
            action(DoubleClick)
            {
                Caption = 'Edit';
                Image = Edit;
                ShortCutKey = 'Return';
                Visible = false;

                trigger OnAction()
                begin
                    PAGE.RUN(PAGE::"Project Tracker Card", Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnInit()
    begin
        NewVisible := TRUE;
        ModificationEnabled := TRUE;
    end;

    trigger OnOpenPage()
    begin

    end;

    var
        // EFExtendedFieldsMgt: Codeunit "131076";
        [InDataSet]
        NewVisible: Boolean;
        [InDataSet]
        ModificationEnabled: Boolean;
        "Unit desc": Text;
        DimensionValue: Record "349";

    procedure GetSelectionFilter(): Text
    var
        Award: Record "170430";
        SelectionFilterManagement: Codeunit "46";
    begin
        CurrPage.SETSELECTIONFILTER(Award);
        // EXIT(SelectionFilterManagement.GetSelectionFilterForAward(Award));
    end;

    procedure SetSelection(var Award: Record "170430")
    begin
        CurrPage.SETSELECTIONFILTER(Award);
    end;

    procedure TermsConditions()
    begin
        //  EFExtendedFieldsMgt.TermsAndCondOpenEFDetails("No.", '', '');
    end;
}

