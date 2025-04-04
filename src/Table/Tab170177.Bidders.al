Table 170177 "Bidders"
{

    fields
    {
        field(1;No;Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if Vendor.Get(No) then begin
                  "Company Name":=Vendor.Name;
                //  "Pin No":=Vendor."Pin No.";
                end;
            end;
        }
        field(2;"Company Name";Text[100])
        {
        }
        field(3;"Pin No";Code[50])
        {
        }
        field(4;"Quoted Amount";Decimal)
        {
        }
        field(5;"Req No";Code[20])
        {
        }
        field(6;TechScore;Integer)
        {

            trigger OnValidate()
            begin
                "Total Score":=TechScore+FinScore;
            end;
        }
        field(7;FinScore;Integer)
        {

            trigger OnValidate()
            begin
                "Total Score":=TechScore+FinScore;
            end;
        }
        field(8;"Tender No";Code[200])
        {
            TableRelation = "Tender Notice"."Tender No";
        }
        field(9;Awarded;Boolean)
        {

            trigger OnValidate()
            begin
                Bidders.Reset;
                Bidders.SetRange(Awarded,true);
                Bidders.SetFilter("Company Name",'<>%1',"Company Name");
                if Bidders.FindSet then begin
                  repeat
                    Bidders.Awarded:=false;
                    Bidders.Modify;
                    until Bidders.Next=0;
                  end ;
            end;
        }
        field(10;"Tender Security";Decimal)
        {
        }
        field(11;"No of Documents";Integer)
        {
        }
        field(12;"Branch Code";Code[10])
        {
        }
        field(13;"Branch Name";Code[80])
        {
        }
        field(14;"Bank Name";Code[80])
        {
        }
        field(15;"Mandatory Requirements";Boolean)
        {
        }
        field(16;"Total Score";Integer)
        {
        }
    }

    keys
    {
        key(Key1;No,"Tender No","Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Vendor: Record Vendor;
        Bidders: Record Bidders;
        BankAccount: Record "Bank Account";
        Highestscore: Integer;
}

