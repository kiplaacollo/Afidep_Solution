Page 80103 "Withholding Tax Setups"
{
    Caption = 'Withholding Tax Setups';
    PageType = List;
    SourceTable = "Withholding Tax Setup";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code you want to assign to this tax jurisdiction. You can enter up to 10 characters, both numbers and letters. It is a good idea to enter a code that is easy to remember.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of the tax jurisdiction. For example, if the tax jurisdiction code is ATLANTA GA, enter the description as Atlanta, Georgia.';
                }
                field("Rate %"; Rec."Rate %")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withholding Tax Rate';
                }
                field("Consultancy Rate"; Rec."Consultancy Rate") { ApplicationArea = all; }
                field("Withholding Tax Account"; Rec."Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("Consultancy Fee AC"; Rec."Consultancy Fee AC")
                {
                    ApplicationArea = all;
                    Caption = 'Consultancy Rate A\C';
                }
                field("Country code"; Rec."Country code")
                {
                    ApplicationArea = Basic;
                }
                field("Country Name"; Rec."Country Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Jurisdiction")
            {
                Caption = '&Jurisdiction';
                Image = ViewDetails;
                action("Ledger &Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger &Entries';
                    Image = CustomerLedger;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "VAT Entries";
                    RunPageLink = "Tax Jurisdiction Code" = field(Code);
                    RunPageView = sorting("Tax Jurisdiction Code");
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View Tax entries, which result from posting transactions in journals and sales and purchase documents, and from the Calc. and Post Tax Settlement batch job.';
                }
                action(Details)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Details';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Tax Details";
                    RunPageLink = "Tax Jurisdiction Code" = field(Code);
                    ToolTip = 'View tax-detail entries. A tax-detail entry includes all of the information that is used to calculate the amount of tax to be charged.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        DefaultTax := GetDefaultTax;
    end;

    trigger OnAfterGetRecord()
    begin
        DefaultTax := GetDefaultTax;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TaxSetup: Record "Tax Setup";
    begin
        TaxSetup.Get;
        DefaultTax := 0;
        DefaultTaxIsEnabled := TaxSetup."Auto. Create Tax Details";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created by" := UserId;
        Rec."Date Created" := CurrentDatetime;
    end;

    var
        DefaultTax: Decimal;
        DefaultTaxIsEnabled: Boolean;

    local procedure GetDefaultTax(): Decimal
    var
        TaxDetail: Record "Tax Detail";
    begin
        GetDefaultTaxDetail(TaxDetail);
        exit(TaxDetail."Tax Below Maximum");
    end;

    local procedure SetDefaultTax(NewTaxBelowMaximum: Decimal)
    var
        TaxDetail: Record "Tax Detail";
    begin
        GetDefaultTaxDetail(TaxDetail);
        TaxDetail."Tax Below Maximum" := NewTaxBelowMaximum;
        TaxDetail.Modify;
    end;

    local procedure GetDefaultTaxDetail(var TaxDetail: Record "Tax Detail")
    begin
        TaxDetail.SetRange("Tax Jurisdiction Code", Rec.Code);
        TaxDetail.SetRange("Tax Group Code", '');
        //TaxDetail.SetRange("Tax Type",TaxDetail."tax type"::"Sales Tax");
        if TaxDetail.FindLast then begin
            DefaultTaxIsEnabled := true;
            TaxDetail.SetRange("Effective Date", TaxDetail."Effective Date");
            TaxDetail.FindLast;
        end else begin
            DefaultTaxIsEnabled := false;
            TaxDetail.SetRange("Effective Date");
        end;
    end;
}

