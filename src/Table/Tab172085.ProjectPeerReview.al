Table 172085 "Project Peer Review"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(2; "Peer Review"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"1. How do the project activities link to the Institutional Theory of Change? ","2. Comment on the variance between activities in the work plan and activities in the quarter","3. What impact has the project made in line with the following institutional Strategic Objectives?","Objective 1: Generate policy-relevant research and other types of evidence","Objective 2: Strengthen technical and institutional capacities needed to enable sustained use of evidence","Objective 3: Deepen engagement with African governments and expand strategic partnerships","Objective 4:  Internal systems and structures strengthened  Optimise our internal capacity","4. General recommendations:";
            OptionCaption = ',1. How do the project activities link to the Institutional Theory of Change?,2. Comment on the variance between activities in the work plan and activities in the quarter,3. What impact has the project made in line with the following institutional Strategic Objectives?,Objective 1: Generate policy-relevant research and other types of evidence and support African governments and other development actors to apply evidence in decision-making,Objective 2: Strengthen technical and institutional capacities needed to enable sustained use of evidence in decision-making.,Objective 3: Deepen engagement with African governments/ and expand strategic partnerships and networks to enhance evidence use and impact.,Objective 4:  Internal systems and structures strengthened  Optimise our internal capacity by establishing robust financial and operations management systems/ strengthening talent management/ strengthening project management and delivery/ deepening policy engagement and communications capabilities/ and harnessing technology to optimise internal processes and decision-making,4. General recommendations:';
        }
        field(3; Q1; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Q2; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Q3; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Q4; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Project Code", "Peer Review")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Locations: Record Locations;
}

