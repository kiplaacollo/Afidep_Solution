xmlport 50000 "Import Journals"
{
    Caption = 'Import Journals';
    Direction = Both;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = MSDOS;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'ImportJV';
                fieldelement(Template; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(batchname; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(PostingDate; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(documentno; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(Accounttype; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(Account; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(AccName; "Gen. Journal Line".Description)
                {
                }
                fieldelement(Description; "Gen. Journal Line".Description)
                {
                }
                fieldelement(Currency; "Gen. Journal Line"."Currency Code")
                {
                }
                fieldelement(debit; "Gen. Journal Line"."Debit Amount")
                {
                }
                fieldelement(credit; "Gen. Journal Line"."Credit Amount")
                {
                }
                fieldelement(FundNo; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(Donortcode; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(Budgetline; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(output; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(costcategory; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(Grant; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(staffcode; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    I += 1;
                    "Gen. Journal Line"."Line No." := I;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        I := 0;
    end;

    var
        I: Integer;
}

