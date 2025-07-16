Table 172084 "Project Impact"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(2; "Project Goal/Impact"; Text[1000])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects."Goal Summary";
        }
        field(3; "Project Objectives/ Outcomes"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Monthly Reports:","Quarterly Report:","Funder's Report:";
        }
        field(4; "Project Learning Questions"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"1. To what extent are individual/institutional capacities been strengthened due to the project?","2.  What kind of technical assistance lead to effective policy and programme formulation and implementation?","3. Which capacity development initiatives are most effective and for whom?","4. What factors contribute to evidence being used in decision-making?","5. How has the evidence been used to support decision-making?","6. How effective has the project been in creating a community of practice?","7. To what extent is the project efficient in research generation and evidence translation?","8. What kind/mix of products and processes of dissemination lead to uptake by decision makers including policymakers?","9. How is the project unique in how it approaches its work?";
            OptionCaption = ',1. To what extent are individual/institutional capacities been strengthened due to the project?,2.  What kind of technical assistance lead to effective policy and programme formulation and implementation?,3. Which capacity development initiatives are most effective and for whom?,4. What factors contribute to evidence being used in decision-making?,5. How has the evidence been used to support decision-making?,6. How effective has the project been in creating a community of practice?,7. To what extent is the project efficient in research generation and evidence translation?,8. What kind/mix of products and processes of dissemination lead to uptake by decision makers including policymakers?,9. How is the project unique in how it approaches its work?';
        }
    }

    keys
    {
        key(Key1; "Project Code", "Project Objectives/ Outcomes")
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

