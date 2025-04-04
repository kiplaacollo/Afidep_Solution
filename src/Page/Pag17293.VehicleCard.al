page 17293 "Vehicle Card"
{
    Caption = 'Vehicle Card';
    PageType = Card;
    SourceTable = Vehicles;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Registration No"; Rec."Registration No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registration No field.';
                }
                field("Chasis/Frame"; Rec."Chasis/Frame")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Chasis/Frame field.';
                }

                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Make  field.';
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year  field.';
                }
                field(Body; Rec.Body)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Body  field.';
                }

                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Color field.';
                }
                field("Allocation Status"; Rec."Allocation Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allocation Status field.';
                }
                field("Type of Vehicle"; Rec."Type of Vehicle")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type of Vehicle field.';
                }
                field(Engine; Rec.Engine)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Engine field.';
                }
                field("Global Dimension 1"; Rec."Global Dimension 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 field.';
                }
                field("Global Dimension 2"; Rec."Global Dimension 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 field.';
                }
                field(Fuel; Rec.Fuel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fuel field.';
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registration Date field.';
                }
                field(Axels; Rec.Axels)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Axels field.';
                }


                field("Fixed Asset No"; Rec."Fixed Asset No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  Fixed Asset No field.';
                }


                field("Log Book No"; Rec."Log Book No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Log Book No field.';
                }



                field(Passagers; Rec.Passagers)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Passagers field.';
                }


                field("Tare Weight"; Rec."Tare Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tare Weight field.';
                }
                field("Tax Class"; Rec."Tax Class")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Class field.';
                }




            }
            group("Registered Owners")
            {
                field(Pin; Rec.Pin)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pin field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("P.o Box  No"; Rec."P.o Box  No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P.o Box  No field.';
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Postal Code field.';
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Town field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Release Vehicle';

                trigger OnAction()
                begin

                    Rec."Allocation Status" := Rec."Allocation Status"::Available;
                    Rec.MODIFY;

                    MESSAGE('Vehicle Has been Released ');
                end;
            }
            action(M)
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Send Vehicle for Maintanance';

                trigger OnAction()
                begin

                    Rec."Allocation Status" := Rec."Allocation Status"::"Under Maintanance";
                    Rec.MODIFY;

                    MESSAGE('Vehicle is now under maintainance');
                end;
            }
        }
    }
    var
        vehicles: Record Vehicles;
}
