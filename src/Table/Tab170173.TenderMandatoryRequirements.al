Table 170173 "Tender Mandatory Requirements"
{

    fields
    {
        field(1;"Tendor No";Code[20])
        {
        }
        field(2;"Code";Code[20])
        {

            trigger OnValidate()
            begin
                if MandatoryRequirementsSetup.Get(Code) then
                  Requirement:=MandatoryRequirementsSetup.Requirement;
            end;
        }
        field(3;Requirement;Text[250])
        {
        }
    }

    keys
    {
        key(Key1;"Tendor No","Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        MandatoryRequirementsSetup: Record "Mandatory Requirements Setup";
}

