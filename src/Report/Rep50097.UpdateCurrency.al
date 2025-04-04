report 50097 "Update Currency Factor"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    // DefaultRenderingLayout = LayoutName;
    // DefaultLayout = RDLC;
    //  RDLCLayout = 'Layouts/UpdateDetailed.Rdlc';

    dataset
    {

        dataitem(PrTrans; "Payroll Monthly Trans_AU")
        {
            //RequestFilterFields = "Customer No.";
            column(Transaction_Code; "Transaction Code")
            {

            }
            trigger
            OnAfterGetRecord()
            var
                prtrans: Record "Payroll Monthly Trans_AU";
                prtransm: Record "Payroll Monthly Trans_Malawi";

            begin
                prtrans.Reset();
                prtrans.SetRange(prtrans."Transaction Code", "Transaction Code");

                if prtrans.FindSet() then begin
                    repeat
                        if (prtrans.Amount <> 0) and (prtrans."Amount(LCY)" <> 0) then begin
                            prtrans."Currency Factor" := prtrans.Amount / prtrans."Amount(LCY)";
                        end;

                        prtrans.Modify(true);


                    until prtrans.Next() = 0;
                    Message('Transaction Went sucessful');
                end;
                prtransm.Reset();
                prtransm.SetRange(prtransm."Transaction Code", "Transaction Code");

                if prtransm.FindSet() then begin
                    repeat
                        if (prtransm.Amount <> 0) and (prtransm."Amount(LCY)" <> 0) then begin
                            prtransm."Currency Factor" := prtransm.Amount / prtransm."Amount(LCY)";
                        end;

                        prtransm.Modify(true);


                    until prtransm.Next() = 0;
                    Message('Transaction Went sucessful');
                end;


            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        myInt: Integer;
}