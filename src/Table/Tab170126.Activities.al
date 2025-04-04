table 170126 Activities
{
    Caption = 'Activities';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Activity Code"; Code[50])
        {
            Caption = 'Activity Code';
        }
        field(2; "Activity Description"; Text[2048])
        {
            Caption = 'Activity Description';
        }
        field(3; "Workplan Code"; Code[50])
        {
            Caption = 'Workplan Code';
        }
    }
    keys
    {
        key(PK; "Activity Code", "Workplan Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Activity Code", "Workplan Code", "Activity Description")
        {

        }
        fieldgroup(Brick; "Workplan Code", "Activity Code", "Activity Description")
        {

        }
    }
}
