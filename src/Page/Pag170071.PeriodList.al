Page 170071 "Period List"
{
    PageType = List;
    SourceTable = "Billing and Payments Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date";Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Closed;Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Date Locked";Rec."Date Locked")
                {
                    ApplicationArea = Basic;
                }
                field(Year;Rec.Year)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Close Period")
            {
                Caption = 'Close Period';
                action(Action9)
                {
                    ApplicationArea = Basic;
                    Caption = 'Close Period';
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to close period?',true,false)=true then begin
                        FiscalYearStartDate:=Rec."Starting Date";
                        Rec.Closed:=true;
                        Rec."Date Locked":=true;
                        Rec.Year:=Date2dmy(Rec."Starting Date",3);
                        Rec.Modify;

                        AccountingPeriod.Init;
                        AccountingPeriod."Starting Date":=CalcDate('<1M>',Rec."Starting Date");
                        AccountingPeriod.Validate("Starting Date");
                        AccountingPeriod.Closed:=false;
                        AccountingPeriod.Year:=Date2dmy(AccountingPeriod."Starting Date",3);
                        AccountingPeriod.Insert;
                        end;
                    end;
                }
            }
        }
    }

    var
        AccountingPeriod: Record "Billing and Payments Periods";
        NoOfPeriods: Integer;
        PeriodLength: DateFormula;
        FiscalYearStartDate: Date;
        FirstPeriodStartDate: Date;
        LastPeriodStartDate: Date;
        FirstPeriodLocked: Boolean;
        i: Integer;
        PeriodType: Option " ",Daily,Weekly,"Bi-Weekly",Monthly;
        Text000: label 'The new fiscal year begins before an existing fiscal year, so the new year will be closed automatically.\\';
        Text001: label 'Do you want to create and close the fiscal year?';
        Text002: label 'Once you create the new fiscal year you cannot change its starting date.\\';
        Text003: label 'Do you want to create the fiscal year?';
        Text004: label 'It is only possible to create new fiscal years before or after the existing ones.';
}

