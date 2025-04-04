Table 50011 "Key Performance Indicators"
{

    fields
    {
        field(1;No;Integer)
        {
            Editable = false;
        }
        field(2;"Key Value Drivers";Code[40])
        {
            TableRelation = "Key Value Drivers"."Key Value Driver";
        }
        field(3;Indicator;Text[120])
        {
        }
        field(4;Activity;Text[150])
        {
        }
        field(5;Weight;Decimal)
        {
        }
        field(6;Period;Code[140])
        {
        }
        field(7;"Completion Date";Date)
        {
        }
        field(8;Frequency;Option)
        {
            OptionCaption = 'Quarterly,Annually,Monthly,Half yearly,Semi Annually,Bi-annual,Weekly';
            OptionMembers = Quarterly,Annually,Monthly,"Half yearly","Semi Annually","Bi-annual",Weekly;
        }
    }

    keys
    {
        key(Key1;No,"Key Value Drivers",Indicator)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(G1;No,"Key Value Drivers",Indicator)
        {
        }
    }

    trigger OnInsert()
    begin
        if KeyPerformanceIndicators.FindLast then
        No:=KeyPerformanceIndicators.No+1
        else
        No:=1;
    end;

    var
        KeyPerformanceIndicators: Record "Key Performance Indicators";
}

