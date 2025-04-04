tableextension 50122 AccSchedulelineExt extends "Acc. Schedule Line"
{
    fields
    {
        field(1105; "Fund Filter"; Code[100])
        {
            Caption = 'Fund Filter';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = filter(false));
        }
        field(1106; "Donor Filter"; Code[100])
        {
            Caption = 'Donor Filter';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3), Blocked = filter(false));
        }
        field(1107; "budget Filter"; Code[100])
        {
            Caption = 'Project Filter';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = filter(false));
        }
        field(1108; "Program Filter"; Code[100])
        {
            Caption = 'Program Filter';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4), Blocked = filter(false));
        }
    }

    var
        myInt: Integer;
}