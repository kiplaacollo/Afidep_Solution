Table 170038 "HR Policies"
{

    fields
    {
        field(1;"Code";Code[20])
        {
        }
        field(2;Date;Date)
        {
        }
        field(3;"Rules & Regulations";Text[250])
        {
        }
        field(4;"Document Link";Text[200])
        {
        }
        field(5;Remarks;Text[200])
        {
            NotBlank = false;
        }
        field(6;"Language Code (Default)";Code[10])
        {
        }
        field(7;Attachment;Option)
        {
            OptionMembers = No,Yes;
        }
        field(8;Type;Option)
        {
            OptionCaption = 'Is Rules & Regulation,Is Policy,Is Hr Procedure';
            OptionMembers = "Is Rules & Regulation","Is Policy","Is Hr Procedure";
        }
        field(9;"Document Description";Text[30])
        {
        }
        field(10;"No. Series";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code","Document Description")
        {
        }
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
          HRSetup.Get;
          HRSetup.TestField("HR Policies");
          NoSeriesMgt.InitSeries(HRSetup."HR Policies",xRec."No. Series",0D,Code,"No. Series");
        end;
    end;

    var
        HRSetup: Record "HR Setups";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

