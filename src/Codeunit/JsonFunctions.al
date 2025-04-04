codeunit 172996 JsonFunctions
{

    // Convert records to json 
    procedure RecordToJson(Rec: Variant): JsonObject
    var
        JRecord: JsonObject;
        JMetaData: JsonObject;
        RecRef: RecordRef;
        i: Integer;
    begin
        RecRef.GetTable(Rec);

        //Record Metadata       
        JMetaData.Add('id', RecRef.Number());
        JMetaData.Add('name', DelChr(RecRef.Name(), '=', ' /.-*+'));
        JMetaData.Add('company', RecRef.CurrentCompany());
        JMetaData.Add('position', RecRef.GetPosition(true));
        JMetaData.Add('recordId', Format(RecRef.RecordId()));

        // Record Primary keys
        JRecord.Add('primaryKeys', PrimaryKeyToJson(RecRef));
        JRecord.Add('metadata', JMetaData);

        // Record Fields 

        JRecord.Add('fields', FieldToJson(RecRef));
        exit(JRecord);

    end;

    //Convert Fields to json 
    procedure FieldToJson(RecRef: RecordRef): JsonObject
    var
        i: Integer;
        FRef: FieldRef;
        JField: JsonObject;
        fieldName: Text;
        keyExists: Boolean;
        keys: Boolean;
        KeyValue: Text;
    begin
        JField := JField;
        for i := 1 to RecRef.FieldCount do begin
            FRef := RecRef.FieldIndex(i);
            if (i <> 273) and (i <> 270) then begin
                fieldName := DelChr(FRef.Name(), '=', ' /.-*+');
                keyExists := false;
                // Check if the key already exists
                if not JField.Contains(fieldName) then
                    JField.Add(fieldName, FieldToJsonValue(FRef));
            end;

            // if i <> 273 then
            //     //TODO Check on these indexes in future
            //     if i <> 270 then
            //         JField.add(DelChr(FRef.Name(), '=', ' /.-*+'), FieldToJsonValue(FRef));

        end;


        exit(JField);
    end;


    procedure PrimaryKeyToJson(RecRef: RecordRef): JsonObject
    var
        FR_PrimaryKey: FieldRef;
        KeyRef_PrimaryKey: KeyRef;
        JO_PrimaryKey: JsonObject;
        JO_Key: JsonArray;
        i: Integer;
        JsonValue: JsonValue;
    begin
        KeyRef_PrimaryKey := RecRef.KeyIndex(1);
        for i := 1 to KeyRef_PrimaryKey.FieldCount() do begin
            FR_PrimaryKey := KeyRef_PrimaryKey.FieldIndex(i);
            //JO_PrimaryKey.Add(FieldToJson(FR_PrimaryKey));
            JO_PrimaryKey.Add(FR_PrimaryKey.Name, FieldToJsonValue(FR_PrimaryKey));

        end;

        exit(JO_PrimaryKey);
    end;


    //This method allows us to obtain the value of a FieldRef.
    local procedure FieldToJsonValue(FieldRef: FieldRef): JsonValue
    var
        FieldValue: JsonValue;
        BoolValue: Boolean;
        IntValue: Integer;
        DecimalValue: Decimal;
        DateValue: Date;
        TimeValue: Time;
        DateTimeValue: DateTime;
        DurationValue: Duration;
        BigIntegerValue: BigInteger;
        GuidValue: Guid;
        RecordRefField: RecordRef;
    begin
        if (FieldRef.Class() = FieldClass::FlowField) then
            FieldRef.CalcField();

        if (FieldRef.Type() <> FieldType::Boolean) and (not HasValue(FieldRef)) then begin
            FieldValue.SetValueToNull();
            exit(FieldValue);
        end;

        case FieldRef.Type() of
            FieldType::Boolean:
                begin
                    BoolValue := FieldRef.Value();
                    FieldValue.SetValue(BoolValue);
                end;
            FieldType::Integer:
                begin
                    IntValue := FieldRef.Value();
                    FieldValue.SetValue(IntValue);
                end;
            FieldType::Decimal:
                begin
                    DecimalValue := FieldRef.Value();
                    FieldValue.SetValue(DecimalValue);
                end;
            FieldType::Date:
                begin
                    DateValue := FieldRef.Value();
                    FieldValue.SetValue(DateValue);
                end;
            FieldType::Time:
                begin
                    TimeValue := FieldRef.Value();
                    FieldValue.SetValue(TimeValue);
                end;
            FieldType::DateTime:
                begin
                    DateTimeValue := FieldRef.Value();
                    FieldValue.SetValue(DateTimeValue);
                end;
            FieldType::Duration:
                begin
                    DurationValue := FieldRef.Value();
                    FieldValue.SetValue(DurationValue);
                end;
            FieldType::BigInteger:
                begin
                    BigIntegerValue := FieldRef.Value();
                    FieldValue.SetValue(BigIntegerValue);
                end;
            FieldType::Guid:
                begin
                    GuidValue := FieldRef.Value();
                    FieldValue.SetValue(GuidValue);
                end;
            FieldType::MediaSet:
                begin
                    RecordRefField := FieldRef.Record();
                    FieldValue.SetValue(GetBase64(RecordRefField.Number, FieldRef));
                end;
            FieldType::Media:
                begin
                    RecordRefField := FieldRef.Record();
                    FieldValue.SetValue(GetBase64(RecordRefField.Number, FieldRef));
                end;
            else
                FieldValue.SetValue(Format(FieldRef.Value()));
        end;

        exit(FieldValue);
    end;


    //GetBase64: We use it to convert the images of the tables Vendor, Customer, Item, Employee in base 64.
    local procedure GetBase64("Table ID": Integer; FieldRef: FieldRef): Text
    var
        RecordRefImage: RecordRef;
        Base64: Codeunit "Base64 Convert";
        TenantMedia: Record "Tenant Media";
        ItemRec: Record Item;
        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
        EmployeeRec: Record Employee;
        TextOutput: Text;
        InStream: InStream;
    begin

        case "Table ID" of
            DATABASE::Item:
                begin
                    RecordRefImage := FieldRef.Record();
                    ItemRec.Get(RecordRefImage.RecordId);
                    if (ItemRec.Picture.Count > 0) then begin
                        if TenantMedia.Get(ItemRec.Picture.Item(1)) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue() then begin
                                TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
                                TextOutput := Base64.ToBase64(InStream);
                                exit(TextOutput);
                            end;
                        end else begin
                            TextOutput := 'NOIMAGE';
                            exit(TextOutput);
                        end;
                    end else begin
                        TextOutput := 'NOIMAGE';
                        exit(TextOutput);
                    end;
                end;
            DATABASE::Customer:
                begin
                    RecordRefImage := FieldRef.Record();
                    CustomerRec.Get(RecordRefImage.RecordId);
                    if (CustomerRec.Image.HasValue) then begin
                        if TenantMedia.Get(CustomerRec.Image.MediaId) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue() then begin
                                TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
                                TextOutput := Base64.ToBase64(InStream);
                                exit(TextOutput);
                            end;
                        end else begin
                            TextOutput := 'NOIMAGE';
                            exit(TextOutput);
                        end;
                    end else begin
                        TextOutput := 'NOIMAGE';
                        exit(TextOutput);
                    end;
                end;
            DATABASE::Vendor:
                begin
                    RecordRefImage := FieldRef.Record();
                    VendorRec.Get(RecordRefImage.RecordId);
                    if (VendorRec.Image.HasValue) then begin
                        if TenantMedia.Get(VendorRec.Image) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue() then begin
                                TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
                                TextOutput := Base64.ToBase64(InStream);
                                exit(TextOutput);
                            end;
                        end else begin
                            TextOutput := 'NOIMAGE';
                            exit(TextOutput);
                        end;
                    end else begin
                        TextOutput := 'NOIMAGE';
                        exit(TextOutput);
                    end;
                end;
            DATABASE::Employee:
                begin
                    RecordRefImage := FieldRef.Record();
                    EmployeeRec.Get(RecordRefImage.RecordId);
                    if (EmployeeRec.Image.HasValue) then begin
                        if TenantMedia.Get(EmployeeRec.Image) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue() then begin
                                TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
                                TextOutput := Base64.ToBase64(InStream);
                                exit(TextOutput);
                            end;
                        end else begin
                            TextOutput := 'NOIMAGE';
                            exit(TextOutput);
                        end;
                    end else begin
                        TextOutput := 'NOIMAGE';
                        exit(TextOutput);
                    end;
                end;
            else begin
                TextOutput := 'Not Handled'
            end;

        end;
    end;

    local procedure AssignValueToFieldRef(FR: FieldRef; JsonVal: JsonValue)
    begin
        case FR.Type() of
            FieldType::code,
        FieldType::Text:
                fr.Value := JsonVal.AsText();
            FieldType::Integer:
                fr.Value := JsonVal.AsInteger();
            FieldType::date:
                fr.Value := JsonVal.AsDate();
            FieldType::Decimal:
                fr.Value := JsonVal.AsDecimal();
            FieldType::Boolean:
                fr.Value := JsonVal.AsBoolean();
            FieldType::DateTime:
                fr.value := JsonVal.AsDateTime();
            FieldType::Duration:
                fr.value := JsonVal.AsDuration();
            FieldType::Option:
                Evaluate(fr, JsonVal.AsText());

            else
                error('1% is not supported', fr.Type());
        end;



    end;

    procedure HasValue(FieldRef: FieldRef): Boolean
    var
        HasValue: Boolean;
        Int: Integer;
        Dec: Decimal;
        D: Date;
        T: Time;
    begin
        case FieldRef.Type() of
            FieldType::Boolean:
                HasValue := FieldRef.Value();
            FieldType::Option:
                HasValue := true;
            FieldType::Integer:
                begin
                    Int := FieldRef.Value();
                    HasValue := Int <> 0;
                end;
            FieldType::Decimal:
                begin
                    Dec := FieldRef.Value();
                    HasValue := Dec <> 0;
                end;
            FieldType::Date:
                begin
                    D := FieldRef.Value();
                    HasValue := D <> 0D;
                end;
            FieldType::Time:
                begin
                    T := FieldRef.Value();
                    HasValue := T <> 0T;
                end;
            FieldType::Blob:
                HasValue := false;
            else
                HasValue := Format(FieldRef.Value()) <> '';
        end;

        exit(HasValue);
    end;

    procedure Json2Rec(JO: JsonObject; Rec: Variant): Variant
    var
        Ref: RecordRef;

    begin
        Ref.GetTable(Rec);
        exit(Json2Rec(JO, Ref.Number()));

    end;

    procedure Json2Rec(JO: JsonObject; TableNo: Integer): Variant
    var
        Ref: RecordRef;
        fieldHash: Dictionary of [Text, Integer];
        i: Integer;
        FR: FieldRef;
        JsonKey: Text;
        T: JsonToken;
        JsonVal: JsonValue;
        RecVariant: Variant;
        JField: JsonObject;
        fieldName: Text;
    begin

        Ref.Open(TableNo);
        for i := 1 to Ref.FieldCount() do begin
            FR := Ref.FieldIndex(i);
            if i <> 273 then
                if i <> 270 then
                    fieldName := DelChr(FR.Name(), '=', ' /.-*+');
            if not JField.Contains(fieldName) then
                fieldHash.add(DelChr(FR.Name(), '=', ' /.-*+'), FR.Number);

        end;

        Ref.Init();
        foreach Jsonkey in JO.keys() do begin
            if JO.Get(JsonKey, T) then begin
                if T.IsValue then begin
                    JsonVal := T.AsValue();

                    FR := Ref.Field(fieldHash.get(JsonKey));
                    AssignValueToFieldRef(FR, JsonVal);
                end;
            end;

        end;

        RecVariant := Ref;
        exit(RecVariant);
    end;

    procedure Json2Recs(JO: JsonObject; TableNo: Integer): Variant
    var
        Ref: RecordRef;
        fieldHash: Dictionary of [Text, Integer];
        i: Integer;
        FR: FieldRef;
        JsonKey: Text;
        T: JsonToken;
        JsonVal: JsonValue;
        RecVariant: Variant;
    begin

        Ref.Open(TableNo);
        for i := 1 to Ref.FieldCount() do begin
            FR := Ref.FieldIndex(i);
            if i <> 274 then
                if i <> 270 then
                    fieldHash.add(DelChr(FR.Name(), '=', ' /.-*+'), FR.Number);
        end;

        Ref.Init();
        foreach Jsonkey in JO.keys() do begin
            if JO.Get(JsonKey, T) then begin
                if T.IsValue then begin
                    JsonVal := T.AsValue();

                    FR := Ref.Field(fieldHash.get(JsonKey));
                    AssignValueToFieldRef(FR, JsonVal);
                end;
            end;

        end;

        RecVariant := Ref;
        exit(RecVariant);
    end;

    procedure intoDynamics()

    begin

    end;
}