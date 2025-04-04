Page 50045 "Procurement Plan"
{
    PageType = List;
    SourceTable = "Procurement Plan";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Project Code";Rec."Project Code")
                {
                    ApplicationArea = Basic;
                }
                field("Activity Title";Rec."Activity Title")
                {
                    ApplicationArea = Basic;
                }
                field("Beneficiary Name";Rec."Beneficiary Name")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Line";Rec."Budget Line")
                {
                    ApplicationArea = Basic;
                }
                field(Unit;Rec.Unit)
                {
                    ApplicationArea = Basic;
                }
                field("No of Units";Rec."No of Units")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Cost";Rec."Unit Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Total Budget";Rec."Total Budget")
                {
                    ApplicationArea = Basic;
                }
                field("Donor Name";Rec."Donor Name")
                {
                    ApplicationArea = Basic;
                }
                field(Sector;Rec.Sector)
                {
                    ApplicationArea = Basic;
                }
                field("Expected Start Date";Rec."Expected Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected End Date";Rec."Expected End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Location;Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field("Type of Procurement";Rec."Type of Procurement")
                {
                    ApplicationArea = Basic;
                }
                field(Scenario;Rec.Scenario)
                {
                    ApplicationArea = Basic;
                }
                field("Project Focal Person";Rec."Project Focal Person")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Procurement Plan")
            {
                ApplicationArea = Basic;
                Image = Agreement;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
              //  RunObject = Report UnknownReport50002;
            }
            action("Upload ")
            {
                ApplicationArea = Basic;
                Image = Agreement;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Xmlport.Run(50001,false);
                end;
            }
        }
    }
}

