Table 50117 "AppraisalNeeds"
{

    fields
    {
        field(1;EntryNo;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;Appraisaltype;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Technical Capacity,Organisation and planning skills,Efficiency and Effectiveness,Communication,Leadership';
            OptionMembers = "Technical Capacity","Organisation and planning skills","Efficiency and Effectiveness",Communication,Leadership;
        }
        field(3;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Line Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'AppraisalScore,ActionPoints,CapacityNeeds,PersonalQualities,Rellections';
            OptionMembers = AppraisalScore,ActionPoints,CapacityNeeds,PersonalQualities,Rellections;
        }
    }

    keys
    {
        key(Key1;EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

