table 172774 Contracts
{

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'Serial No';
            DataClassification = ToBeClassified;
        }
        field(2; "Record Type"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Internal Contract Owner"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Contract type"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Initiated,Pending,Closed,Expired,Active';
            OptionMembers = " ",Initiated,Pending,Closed,Expired,Active;
        }
        field(6; "Renewal type"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Notify period"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Months,Weeks,Days';
            OptionMembers = ,Months,Weeks,Days;
        }
        field(8; Notify; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Contract Title"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Contract Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Commencement date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Contract Term" = "Contract Term"::Days THEN BEGIN
                    "Expiry Date" := CALCDATE(FORMAT("Contract Term Value") + 'D', "Commencement date");
                END
                ELSE
                    IF "Contract Term" = "Contract Term"::Weeks THEN BEGIN
                        "Expiry Date" := CALCDATE(FORMAT("Contract Term Value") + 'W', "Commencement date");
                    END
                    ELSE
                        IF "Contract Term" = "Contract Term"::Months THEN BEGIN
                            "Expiry Date" := CALCDATE(FORMAT("Contract Term Value") + 'M', "Commencement date");
                        END
                        /*ELSE IF "Contract Term"="Contract Term"::Quarters THEN
                          BEGIN
                            "Expiry Date":=CALCDATE(FORMAT("Contract Term Value") + 'Q',"Commencement date");
                          END*/
                        ELSE
                            IF "Contract Term" = "Contract Term"::Years THEN BEGIN
                                "Expiry Date" := CALCDATE(FORMAT("Contract Term Value") + 'Y''-1D', "Commencement date");
                            END;

            end;
        }
        field(12; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*MESSAGE('This contract has expired');
                "Expiry Date":=TODAY;
                Status:=Status::Expired;
                */

            end;
        }
        field(13; Comments; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Company Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Postal Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Town; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Tel No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Email; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Serial No."; Code[50])
        {
        }
        field(21; Parties; Text[150])
        {
        }
        field(22; "Contract Ref No"; Code[20])
        {
        }
        field(23; "Contract/Tender Category"; Code[100])
        {
            TableRelation = "Tender Category";
        }
        field(24; "Procurement Method"; Code[100])
        {
            TableRelation = "Procurement Methods";
        }
        field(25; "Contract Amount"; Decimal)
        {
        }
        field(26; "Evaluation Completion Date"; Date)
        {
        }
        field(27; "Tender Award Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Tender Award Date" < "Evaluation Completion Date" THEN BEGIN
                    ERROR('Tender Award Date cannot be before Evaluation Completion Date');
                END;
            end;
        }
        field(28; "Date Of Notification Of Award"; Date)
        {

            trigger OnValidate()
            begin
                IF "Date Of Notification Of Award" < "Tender Award Date" THEN BEGIN
                    ERROR('Date Of Notification Of Award cannot be before Tender Award Date');
                END;
            end;
        }
        field(29; "Contract Signing Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Contract Signing Date" < "Date Of Notification Of Award" THEN BEGIN
                    ERROR('Contract Signing Date cannot be before Date Of Notification Of Award');
                END;
            end;
        }
        field(30; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF Vendor.GET("Vendor No.") THEN BEGIN
                    // "Business Registration No." := Vendor."Registration No";
                    Email := Vendor."E-Mail";
                    "Tel No." := Vendor."Phone No.";
                    "Physical Address" := Vendor.Address;
                    "Postal Address" := Vendor."Address 2";
                END;
            end;
        }
        field(31; "Vendor Name"; Text[100])
        {
        }
        field(32; "Pin No"; Code[50])
        {
        }
        field(33; "Business Registration No."; Code[50])
        {
        }
        field(34; "Business Type"; Option)
        {
            OptionCaption = ',Public,Private,Sole Proprietorship,Limited Liability Patnership,Societies';
            OptionMembers = ,Public,Private,"Sole Proprietorship","Limited Liability Patnership",Societies;
        }
        field(35; "Physical Address"; Text[200])
        {
        }
        field(36; "Tender Ref No"; Code[30])
        {
        }
        field(37; "Tender No"; Code[20])
        {
            TableRelation = "Tender Notice"."Tender No";

        }
        field(38; "Procurement Type Code"; Code[20])
        {
            TableRelation = "Procurement Methods";
        }
        field(39; Term; Code[10])
        {
        }
        field(40; "Sent to Legal"; Boolean)
        {
        }
        field(41; "Award acceptance"; Boolean)
        {
        }
        field(42; "Contract Term"; Option)
        {
            OptionCaption = ' ,Days,Weeks,Months,Years';
            OptionMembers = " ",Days,Weeks,Months,Years;
        }
        field(43; "Contract Term Value"; Integer)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Commencement date");
                TESTFIELD("Contract Term Value");
                TESTFIELD("Contract Term");
                IF "Contract Term" = "Contract Term"::Days THEN BEGIN
                    "Expiry Date" := CALCDATE(FORMAT("Contract Term Value") + 'D', "Commencement date");
                END
                ELSE
                    IF "Contract Term" = "Contract Term"::Weeks THEN BEGIN
                        "Expiry Date" := CALCDATE(FORMAT("Contract Term Value") + 'W', "Commencement date");
                    END
                    ELSE
                        IF "Contract Term" = "Contract Term"::Months THEN BEGIN
                            "Expiry Date" := CALCDATE(FORMAT("Contract Term Value") + 'M', "Commencement date");
                        END
                        /*ELSE IF "Contract Term"="Contract Term"::Quarters THEN
                          BEGIN
                            "Expiry Date":=CALCDATE(FORMAT("Contract Term Value") + 'Q',"Commencement date");
                          END*/
                        ELSE
                            IF "Contract Term" = "Contract Term"::Years THEN BEGIN
                                "Expiry Date" := CALCDATE(FORMAT("Contract Term Value") + 'Y''-1D', "Commencement date");
                            END;

            end;
        }
    }

    keys
    {
        key(Key1; No, "Tender No", "Contract Ref No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        // Bidders: Record "51516070";
        Vendor: Record "23";
}

