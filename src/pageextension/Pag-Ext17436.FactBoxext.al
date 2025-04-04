pageextension 17436 FactBoxext extends "Actual/Sched. Summary FactBox"
{
    layout
    {
        addafter(SeventhDaySummary)
        {
            field(EigthDaySummary; DateQuantity[8])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[8];
                Editable = false;
            }
            field(NinethDaySummary; DateQuantity[9])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[9];
                Editable = false;
            }
            field(TenthSummary; DateQuantity[10])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[10];
                Editable = false;
            }
            field(EleventhDaySummary; DateQuantity[11])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[11];
                Editable = false;
            }
            field(TwelvethDaySummary; DateQuantity[12])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[12];
                Editable = false;
            }
            field(ThithteenthDaySummary; DateQuantity[13])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[13];
                Editable = false;
            }
            field(FouteenthDaySummary; DateQuantity[14])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[14];
                Editable = false;
            }
            field(fiteenthDaySummary; DateQuantity[15])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[15];
                Editable = false;
            }
            field(sixteenthDaySummary; DateQuantity[16])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[16];
                Editable = false;
            }
            field(seventeethSummary; DateQuantity[17])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[17];
                Editable = false;
            }
            field(EigteenthDaySummary; DateQuantity[18])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[18];
                Editable = false;
            }
            field(ninteethDaySummary; DateQuantity[19])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[19];
                Editable = false;
            }
            field(TwenthDaySummary; DateQuantity[20])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[20];
                Editable = false;
            }
            field(twen21DaySummary; DateQuantity[21])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[21];
                Editable = false;
            }

            field(twn22DaySummary; DateQuantity[22])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[22];
                Editable = false;
            }
            field(twen23DaySummary; DateQuantity[23])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[23];
                Editable = false;
            }
            field(twen24DaySummary; DateQuantity[24])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[24];
                Editable = false;
            }
            field(twen25thSummary; DateQuantity[25])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[25];
                Editable = false;
            }
            field(twen26DaySummary; DateQuantity[26])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[26];
                Editable = false;
            }
            field(twent27DaySummary; DateQuantity[27])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[27];
                Editable = false;
            }
            field(twent28DaySummary; DateQuantity[28])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[28];
                Editable = false;
            }
            field(twen29DaySummary; DateQuantity[29])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[29];
                Editable = false;
            }
            field(twent30DaySummary; DateQuantity[30])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[30];
                Editable = false;
            }
            field(twen31DaySummary; DateQuantity[31])
            {
                ApplicationArea = Jobs;
                CaptionClass = '3,' + DateDescription[31];
                Editable = false;
            }


        }
    }

    var
        DateDescription: array[32] of Text[30];
        DateQuantity: array[32] of Text[30];

    [IntegrationEvent(true, false)]
    local procedure OnBeforeUpdateData(
var TimeSheetHeader: Record "Time Sheet Header"; var DateDescription: array[32] of Text[30]; var DateQuantity: array[32] of Text[30];
var TotalQtyText: Text[30]; var TotalQuantity: Decimal; var AbsenceQty: Decimal; var PresenceQty: Decimal; var IsHandled: Boolean)
    begin
    end;
}
