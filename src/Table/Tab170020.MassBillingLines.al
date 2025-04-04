Table 170020 "Mass Billing Lines"
{

    fields
    {
        field(1;EntryNo;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;Ammenity;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit Transaction Types"."Transaction Code";

            trigger OnValidate()
            var
                Trans: Record "Unit Transaction Types";
            begin
                Trans.Reset;
                Trans.SetRange(Trans."Transaction Code",Ammenity);
                if Trans.FindFirst then begin
                Description:=Trans."Transaction Description";
                end;
            end;
        }
        field(3;Description;Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Rate;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Unit Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Document No";Code[40])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;EntryNo,"Unit Code")
        {
            Clustered = true;
        }
      
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Billinglines: Record "Unit Billing Lines";
    begin
        if Billinglines.FindLast then
        EntryNo:=Billinglines.EntryNo+1
        else
        EntryNo:=1;
    end;
}

