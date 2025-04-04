Page 170073 "Mass Update Card"
{
    PageType = Card;
    SourceTable = "Units Mass Update";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No;Rec.No)
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
                field(Ammenity;Rec.Ammenity)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Date;Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Updated;Rec.Updated)
                {
                    ApplicationArea = Basic;
                }
                field("Updated By";Rec."Updated By")
                {
                    ApplicationArea = Basic;
                }
                field("Updated Date";Rec."Updated Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Amount")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EntryNo: Integer;
                begin
                    if Confirm('Are you sure you want to update this property',true,false)=true then begin

                    UnitBilss.Reset;
                    UnitBilss.SetRange(UnitBilss.Property,Rec.Property);
                    UnitBilss.SetFilter(UnitBilss.Ammenity,Rec.Ammenity);
                    UnitBilss.SetAutocalcFields(UnitBilss.Property);
                    if UnitBilss.FindSet then begin
                    UnitBilss.DeleteAll;
                    end;


                    if UnitBils.FindLast then
                    EntryNo:=UnitBils.EntryNo+1
                    else
                    EntryNo:=1;
                    Units.Reset;
                    Units.SetRange(Units.Property22,Rec.Property);
                    if Units.FindFirst then begin
                    repeat
                    UnitBils.Init;
                    UnitBils.EntryNo:=EntryNo;
                    UnitBils.Ammenity:=Rec.Ammenity;
                    UnitBils.Description:=Rec.Ammenity;
                    UnitBils.Rate:=Rec.Amount;
                    UnitBils."Unit Code":=Units."No.";
                    UnitBils.Insert;
                    EntryNo:=EntryNo+1;
                    until Units.Next=0;
                    end;
                    Rec.Updated:=true;
                    Rec."Updated By":=UserId;
                    Rec."Updated Date":=Today;
                    Rec.Modify;
                    end;
                end;
            }
        }
    }

    var
        BillLines: Record "Property Billing Lines";
        Units: Record Customer;
        UnitBils: Record "Unit Billing Lines";
        UnitBilss: Record "Unit Billing Lines";
}

