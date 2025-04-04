table 170122 "Award Countries"
{

    fields
    {
        field(1;"Award No";Code[100])
        {
            TableRelation = Award;
        }
        field(2;"Country Code";Code[100])
        {
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                IF CountryRegion.GET("Country Code") THEN
                  "Country Name":=CountryRegion.Name;
            end;
        }
        field(3;"Country Name";Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Award No","Country Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CountryRegion: Record "9";
}

