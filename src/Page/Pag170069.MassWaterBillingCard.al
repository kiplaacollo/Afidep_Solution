Page 170069 "Mass Water Billing Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Water Billing";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Billing Date";Rec."Billing Date")
                {
                    ApplicationArea = Basic;
                }
                field(Property;Rec.Property)
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";Rec."Property Name")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control7;"Mass Water Billing Lines")
            {
                SubPageLink = "Document No"=field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ActionGroup9)
            {
                action("Generate Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Lines';
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Generate Billing Lines?',true,false)=true then begin
                        if MassBillingLines.FindLast then
                        LineNo:=MassBillingLines.No
                        else
                        LineNo:=0;

                        PropertyLines.Reset;
                        PropertyLines.SetRange(PropertyLines."Property Code",Rec.Property);
                        PropertyLines.SetRange(PropertyLines.Ammenity,'WATER');
                        if PropertyLines.FindFirst then begin
                        WaterRate:=PropertyLines.Rate;
                        end else begin
                        Error('Kindly fill in water rate on property %1',Rec."Property Name");
                        end;

                        Units.Reset;
                        Units.SetRange(Units.Property22,Rec.Property);
                        Units.SetRange(Units."Unit Status3",Units."unit status3"::Occupied);
                        if Units.FindSet then begin
                        repeat
                        LineNo:=LineNo+1;
                        PreviousReading:=0;
                        ReadingHistory.Reset;
                        ReadingHistory.SetRange(ReadingHistory.Unit,Units."No.");
                        if ReadingHistory.FindLast then begin
                        PreviousReading:=ReadingHistory."Meter Reading";
                        end;
                        MassBillingLines.Init;
                        MassBillingLines."Document No":=Rec."No.";
                        MassBillingLines.No:=LineNo;
                        MassBillingLines."Account No":=Units."Account No2.";
                        MassBillingLines.Unit:=Units."No.";
                        MassBillingLines."Unit Name":=Units.Name;
                        MassBillingLines.Tenant33:=Units.Tenant22;
                        MassBillingLines.Rate:=WaterRate;
                        MassBillingLines."Tenant Name":=Units."Tenant Full Name 33";
                        MassBillingLines.Validate(Tenant33);
                        MassBillingLines.Property:=Rec.Property;
                        MassBillingLines."Previous Meter Reading":=PreviousReading;
                        MassBillingLines."Property Name":=Units."Property Name22";
                        MassBillingLines."Previous Meter Reading":=PreviousReading;
                        MassBillingLines.Insert
                        until Units.Next=0;
                        end;
                        end;
                    end;
                }
                action("Bill Period")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bill Period';
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LineNos: Integer;
                        PayPeriods: Record "Billing and Payments Periods";
                    begin
                        if Confirm('Are you sure you want to Bill Property?',true,false)=true then begin
                        //Bill Water
                        PurchaseSetup.Get();
                        JTemplate:=PurchaseSetup."Unit Receipt Template";
                        JBatch:=PurchaseSetup."Unit Receipting Batch";
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",JTemplate);
                        GenJournalLine.SetRange("Journal Batch Name",JBatch);
                        if GenJournalLine.FindSet then begin
                        GenJournalLine.DeleteAll;
                        end;
                        PropertyDet.Reset;
                        PropertyDet.SetRange(PropertyDet.No,Rec.Property);
                        if PropertyDet.FindFirst then begin
                        LandlordNo:=PropertyDet."Property Owner";
                        end;
                        PayPeriods.Reset;
                        PayPeriods.SetRange(PayPeriods.Closed,false);
                        if PayPeriods.FindLast then begin
                        LineNos:=1000;
                        MassBillingLines.Reset;
                        MassBillingLines.SetRange(MassBillingLines."Document No",Rec."No.");
                        if MassBillingLines.FindFirst then begin
                        repeat
                        LineNos:=LineNos+10000;
                        AUFactory.FnInsertJournalLines(JTemplate,JBatch,Rec."No.",MassBillingLines.Tenant33,Accounttype::Vendor,LandlordNo,MassBillingLines."Account No",Today
                        ,MassBillingLines."Account No"+' '+MassBillingLines."Tenant Name",'','',-MassBillingLines."Amount Charged",LineNos,Accounttype::"G/L Account",PurchaseSetup."Payments Control Account",PayPeriods."Starting Date",'WATER',Rec.Property);

                        LineNos:=LineNos+100000;
                        AUFactory.FnInsertJournalLines(JTemplate,JBatch,Rec."No.",MassBillingLines.Tenant33,Accounttype::Customer,MassBillingLines.Unit,MassBillingLines."Account No",
                        Today,MassBillingLines."Account No"+' '+MassBillingLines."Tenant Name",'','',MassBillingLines."Amount Charged",LineNos,Accounttype::"G/L Account",PurchaseSetup."Payments Control Account",PayPeriods."Starting Date",'WATER',Rec.Property);
                        until MassBillingLines.Next=0;
                        end;
                        end;
                        //End Water Billing

                        ReadingHistory.Reset;
                        ReadingHistory.SetCurrentkey(No);
                        if ReadingHistory.FindLast then
                        LineNo:=ReadingHistory.No+1
                        else
                        LineNo:=1;
                        MassBillingLines.Reset;
                        MassBillingLines.SetRange(MassBillingLines."Document No",Rec."No.");
                        if MassBillingLines.FindFirst then begin
                        repeat
                        LineNo:=LineNo+1;
                        //MESSAGE('LineNo%1',LineNo);
                        ReadingHistory.Init;
                        ReadingHistory.No:=LineNo;
                        ReadingHistory.Unit:=MassBillingLines.Unit;
                        ReadingHistory.Date:=Rec."Billing Date";
                        ReadingHistory."Billing Period":=Rec."Billing Period";
                        ReadingHistory.Property:=Rec.Property;
                        ReadingHistory.Tenant:=MassBillingLines.Tenant33;
                        ReadingHistory."Meter Reading":=MassBillingLines."Current Meter Reading";
                        ReadingHistory."Billing Type":=ReadingHistory."billing type"::Mass;
                        ReadingHistory."Billing Document":=Rec."No.";
                        ReadingHistory."Amount Billed":=MassBillingLines."Amount Charged";
                        ReadingHistory.Insert(true);

                        UnitLines.Reset;
                        UnitLines.SetRange(UnitLines.Ammenity,'WATER');
                        UnitLines.SetRange(UnitLines."Unit Code",MassBillingLines.Unit);
                        if UnitLines.FindFirst then begin
                        UnitLines.Rate:=MassBillingLines."Amount Charged";
                        UnitLines.Modify;
                        end else begin
                        if UnitLines.FindLast then
                        LineNos:=UnitLines.EntryNo+1
                        else
                        LineNos:=1;
                        UnitLines.Init;
                        UnitLines.EntryNo:=LineNo;
                        UnitLines.Ammenity:='WATER';
                        UnitLines.Validate(Ammenity);
                        UnitLines.Rate:=MassBillingLines."Amount Charged";
                        UnitLines."Unit Code":=MassBillingLines.Unit;
                        UnitLines.Insert(true);
                        end;
                        until MassBillingLines.Next=0;
                        end;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",JTemplate);
                        GenJournalLine.SetRange("Journal Batch Name",JBatch);
                        if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJournalLine);
                        end;
                        Rec.Posted:=true;
                        Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    var
        Units: Record Customer;
        UnitLines: Record "Unit Billing Lines";
        MassBillingLines: Record "Mass Water Billing Lines";
        LineNo: Integer;
        ReadingHistory: Record "Meter Reading History";
        PreviousReading: Decimal;
        PropertyLines: Record "Property Billing Lines";
        WaterRate: Decimal;
        LineNos: Integer;
        Receipt: Record "Mass Unit Billing";
        AUFactory: Codeunit "AU factory";
        PurchaseSetup: Record "Purchases & Payables Setup";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JTemplate: Code[20];
        JBatch: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        ApprovalEntry: Record "Approval Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        PurchasesSetup: Record "Purchases & Payables Setup";
        PropertyDet: Record "Property Details";
        LandlordNo: Code[20];
        WaterBill: Record "Water Billing";
}

