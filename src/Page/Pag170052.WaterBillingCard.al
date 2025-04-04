Page 170052 "Water Billing Card"
{
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
                field(Unit;Rec.Unit)
                {
                    ApplicationArea = Basic;
                }
                field("Unit Name";Rec."Unit Name")
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
                field(Tenant;Rec.Tenant)
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Name";Rec."Tenant Name")
                {
                    ApplicationArea = Basic;
                }
                field("Previous Meter Reading";Rec."Previous Meter Reading")
                {
                    ApplicationArea = Basic;
                }
                field("Current Meter Reading";Rec."Current Meter Reading")
                {
                    ApplicationArea = Basic;
                }
                field("Units Consumed";Rec."Units Consumed")
                {
                    ApplicationArea = Basic;
                }
                field(Rate;Rec.Rate)
                {
                    ApplicationArea = Basic;
                }
                field("Amount Charged";Rec."Amount Charged")
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
            group(Functions)
            {
                action("Bill Water")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bill Water';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        UnitBill: Record "Unit Billing Lines";
                    begin
                        Rec.Validate("Previous Meter Reading");
                        Rec.Validate("Current Meter Reading");
                        if Confirm('Are you sure you want to post bill?',true,false)=true then begin
                        Rec.Posted:=true;
                        Rec.Modify;

                        UnitBill.Reset;
                        UnitBill.SetRange(UnitBill."Unit Code",Rec.Unit);
                        UnitBill.SetRange(UnitBill.Ammenity,'WATER');
                        if UnitBill.FindFirst then begin
                        UnitBill.Rate:=Rec."Amount Charged";
                        UnitBill.Modify;
                        end;
                        end;
                    end;
                }
            }
        }
    }
}

