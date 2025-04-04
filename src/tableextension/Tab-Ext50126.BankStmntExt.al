tableextension 50126 "BankStmntExt" extends "Bank Account Statement"
{
    fields
    {
        field(1720; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Rejected,Canceled,Approved';
            OptionMembers = New,"Pending Approval",Rejected,Canceled,Approved;

        }
        field(1721; "Branch Code"; Code[30])
        {
            CaptionClass = '1,1,1';
            Caption = 'Branch Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(99000801; Approver1Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(99000802; Approver2Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(99000803; Approver2Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(99000804; Approver3Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(99000805; Approver3Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(99000806; Approver1Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(99000807; Approver2Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(99000808; Approver3Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(99000809; RequesterDate; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // if RequesterDate = 0D then
                //     RequesterDate := DT2Date(SystemCreatedAt);
                // Rec.Modify();
            end;
        }
        field(99000810; Approver1Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(99000811; "Requester Signature"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(99000812; RequesterName; Text[100])
        {
            DataClassification = ToBeClassified;
        }



    }


}