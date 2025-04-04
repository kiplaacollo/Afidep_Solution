page 25004 Milestones
{
    // Serenic Navigator - (c)Copyright Serenic Software, Inc. 1999-2013.
    // By opening this object you acknowledge that this object includes confidential information
    // and intellectual property of Serenic Software, Inc., and that this work is protected by US
    // and international copyright laws and agreements.
    // ------------------------------------------------------------------------------------------

    AutoSplitKey = true;
    Caption = 'Milestones';
    DelayedInsert = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 170460;
    SourceTableView = SORTING("Award No.","Due Date","Completion Date");

    layout
    {
        area(content)
        {
            repeater(r)
            {
                field("Line No.";Rec."Line No.")
                {
                }
                field("Activity Type Code";Rec."Activity Type Code")
                {
                }
                field(Description;Rec.Description)
                {
                }
                field("Due Date";Rec."Due Date")
                {
                }
                field("Completion Date";Rec."Completion Date")
                {

                    trigger OnValidate()
                    begin
                       // CompletionDateOnAfterValidate;
                    end;
                }
                field(Status;Rec.Status)
                {
                }
                field("Predecessor Activity";Rec."Predecessor Activity")
                {
                }
                field("Predecessor Milestone No.";Rec."Predecessor Milestone No.")
                {
                    Visible = false;
                }
                field("Predecessor Milestone Line No.";Rec."Predecessor Milestone Line No.")
                {
                    Lookup = false;
                }
                field("Recurring Frequency";Rec."Recurring Frequency")
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
            group(Milestones)
            {
                Caption = '&Milestones';
                Image = CodesList;
                action(FileAttachments)
                {
                    Caption = 'File Attachments';
                    Image = Attachments;

                    trigger OnAction()
                    begin
                        FileAttachment(Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            action("<Action1102633006>")
            {
                Caption = 'Ne&w';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    NewMilestone;
                end;
            }
        }
    }

    var
        AVText001: Label 'Create a new %1 for %2 %3?';

    procedure GetRecord(var TempRec: Record "170460")
    begin
        TempRec := Rec;
    end;

    procedure NewMilestone()
    var
        Award: Record "170430";
        Milestone: Record "170460";
    begin
       // TESTFIELD("Award No.");
      //  Award.GET("Award No.");

        Milestone.INIT;
        Milestone."Award No." := Award."No.";
        Milestone.INSERT(TRUE);
        Milestone.SETRANGE("Award No.",Award."No.");
        COMMIT;
        //PAGE.RUNMODAL(PAGE::"Milestone Card",Milestone);
    end;

    local procedure CompletionDateOnAfterValidate()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    procedure FileAttachment(Milestone: Record "170460")
    var
        FileAttachment: Record "170502";
    begin
       
    end;
}

