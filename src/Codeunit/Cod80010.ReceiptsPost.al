Codeunit 80010 "Receipts-Post"
{

    trigger OnRun()
    begin
    end;

    var
        CMSetup: Record "Sales & Receivables Setup";
        Units: Record Customer;


    procedure PostReceipt(RptHeader: Record "Receipts Header")
    var
        GenJnLine: Record "Gen. Journal Line";
        RcptLine: Record "Receipt Lines";
        LineNo: Integer;
        Batch: Record "Gen. Journal Batch";
        GLEntry: Record "G/L Entry";
        RptHeader2: Record "Receipts Header";
        PayPeriods: Record "Billing and Payments Periods";
    begin

        if Confirm('Are you sure you want to post the receipt no '+RptHeader."No."+' ?')=true then begin

          if RptHeader.Posted then
             Error('The Receipt has been posted');
          // Check Amount
          RptHeader.CalcFields(RptHeader."Total Amount");
        //  IF RptHeader.Amount<>RptHeader."Total Amount" THEN
         //     ERROR(' The Amount must be equal to the Total Amount on the Lines');

           RptHeader.TestField("Bank Code");
           //RptHeader.TESTFIELD("Received From");
           RptHeader.TestField(Date);

           if RptHeader."Pay Mode"=RptHeader."pay mode"::MPESA then begin
             // RptHeader.TESTFIELD("Cheque No");
             // RptHeader.TESTFIELD("Cheque Date");
           end;

          CMSetup.Get();
          // Delete Lines Present on the General Journal Line
          GenJnLine.Reset;
          GenJnLine.SetRange(GenJnLine."Journal Template Name",CMSetup."Receipt Template");
          GenJnLine.SetRange(GenJnLine."Journal Batch Name",CMSetup."Receipt Batch");
          GenJnLine.DeleteAll;

          Batch.Init;
          if CMSetup.Get() then
          Batch."Journal Template Name":=CMSetup."Receipt Template";
          Batch.Name:=CMSetup."Receipt Batch";
          if not Batch.Get(Batch."Journal Template Name",Batch.Name) then
          Batch.Insert;

          //Post Bank entries
          RptHeader.CalcFields(RptHeader."Total Amount");
          LineNo:=LineNo+1000;
          GenJnLine.Init;
          GenJnLine."Journal Template Name":=CMSetup."Receipt Template";
          GenJnLine."Journal Batch Name":=CMSetup."Receipt Batch";
          GenJnLine."Line No.":=LineNo;
          GenJnLine."Account Type":=GenJnLine."account type"::"Bank Account";
          GenJnLine."Account No.":=RptHeader."Bank Code";
          GenJnLine."Posting Date":=RptHeader.Date;
          GenJnLine."Document No.":=RptHeader."No.";
          GenJnLine.Description:=RptHeader."On Behalf Of";
          GenJnLine.Amount:=RptHeader."Total Amount";
          GenJnLine.Validate(GenJnLine.Amount);
          GenJnLine."Currency Code":=RptHeader."Currency Code";
          GenJnLine.Validate(GenJnLine."Currency Code");
          GenJnLine."External Document No.":=RptHeader."Cheque No";
          GenJnLine."Currency Code":=RptHeader."Currency Code";
          GenJnLine.Validate(GenJnLine."Currency Code");
          GenJnLine.Period:=RptHeader."Payment Period";
          GenJnLine."Shortcut Dimension 1 Code":=RptHeader."Global Dimension 1 Code";
          GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
          GenJnLine."Shortcut Dimension 2 Code":=RptHeader."Global Dimension 2 Code";
          GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");

          if GenJnLine.Amount<>0 then
             GenJnLine.Insert;


         //Post the receipt lines
          RcptLine.SetRange(RcptLine."Receipt No.",RptHeader."No.");
          if RcptLine.FindFirst then begin
             repeat
             RcptLine.Validate(Amount);
             LineNo:=LineNo+1000;
             GenJnLine.Init;
             GenJnLine."Journal Template Name":=CMSetup."Receipt Template";
             GenJnLine."Journal Batch Name":=CMSetup."Receipt Batch";
             GenJnLine."Line No.":=LineNo;
             GenJnLine."Account Type":=RcptLine."Account Type";
             GenJnLine."Account No.":=RcptLine."Account No.";
             GenJnLine.Validate(GenJnLine."Account No.");
             GenJnLine."Posting Date":=RptHeader.Date;
             GenJnLine."Document No.":=RptHeader."No.";
             GenJnLine.Description:=RcptLine.Description;
             GenJnLine.Period:=RptHeader."Payment Period";
             GenJnLine.Amount:=-RcptLine."Net Amount";
             GenJnLine.Property:=RcptLine.Property;
             GenJnLine.Ammenity:=RcptLine.Ammenity;
             GenJnLine.Validate(GenJnLine.Amount);
             GenJnLine."External Document No.":=RptHeader."Cheque No";
             GenJnLine."Currency Code":=RptHeader."Currency Code";
             GenJnLine.Validate(GenJnLine."Currency Code");
             if Units.Get(RcptLine."Account No.") then
             GenJnLine.Property:=Units.Property22;
             GenJnLine."Shortcut Dimension 1 Code":=RcptLine."Global Dimension 1 Code";
             GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
             GenJnLine."Shortcut Dimension 2 Code":=RcptLine."Global Dimension 2 Code";
             GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
             if GenJnLine.Amount<>0 then
                GenJnLine.Insert;
             until
              RcptLine.Next=0;
            end;

            Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJnLine);

            Commit;

            RptHeader2.Reset;
            RptHeader2.SetRange(RptHeader2."No.",RptHeader."No.");
            if RptHeader2.FindFirst then begin
              GLEntry.Reset;
              GLEntry.SetRange(GLEntry."Document No.",RptHeader2."No.");
              GLEntry.SetRange(GLEntry.Reversed,false);
              if GLEntry.FindFirst then begin
                  RptHeader2.Posted:=true;
                  RptHeader2."Posted Date":=Today;
                  RptHeader2."Posted Time":=Time;
                  RptHeader2."Posted By":=UserId;
                  RptHeader2.Modify;
                  //==============================================

                //===============================================
            end;
          end;
        end;
    end;


    procedure PostReceiptSMS(RptHeader: Record "Receipts Header")
    var
        GenJnLine: Record "Gen. Journal Line";
        RcptLine: Record "Receipt Lines";
        LineNo: Integer;
        Batch: Record "Gen. Journal Batch";
        GLEntry: Record "G/L Entry";
    begin
          if RptHeader.Posted then
             Error('The Receipt has been posted');
          // Check Amount
           RptHeader.CalcFields(RptHeader."Total Amount");
           RptHeader.TestField("Bank Code");
          // RptHeader.TESTFIELD("Pay Mode");
           RptHeader.TestField("Received From");
           RptHeader.TestField(Date);

           if RptHeader."Pay Mode"=RptHeader."pay mode"::MPESA then begin
              RptHeader.TestField("Cheque No");
              RptHeader.TestField("Cheque Date");
           end;

          CMSetup.Get();
          // Delete Lines Present on the General Journal Line
          GenJnLine.Reset;
          GenJnLine.SetRange(GenJnLine."Journal Template Name",CMSetup."Receipt Template");
          GenJnLine.SetRange(GenJnLine."Journal Batch Name",CMSetup."Receipt Batch");
          GenJnLine.DeleteAll;

          Batch.Init;
          if CMSetup.Get() then
          Batch."Journal Template Name":=CMSetup."Receipt Template";
          Batch.Name:=CMSetup."Receipt Batch";
          if not Batch.Get(Batch."Journal Template Name",Batch.Name) then
          Batch.Insert;

          //Post Bank entries
          RptHeader.CalcFields(RptHeader."Total Amount");
          LineNo:=LineNo+1000;
          GenJnLine.Init;
          GenJnLine."Journal Template Name":=CMSetup."Receipt Template";
          GenJnLine."Journal Batch Name":=CMSetup."Receipt Batch";
          GenJnLine."Line No.":=LineNo;
          GenJnLine."Account Type":=GenJnLine."account type"::"Bank Account";
          GenJnLine."Account No.":=RptHeader."Bank Code";
          GenJnLine."Posting Date":=RptHeader.Date;
          GenJnLine."Document No.":=RptHeader."No.";
          GenJnLine.Description:=RptHeader."Received From";
          GenJnLine.Amount:=RptHeader."Total Amount";
          GenJnLine.Validate(GenJnLine.Amount);
          GenJnLine."Currency Code":=RptHeader."Currency Code";
          GenJnLine.Validate(GenJnLine."Currency Code");
          GenJnLine."External Document No.":=RptHeader."Cheque No";
          GenJnLine."Currency Code":=RptHeader."Currency Code";
          GenJnLine.Validate(GenJnLine."Currency Code");
          //GenJnLine."Pay Mode":=RptHeader."Pay Mode";
          if RptHeader."Pay Mode"=RptHeader."pay mode"::MPESA then
          GenJnLine."Cheque Date":=RptHeader."Cheque Date";
          GenJnLine."Shortcut Dimension 1 Code":=RptHeader."Global Dimension 1 Code";
          GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
          GenJnLine."Shortcut Dimension 2 Code":=RptHeader."Global Dimension 2 Code";
          GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");

          if GenJnLine.Amount<>0 then
             GenJnLine.Insert;


         //Post the receipt lines
          RcptLine.SetRange(RcptLine."Receipt No.",RptHeader."No.");
          if RcptLine.FindFirst then begin
             repeat
             RcptLine.Validate(Amount);
             LineNo:=LineNo+1000;
             GenJnLine.Init;
             GenJnLine."Journal Template Name":=CMSetup."Receipt Template";
             GenJnLine."Journal Batch Name":=CMSetup."Receipt Batch";
             GenJnLine."Line No.":=LineNo;
             GenJnLine."Account Type":=RcptLine."Account Type";
             GenJnLine."Account No.":=RcptLine."Account No.";
             GenJnLine.Validate(GenJnLine."Account No.");
             GenJnLine."Posting Date":=RptHeader.Date;
             GenJnLine."Document No.":=RptHeader."No.";
             GenJnLine.Description:=RcptLine.Description;
             GenJnLine.Amount:=-RcptLine."Net Amount";
             GenJnLine.Validate(GenJnLine.Amount);
             GenJnLine."External Document No.":=RptHeader."Cheque No";
             GenJnLine."Currency Code":=RptHeader."Currency Code";
             GenJnLine.Validate(GenJnLine."Currency Code");
             GenJnLine."Shortcut Dimension 1 Code":=RcptLine."Global Dimension 1 Code";
             GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
             GenJnLine."Shortcut Dimension 2 Code":=RcptLine."Global Dimension 2 Code";
             GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
             if RcptLine."Applies to Doc. No"<>'' then begin
             GenJnLine."Applies-to Doc. Type":=RcptLine."Applies-to Doc. Type";
             GenJnLine."Applies-to Doc. No.":=RcptLine."Applies to Doc. No";
             GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
             end;
             if GenJnLine.Amount<>0 then
                GenJnLine.Insert;
             until
              RcptLine.Next=0;
            end;

            Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.",RptHeader."No.");
            GLEntry.SetRange(GLEntry.Reversed,false);
            if GLEntry.FindFirst then begin
            RptHeader.Posted:=true;
            RptHeader."Posted Date":=Today;
            RptHeader."Posted Time":=Time;
            RptHeader."Posted By":=UserId;
            RptHeader.Modify;
            end;
    end;
}

