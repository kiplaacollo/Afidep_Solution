Page 170081 "HR Medical Scheme Members Card"
{
    PageType = Card;
    SourceTable = "HR Medical Scheme Members";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Scheme No"; Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1"; Rec."Global Dimension 1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Scheme Join Date"; Rec."Scheme Join Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Scheme Category"; Rec."Scheme Category")
                {
                    ApplicationArea = Basic;
                }
                field("Scheme Anniversary"; Rec."Scheme Anniversary")
                {
                    ApplicationArea = Basic;
                }
                field("Period Code"; Rec."Period Code")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Medical)
            {
                group("Out-Patient")
                {
                    field("Optical Limit"; Rec."Optical Limit")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Optical Spent"; Rec."Optical Spent")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Optical Balance"; Rec."Optical Limit" - Rec."Optical Spent")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Dental Limit"; Rec."Dental Limit")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Dental Spent"; Rec."Dental Spent")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Dental Balance"; Rec."Dental Limit" - Rec."Dental Spent")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Balance Out-Patient"; Rec."Balance Out-Patient")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;
                    }
                }
                group("In-Patient")
                {
                    field("Maternity Limit"; Rec."Maternity Limit")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Maternity Spent"; Rec."Maternity Spent")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Maternity Balance"; Rec."Maternity Limit" - Rec."Maternity Spent")
                    {
                        ApplicationArea = Basic;
                    }
                    field("In-patient Limit"; Rec."In-patient Limit")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Cumm.Amount Spent In"; Rec."Cumm.Amount Spent In")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Balance In-Patient"; Rec."Balance In-Patient")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;
                    }
                    field("Last Expense"; Rec."Last Expense")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Maximum Cover"; Rec."Maximum Cover")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                }
            }
            group(Control12)
            {
                part(Control7; "HR Medical Scheme Member Claim")
                {
                    Caption = 'Medical Scheme Member Claims';
                    SubPageLink = "Member No" = field("Employee No"),
                                  Claimed = filter(true);
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Medical Claims")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Claims';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Category4;
                }
                action("Scheme Dependants")
                {
                    ApplicationArea = Basic;
                    Caption = 'Scheme Dependants';
                    Image = Suggest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    RunObject = Page "Hr Scheme Dependants";
                    RunPageLink = "Scheme No" = field("Employee No");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //         Medscheme.RESET;
        //         Medscheme.SETRANGE(Medscheme."Scheme No","Scheme No");
        //          IF Medscheme.FIND('-') THEN BEGIN
        //         "Out-Patient Limit":=Medscheme."Out-patient limit";Rec.
        //         "In-patient Limit":=Medscheme."In-patient limit";Rec.
        //         "Balance In-Patient":="In-patient Limit"-"Cumm.Amount Spent In";Rec.
        //         "Balance Out-Patient":="Out-Patient Limit"-"Cumm.Amount Spent Out";Rec.
        //          END;
    end;

    trigger OnInit()
    begin
        //
        //         Medscheme.RESET;
        //         Medscheme.SETRANGE(Medscheme."Scheme No","Scheme No");
        //          IF Medscheme.FIND('-') THEN BEGIN
        //         "Out-Patient Limit":=Medscheme."Out-patient limit";Rec.
        //         "In-patient Limit":=Medscheme."In-patient limit";Rec.
        //         "Balance In-Patient":="In-patient Limit"-"Cumm.Amount Spent In";Rec.
        //         "Balance Out-Patient":="Out-Patient Limit"-"Cumm.Amount Spent Out";Rec.
        //          END;
    end;

    trigger OnOpenPage()
    begin
        //         Medscheme.RESET;
        //         Medscheme.SETRANGE(Medscheme."Scheme No","Scheme No");
        //          IF Medscheme.FIND('-') THEN BEGIN
        //         "Out-Patient Limit":=Medscheme."Out-patient limit";Rec.
        //         "In-patient Limit":=Medscheme."In-patient limit";Rec.
        //         "Balance In-Patient":="In-patient Limit"-"Cumm.Amount Spent In";Rec.
        //         "Balance Out-Patient":="Out-Patient Limit"-"Cumm.Amount Spent Out";Rec.
        //          END;
    end;

    var
        objSchMembers: Record "HR Medical Scheme Members";
        objScmDetails: Record "HR Medical Schemes";
        decInPatientBal: Decimal;
        Medscheme: Record "HR Medical Schemes";
}

