table 172071 Vehicles
{
    Caption = 'Vehicles';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Registration No"; Code[70])
        {
            Caption = 'Registration No';
        }
        field(2; "Unit"; Integer)
        {
            Caption = 'Unit ';
        }
        field(3; "Make"; Text[2048])
        {
            Caption = 'Make ';
        }
        field(4; Model; Text[2048])
        {
            Caption = 'Model';
        }
        field(5; "Year"; Integer)
        {
            Caption = 'Year ';
        }
        field(6; Color; Text[100])
        {
            Caption = 'Color';
        }
        field(7; "Type of Vehicle"; Text[100])
        {
            Caption = 'Type of Vehicle';
        }
        field(8; Engine; Code[100])
        {
            Caption = 'Engine';
        }//
        field(9; "Global Dimension 1"; Code[100])
        {
            // Caption = 'Global Dimension 1';
            // CaptionClass = '1,2,1';
            // TableRelation = "Dimension Value" where("Global Dimension No." = const(1));
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                // Rec.ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(10; "Global Dimension 2"; Code[100])
        {
            // Caption = 'Global Dimension 2';
            // CaptionClass = '1,2,2';
            // TableRelation = "Dimension Value" where("Global Dimension No." = const(2));
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                // Rec.ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(11; "Plate No"; Code[100])
        {
            Caption = 'Plate No';
        }
        field(12; "Fixed Asset No"; Code[100])
        {
            Caption = ' Fixed Asset No';
            TableRelation = "Fixed Asset"."No.";
        }
        field(13; "Plate Type"; Text[100])
        {
            Caption = 'Plate Type';
        }
        field(14; "Plate Expiry"; Text[100])
        {
            Caption = 'Plate Expiry';
        }
        field(15; "Odometer 1"; Integer)
        {
            Caption = 'Odometer 1';
        }
        field(16; "Odometer 2"; Integer)
        {
            Caption = 'Odometer 2';
        }
        field(17; "Vehicle Status"; Option)
        {
            Caption = 'Vehicle Status';
            OptionMembers = Active,"In-Active";
        }
        field(18; "Usage Status"; Option)
        {
            Caption = 'Usage Status';
            OptionMembers = " ","In Use",Free,"Under Maintanance",Reserved;
        }
        field(19; "Log Book No"; Code[100])
        {
            Caption = 'Log Book No';
        }
        field(20; "Body"; Code[100])
        {
            Caption = 'Body ';
        }
        field(21; Fuel; Text[100])
        {
            Caption = 'Fuel';
        }
        field(22; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }
        field(23; Passagers; Integer)
        {
            Caption = 'Passagers';
        }
        field(24; "Tare Weight"; Integer)
        {
            Caption = 'Tare Weight';
        }
        field(25; "Tax Class"; Text[100])
        {
            Caption = 'Tax Class';
        }
        field(26; Axels; Code[100])
        {
            Caption = 'Axels';
        }
        field(27; Pin; Code[100])
        {
            Caption = 'Pin';
        }
        field(28; Name; Text[2048])
        {
            Caption = 'Name';
        }
        field(29; "P.o Box  No"; Code[2048])
        {
            Caption = 'P.o Box  No';
        }
        field(30; "Postal Code"; Code[2048])
        {
            Caption = 'Postal Code';
        }
        field(31; Town; Text[500])
        {
            Caption = 'Town';
        }
        field(32; "Chasis/Frame"; Code[500])
        {
            Caption = 'Chasis/Frame';
        }
        field(33; "Allocation Status"; Option)
        {
            Caption = 'Allocation Status';
            OptionMembers = Available,"In-Use","Under Maintanance";
        }
    }
    keys
    {
        key(PK; "Registration No")
        {
            Clustered = true;
        }
    }
}
