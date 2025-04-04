report 80039 "Fix Payroll Allocation"
{
    Caption = 'Fix Payroll Allocation';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DistinctEmployees; "Payroll Project Allocation")
        {
            DataItemTableView = sorting("Employee No", "Period") order(ascending);
            RequestFilterFields = "Employee No", Period; // Allow filtering for specific employees or periods

            trigger OnAfterGetRecord()
            var
                PayrollAlloc: Record "Payroll Project Allocation";
                FirstEntry: Record "Payroll Project Allocation";
                TotalAllocation: Decimal;
                Difference: Decimal;
            begin
                // Initialize total allocation
                TotalAllocation := 0;

                // Find all allocations for this Employee No and Period
                PayrollAlloc.Reset();
                PayrollAlloc.SetRange("Employee No", "Employee No");
                PayrollAlloc.SetRange("Period", "Period");

                if PayrollAlloc.FindSet() then begin
                    repeat
                        TotalAllocation += PayrollAlloc.Allocation;
                    until PayrollAlloc.Next() = 0;
                end;

                // Fix if the total allocation is incorrect
                if TotalAllocation <> 100.00 then begin
                    Difference := 100.00 - TotalAllocation;

                    // Get the first entry to adjust
                    FirstEntry.Reset();
                    FirstEntry.SetRange("Employee No", "Employee No");
                    FirstEntry.SetRange("Period", "Period");

                    if FirstEntry.FindFirst() then begin
                        FirstEntry.Allocation += Difference;
                        FirstEntry.Modify();
                    end;
                end;
            end;
        }
    }

    trigger OnPostReport()
    begin
        Message('Payroll allocations have been corrected.');
    end;
}
