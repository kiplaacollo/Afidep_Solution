table 170460 Milestone
{
    // Serenic Navigator - (c)Copyright Serenic Software, Inc. 1999-2011.
    // By opening this object you acknowledge that this object includes confidential information
    // and intellectual property of Serenic Software, Inc., and that this work is protected by US
    // and international copyright laws and agreements.
    // ------------------------------------------------------------------------------------------

    Caption = 'Milestone';
    DrillDownPageID = 25004;
    LookupPageID = 25004;

    fields
    {
        field(1;"Award No.";Code[10])
        {
            Caption = 'Award No.';
            TableRelation = Award;
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(10;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(15;"Due Date";Date)
        {
            Caption = 'Due Date';
        }
        field(20;"Completion Date";Date)
        {
            Caption = 'Completion Date';

            trigger OnValidate()
            var
                NextPredecessorMilestone: Record "170460";
            begin
                IF "Completion Date" <> 0D THEN BEGIN
                  IF "Predecessor Activity" <> '' THEN BEGIN
                    Milestone.GET("Predecessor Milestone No.","Predecessor Milestone Line No.");
                    IF Milestone."Completion Date" = 0D THEN
                      ERROR(SNText004);
                  END;

                  IF FORMAT("Recurring Frequency") <> '' THEN BEGIN
                    IF CurrFieldNo = FIELDNO("Completion Date") THEN BEGIN
                      IF NOT CONFIRM(SNText001,TRUE) THEN
                        EXIT;
                    END ELSE BEGIN
                      IF NOT CONFIRM(SNText006,TRUE,"Award No.","Activity Type Code") THEN
                        EXIT;
                    END;
                    Milestone := Rec;
                    Milestone."Due Date" := CALCDATE(Milestone."Recurring Frequency",Milestone."Due Date");
                    Milestone."Completion Date" := 0D;
                    IF "Predecessor Activity" <> '' THEN BEGIN
                      NextPredecessorMilestone.SETRANGE("Award No.",Milestone."Predecessor Milestone No.");
                      NextPredecessorMilestone.SETRANGE("Activity Type Code",Milestone."Predecessor Activity");
                      NextPredecessorMilestone.SETFILTER("Line No.",'>%1',Milestone."Predecessor Milestone Line No.");
                      NextPredecessorMilestone.SETRANGE("Completion Date",0D);
                      IF NextPredecessorMilestone.FINDFIRST THEN
                        Milestone."Predecessor Milestone Line No." := NextPredecessorMilestone."Line No."
                      ELSE
                        Milestone.VALIDATE("Predecessor Milestone No.",'');
                    END;
                    IF NOT Milestone.INSERT THEN
                      REPEAT
                        Milestone."Line No." += 10000;
                      UNTIL Milestone.INSERT;
                  END;
                END;
            end;
        }
        field(25;"Activity Type Code";Code[10])
        {
            Caption = 'Activity Type Code';
            NotBlank = true;
            //TableRelation = "AV Activity Type";

            trigger OnValidate()
            begin
                IF "Activity Type Code" <> '' THEN
                  IF Description = '' THEN BEGIN
                  //  ActivityType.GET("Activity Type Code");
                  //  Description := ActivityType.Description;
                  END;
            end;
        }
        field(30;"Predecessor Activity";Code[10])
        {
            Caption = 'Predecessor Activity';

            trigger OnLookup()
            begin
                CLEAR(Milestones);
                Milestone.RESET;
                Milestone.SETRANGE("Award No.","Award No.");
                Milestone.SETFILTER("Line No.",'<>%1',"Line No.");
                IF "Due Date" <> 0D THEN
                  Milestone.SETFILTER("Due Date",'<=%1',"Due Date");
                Milestone.SETRANGE("Completion Date",0D);
                Milestones.SETTABLEVIEW(Milestone);
                Milestones.LOOKUPMODE(TRUE);
                IF Milestones.RUNMODAL = ACTION::LookupOK THEN BEGIN
                  Milestones.GETRECORD(Milestone);
                  "Predecessor Activity" := Milestone."Activity Type Code";
                  "Predecessor Milestone No." := Milestone."Award No.";
                  "Predecessor Milestone Line No." := Milestone."Line No.";
                  InLookup := TRUE;
                  VALIDATE("Predecessor Activity");
                  InLookup := FALSE;
                END;
                Milestone.RESET;
            end;

            trigger OnValidate()
            begin
                   IF "Predecessor Activity" = '' THEN BEGIN
                     "Predecessor Milestone No." := '';
                     "Predecessor Milestone Line No." := 0
                   END ELSE BEGIN
                     IF NOT InLookup THEN
                       ERROR(SNText003);
                     IF ("Predecessor Milestone No." = '') OR ("Predecessor Milestone Line No." = 0) THEN BEGIN
                       "Predecessor Activity" := '';
                       "Predecessor Milestone No." := '';
                       "Predecessor Milestone Line No." := 0;
                     END ELSE IF ("Predecessor Milestone No." = "Award No.") AND ("Predecessor Milestone Line No." = "Line No.") THEN BEGIN
                       "Predecessor Activity" := '';
                       "Predecessor Milestone No." := '';
                       "Predecessor Milestone Line No." := 0;
                       MESSAGE(SNText002);
                     END;
                     CheckPredecessorDueDate(Rec);
                   END;
            end;
        }
        field(31;"Predecessor Milestone No.";Code[10])
        {
            Caption = 'Predecessor Milestone No.';
            Editable = false;
            TableRelation = Award;
        }
        field(32;"Predecessor Milestone Line No.";Integer)
        {
            Caption = 'Predecessor Milestone Line No.';
            Editable = false;
            TableRelation = Milestone."Line No.";
        }
        field(55;"Recurring Frequency";DateFormula)
        {
            Caption = 'Recurring Frequency';
        }
        field(50000;Status;Option)
        {
            OptionCaption = 'Open,Completed';
            OptionMembers = Open,Completed;
        }
    }

    keys
    {
        key(Key1;"Award No.","Line No.")
        {
        }
        key(Key2;"Award No.","Completion Date","Due Date")
        {
        }
        key(Key3;"Award No.","Due Date","Completion Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
       //// TESTFIELD("Completion Date",0D);

      //  IF FileAttachment.READPERMISSION THEN
        //  FileAttachment.DeleteDocuments(DATABASE::Milestone,"Award No.",FORMAT("Line No."),'');
    end;

   

    var
        Milestone: Record "170460";
        SNText001: Label 'Create the next iteration of this milestone?';
        SNText002: Label 'A milestone cannot be predecessor of itself.';
        SNText003: Label 'Use the lookup (F6) to select a predecessor milestone.';
        SNText004: Label 'The Predecessor Milestone has not been completed.';
       // ActivityType: Record "170436";
        FileAttachment: Record "170502";
        Milestones: Page "25004";
        InLookup: Boolean;
        SNText005: Label 'The predecessor milestone due date %1 is after the milestone due date %2.';
        SNText006: Label 'Create the next iteration of this milestone?  \\Award No=%1\Activity Type Code=%2';

    procedure CheckPredecessorDueDate(Milestone: Record "170460")
    var
        PredecessorMilestone: Record "170460";
    begin
        IF Milestone."Predecessor Activity" = '' THEN
          EXIT;
        PredecessorMilestone.GET(Milestone."Predecessor Milestone No.",Milestone."Predecessor Milestone Line No.");

        IF PredecessorMilestone."Due Date" > Milestone."Due Date" THEN
          ERROR(SNText005,PredecessorMilestone."Due Date",Milestone."Due Date")
    end;
}

