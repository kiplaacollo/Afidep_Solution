page 17381 TimeSheetsC
{
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Time Sheets Custom';
    AutoSplitKey = true;
    DataCaptionFields = "Time Sheet No.";
    PageType = Worksheet;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Time Sheet Line";


    layout
    {
        area(content)
        {
            group(Control26)
            {
                ShowCaption = false;
                field(CurrTimeSheetNo; CurrTimeSheetNo)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Time Sheet No';
                    ToolTip = 'Specifies the number of the time sheet.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CurrPage.SaveRecord();
                        TimeSheetMgt.LookupOwnerTimeSheet(CurrTimeSheetNo, Rec, TimeSheetHeader);
                        UpdateControls();
                    end;

                    trigger OnValidate()
                    begin
                        TimeSheetHeader.Reset();
                        TimeSheetMgt.FilterTimeSheets(TimeSheetHeader, TimeSheetHeader.FieldNo("Owner User ID"));
                        TimeSheetMgt.CheckTimeSheetNo(TimeSheetHeader, CurrTimeSheetNo);
                        CurrPage.SaveRecord();
                        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo, Rec);
                        UpdateControls();
                    end;
                }
                field(ResourceNo; TimeSheetHeader."Resource No.")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resource No.';
                    Editable = false;
                    ToolTip = 'Specifies a number for the resource.';
                }
                field(ApproverUserID; TimeSheetHeader."Approver User ID")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Approver User ID';
                    Editable = false;
                    ToolTip = 'Specifies the ID of the time sheet approver.';
                    Visible = false;
                }
                field(StartingDate; TimeSheetHeader."Starting Date")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Starting Date';
                    Editable = false;
                    ToolTip = 'Specifies the date from which the report or batch job processes information.';
                }
                field(EndingDate; TimeSheetHeader."Ending Date")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Ending Date';
                    Editable = false;
                    ToolTip = 'Specifies the date to which the report or batch job processes information.';
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Jobs;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the type of time sheet line.';

                    trigger OnValidate()
                    begin
                        AfterGetCurrentRecord();
                        CurrPage.Update(true);
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Jobs;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the number for the job that is associated with the time sheet line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = Jobs;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the number of the related job task.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Jobs;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies a description of the time sheet line.';

                    trigger OnAssistEdit()
                    begin
                        if Rec."Line No." = 0 then
                            exit;

                        Rec.ShowLineDetails(false);
                        CurrPage.Update(false);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ApplicationArea = Jobs;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies a list of standard absence codes, from which you may select one.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field(Chargeable; Rec.Chargeable)
                {
                    ApplicationArea = Jobs;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies if the usage that you are posting is chargeable.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = Jobs;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies which work type the resource applies to. Prices are updated based on this entry.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    ApplicationArea = Jobs;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the service order number that is associated with the time sheet line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Assembly Order No."; Rec."Assembly Order No.")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the assembly order number that is associated with the time sheet line.';
                    Visible = false;
                }
                field(Field1; CellData[1])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[1];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(1);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field2; CellData[2])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[2];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(2);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field3; CellData[3])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[3];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(3);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field4; CellData[4])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[4];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(4);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field5; CellData[5])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[5];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(5);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field6; CellData[6])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[6];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(6);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field7; CellData[7])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[7];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(7);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field8; CellData[8])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[8];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(8);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field9; CellData[9])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[9];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(9);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field10; CellData[10])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[10];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(10);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field11; CellData[11])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[11];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(11);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field12; CellData[12])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[12];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(12);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field13; CellData[13])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[13];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(13);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field14; CellData[14])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[14];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(14);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field15; CellData[15])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[15];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(15);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field16; CellData[16])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[16];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(16);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field17; CellData[17])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[17];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(17);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field18; CellData[18])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[18];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(18);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field19; CellData[19])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[19];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(19);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field20; CellData[20])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[20];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(20);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field21; CellData[21])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[21];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(21);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field22; CellData[22])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[22];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(22);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field23; CellData[23])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[23];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(23);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field24; CellData[24])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[24];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(24);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field25; CellData[25])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[25];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(25);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field26; CellData[26])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[26];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(26);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field27; CellData[27])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[27];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(27);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field28; CellData[28])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[28];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(28);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field29; CellData[29])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[29];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(29);
                        CellDataOnAfterValidate();
                    end;
                }
                field(Field30; CellData[30])
                {
                    ApplicationArea = Jobs;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[30];
                    DecimalPlaces = 0 : 2;
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        ValidateQuantity(30);
                        CellDataOnAfterValidate();
                    end;
                }
                // field(Field31; CellData[31])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[31];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(31);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                // field(Field32; CellData[32])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[32];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(32);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                // field(Field33; CellData[33])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[33];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(33);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                // field(Field36; CellData[36])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[36];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(36);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                // field(Field34; CellData[34])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[34];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(34);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                // field(Field35; CellData[35])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[35];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(35);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                // field(Field37; CellData[37])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[37];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(37);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                // field(Field38; CellData[38])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[38];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(35);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                // field(Field39; CellData[35])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[39];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(39);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                // field(Field40; CellData[35])
                // {
                //     ApplicationArea = Jobs;
                //     BlankZero = true;
                //     CaptionClass = '3,' + ColumnCaption[40];
                //     DecimalPlaces = 0 : 2;
                //     Editable = AllowEdit;
                //     Width = 6;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.SaveRecord();
                //         ValidateQuantity(40);
                //         CellDataOnAfterValidate();
                //     end;
                // }
                field("Total Quantity"; Rec."Total Quantity")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Total';
                    DrillDown = false;
                    ToolTip = 'Specifies the total number of hours that have been entered on a time sheet.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies information about the status of a time sheet line.';
                }
            }
        }
        area(factboxes)
        {
            part(TimeSheetStatusFactBox; "Time Sheet Status FactBox")
            {
                ApplicationArea = Jobs;
                Caption = 'Time Sheet Status';
            }
            part(ActualSchedSummaryFactBox; "Actual/Sched. Summary FactBox")
            {
                ApplicationArea = Jobs;
                Caption = 'Actual/Budgeted Summary';
                Visible = true;
            }
            part(ActivityDetailsFactBox; "Activity Details FactBox")
            {
                ApplicationArea = Jobs;
                Caption = 'Activity Details';
                SubPageLink = "Time Sheet No." = field("Time Sheet No."),
                              "Line No." = field("Line No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Time Sheet")
            {
                Caption = '&Time Sheet';
                Image = Timesheet;
                action(PreviousPeriod)
                {
                    ApplicationArea = Jobs;
                    Caption = '&Previous Period';
                    Image = PreviousSet;
                    ToolTip = 'Show the information based on the previous period. If you set the View by field to Day, the date filter changes to the day before.';

                    trigger OnAction()
                    begin
                        FindTimeSheet(SetWanted::Previous);
                    end;
                }
                action(NextPeriod)
                {
                    ApplicationArea = Jobs;
                    Caption = '&Next Period';
                    Image = NextSet;
                    ToolTip = 'View information for the next period.';

                    trigger OnAction()
                    begin
                        FindTimeSheet(SetWanted::Next);
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Time Sheet Allocation")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Time Sheet Allocation';
                    Image = Allocate;
                    ToolTip = 'Allocate posted hours among days of the week on a time sheet.';

                    trigger OnAction()
                    begin
                        TimeAllocation();
                    end;
                }
                action("Activity &Details")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Activity &Details';
                    Image = View;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View the quantity of hours for each time sheet status.';

                    trigger OnAction()
                    begin
                        Rec.ShowLineDetails(false);
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    var
                        DimMgt: Codeunit DimensionManagement;
                    begin
                        Rec."Dimension Set ID" := DimMgt.EditDimensionSet(Rec."Dimension Set ID", DimensionCaptionTok);
                    end;
                }
            }
            group(Comments)
            {
                Caption = 'Co&mments';
                Image = ViewComments;
                action(TimeSheetComments)
                {
                    ApplicationArea = Comments;
                    Caption = '&Time Sheet Comments';
                    Image = ViewComments;
                    RunObject = Page "Time Sheet Comment Sheet";
                    RunPageLink = "No." = field("Time Sheet No."),
                                  "Time Sheet Line No." = const(0);
                    ToolTip = 'View comments about the time sheet.';
                }
                action(LineComments)
                {
                    ApplicationArea = Comments;
                    Caption = '&Line Comments';
                    Image = ViewComments;
                    RunObject = Page "Time Sheet Comment Sheet";
                    RunPageLink = "No." = field("Time Sheet No."),
                                  "Time Sheet Line No." = field("Line No.");
                    Scope = Repeater;
                    ToolTip = 'View or create comments.';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Submit)
                {
                    ApplicationArea = Jobs;
                    Caption = '&Submit';
                    Image = ReleaseDoc;
                    ShortCutKey = 'F9';
                    ToolTip = 'Submit the time sheet for approval.';

                    trigger OnAction()
                    begin
                        SubmitLines();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Jobs;
                    Caption = '&Reopen';
                    Image = ReOpen;
                    ToolTip = 'Reopen the time sheet, for example, after it has been rejected. The approver of a time sheet has permission to approve, reject, or reopen a time sheet. The approver can also submit a time sheet for approval.';

                    trigger OnAction()
                    begin
                        ReopenLines();
                    end;
                }
                separator(Action28)
                {
                }
                action(CopyLinesFromPrevTS)
                {
                    ApplicationArea = Jobs;
                    Caption = '&Copy lines from previous time sheet';
                    Image = Copy;
                    ToolTip = 'Copy information from the previous time sheet, such as type and description, and then modify the lines. If a line is related to a job, the job number is copied.';

                    trigger OnAction()
                    begin
                        TimeSheetMgt.CheckCopyPrevTimeSheetLines(TimeSheetHeader);
                    end;
                }
                action(CreateLinesFromJobPlanning)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Create lines from &job planning';
                    Image = CreateLinesFromJob;
                    ToolTip = 'Create time sheet lines that are based on job planning lines.';

                    trigger OnAction()
                    begin
                        TimeSheetMgt.CheckCreateLinesFromJobPlanning(TimeSheetHeader);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(Submit_Promoted; Submit)
                {
                }
                actionref(Reopen_Promoted; Reopen)
                {
                }
                actionref(PreviousPeriod_Promoted; PreviousPeriod)
                {
                }
                actionref(NextPeriod_Promoted; NextPeriod)
                {
                }
            }
            group(Category_Prepare)
            {
                Caption = 'Prepare';

                actionref(CopyLinesFromPrevTS_Promoted; CopyLinesFromPrevTS)
                {
                }
                actionref(CreateLinesFromJobPlanning_Promoted; CreateLinesFromJobPlanning)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Line', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref("Activity &Details_Promoted"; "Activity &Details")
                {
                }
                actionref("Time Sheet Allocation_Promoted"; "Time Sheet Allocation")
                {
                }
                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(TimeSheetComments_Promoted; TimeSheetComments)
                {
                }
                actionref(LineComments_Promoted; LineComments)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 3.';
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AfterGetCurrentRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AfterGetCurrentRecord();
    end;

    trigger OnOpenPage()
    begin
        if Rec."Time Sheet No." <> '' then
            CurrTimeSheetNo := Rec."Time Sheet No."
        else
            CurrTimeSheetNo := TimeSheetHeader.FindLastTimeSheetNo(TimeSheetHeader.FieldNo("Owner User ID"));
        OnOpenPageOnAfterSetCurrTimeSheetNo(TimeSheetHeader, Rec);

        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo, Rec);
        UpdateControls();
    end;

    var
        TimeSheetDetail: Record "Time Sheet Detail";
        ColumnRecords: array[32] of Record Date;
        TimeSheetMgt: Codeunit "AU Timesheet Mgt";
        TimeSheetApprovalMgt: Codeunit "Time Sheet Approval Management";
        NoOfColumns: Integer;
        CellData: array[32] of Decimal;
        ColumnCaption: array[32] of Text[1024];
        CurrTimeSheetNo: Code[20];
        SetWanted: Option Previous,Next;
        Text001: Label 'The type of time sheet line cannot be empty.';
        AllowEdit: Boolean;
        DimensionCaptionTok: Label 'Dimensions';

    protected var
        TimeSheetHeader: Record "Time Sheet Header";

    procedure SetColumns()
    var
        Calendar: Record Date;
    begin
        Clear(ColumnCaption);
        Clear(ColumnRecords);
        Clear(Calendar);
        Clear(NoOfColumns);


        GetTimeSheetHeader();
        Calendar.SetRange("Period Type", Calendar."Period Type"::Date);
        Calendar.SetRange("Period Start", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
        if Calendar.FindSet() then
            repeat
                NoOfColumns += 1;
                ColumnRecords[NoOfColumns]."Period Start" := Calendar."Period Start";
                ColumnCaption[NoOfColumns] := TimeSheetMgt.FormatDate(Calendar."Period Start", 1);
            until Calendar.Next() = 0;
    end;

    local procedure GetTimeSheetHeader()
    begin
        TimeSheetHeader.Get(CurrTimeSheetNo);

        OnAfterGetTimeSheetHeader(TimeSheetHeader);
    end;

    local procedure AfterGetCurrentRecord()
    var
        i: Integer;
    begin
        i := 0;
        while i < NoOfColumns do begin
            i := i + 1;
            if (Rec."Line No." <> 0) and TimeSheetDetail.Get(
                 Rec."Time Sheet No.",
                 Rec."Line No.",
                 ColumnRecords[i]."Period Start")
            then
                CellData[i] := TimeSheetDetail.Quantity
            else
                CellData[i] := 0;
        end;
        UpdateFactBoxes();
        AllowEdit := Rec.Status in [Rec.Status::Open, Rec.Status::Rejected];
    end;

    local procedure ValidateQuantity(ColumnNo: Integer)
    begin
        if (CellData[ColumnNo] <> 0) and (Rec.Type = Rec.Type::" ") then
            Error(Text001);

        if TimeSheetDetail.Get(
             Rec."Time Sheet No.",
             Rec."Line No.",
             ColumnRecords[ColumnNo]."Period Start")
        then begin
            if CellData[ColumnNo] <> TimeSheetDetail.Quantity then
                TestTimeSheetLineStatus();

            if CellData[ColumnNo] = 0 then
                TimeSheetDetail.Delete()
            else begin
                TimeSheetDetail.Quantity := CellData[ColumnNo];
                TimeSheetDetail.Modify(true);
            end;
        end else
            if CellData[ColumnNo] <> 0 then begin
                TestTimeSheetLineStatus();

                TimeSheetDetail.Init();
                TimeSheetDetail.CopyFromTimeSheetLine(Rec);
                TimeSheetDetail.Date := ColumnRecords[ColumnNo]."Period Start";
                TimeSheetDetail.Quantity := CellData[ColumnNo];
                TimeSheetDetail.Insert(true);
            end;
    end;

    local procedure Process("Action": Option "Submit Selected","Submit All","Reopen Selected","Reopen All")
    var
        TimeSheetLine: Record "Time Sheet Line";
        TempTimeSheetLine: Record "Time Sheet Line" temporary;
        ActionType: Option Submit,Reopen;
    begin
        CurrPage.SaveRecord();
        case Action of
            Action::"Submit All":
                FilterAllLines(TimeSheetLine, ActionType::Submit);
            Action::"Reopen All":
                FilterAllLines(TimeSheetLine, ActionType::Reopen);
            else
                CurrPage.SetSelectionFilter(TimeSheetLine);
        end;
        OnProcessOnAfterTimeSheetLinesFiltered(TimeSheetLine, Action);
        TimeSheetMgt.CopyFilteredTimeSheetLinesToBuffer(TimeSheetLine, TempTimeSheetLine);
        if TimeSheetLine.FindSet() then
            repeat
                case Action of
                    Action::"Submit Selected",
                  Action::"Submit All":
                        TimeSheetApprovalMgt.Submit(TimeSheetLine);
                    Action::"Reopen Selected",
                  Action::"Reopen All":
                        TimeSheetApprovalMgt.ReopenSubmitted(TimeSheetLine);
                end;
            until TimeSheetLine.Next() = 0;
        OnAfterProcess(TempTimeSheetLine, Action);
        CurrPage.Update(true);
    end;

    local procedure CellDataOnAfterValidate()
    begin
        UpdateFactBoxes();
        Rec.CalcFields("Total Quantity");
    end;

    local procedure FindTimeSheet(Which: Option)
    begin
        CurrTimeSheetNo := TimeSheetMgt.FindTimeSheet(TimeSheetHeader, Which);
        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo, Rec);
        UpdateControls();
    end;

    local procedure UpdateFactBoxes()
    begin
        // CurrPage.ActualSchedSummaryFactBox.PAGE.UpdateData(TimeSheetHeader);
        // CurrPage.TimeSheetStatusFactBox.PAGE.UpdateData(TimeSheetHeader);
        // if Rec."Line No." = 0 then
        //     CurrPage.ActivityDetailsFactBox.PAGE.SetEmptyLine();
    end;

    local procedure UpdateControls()
    begin
        SetColumns();
        // UpdateFactBoxes();
        CurrPage.Update(false);
    end;

    local procedure TestTimeSheetLineStatus()
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetLine.Get(Rec."Time Sheet No.", Rec."Line No.");
        TimeSheetLine.TestStatus();
    end;

    local procedure SubmitLines()
    var
        "Action": Option "Submit Selected","Submit All","Reopen Selected","Reopen All";
        ActionType: Option Submit,Reopen;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeSubmitLines(Rec, IsHandled);
        if IsHandled then
            exit;

        case ShowDialog(ActionType::Submit) of
            1:
                Process(Action::"Submit All");
            2:
                Process(Action::"Submit Selected");
        end;
    end;

    local procedure ReopenLines()
    var
        ActionType: Option Submit,Reopen;
        "Action": Option "Submit Selected","Submit All","Reopen Selected","Reopen All";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeReopenLines(Rec, IsHandled);
        if IsHandled then
            exit;

        case ShowDialog(ActionType::Reopen) of
            1:
                Process(Action::"Reopen All");
            2:
                Process(Action::"Reopen Selected");
        end;
    end;

    local procedure TimeAllocation()
    var
        TimeSheetAllocation: Page "Time Sheet Allocation";
        AllocatedQty: array[7] of Decimal;
    begin
        Rec.TestField(Posted, true);
        Rec.CalcFields("Total Quantity");
        TimeSheetAllocation.InitParameters(Rec."Time Sheet No.", Rec."Line No.", Rec."Total Quantity");
        if TimeSheetAllocation.RunModal() = ACTION::OK then begin
            TimeSheetAllocation.GetAllocation(AllocatedQty);
            TimeSheetMgt.UpdateTimeAllocation(Rec, AllocatedQty);
        end;
    end;

    local procedure GetDialogText(ActionType: Option Submit,Reopen): Text[100]
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        FilterAllLines(TimeSheetLine, ActionType);
        exit(TimeSheetApprovalMgt.GetTimeSheetDialogText(ActionType, TimeSheetLine.Count));
    end;

    local procedure FilterAllLines(var TimeSheetLine: Record "Time Sheet Line"; ActionType: Option Submit,Reopen)
    begin
        TimeSheetLine.SetRange("Time Sheet No.", CurrTimeSheetNo);
        TimeSheetLine.CopyFilters(Rec);
        TimeSheetLine.FilterGroup(2);
        TimeSheetLine.SetFilter(Type, '<>%1', TimeSheetLine.Type::" ");
        TimeSheetLine.FilterGroup(0);
        case ActionType of
            ActionType::Submit:
                TimeSheetLine.SetFilter(Status, '%1|%2', TimeSheetLine.Status::Open, TimeSheetLine.Status::Rejected);
            ActionType::Reopen:
                TimeSheetLine.SetRange(Status, TimeSheetLine.Status::Submitted);
        end;

        OnAfterFilterAllLines(TimeSheetLine, ActionType);
    end;

    local procedure ShowDialog(ActionType: Option Submit,Reopen): Integer
    begin
        exit(StrMenu(GetDialogText(ActionType), 1, TimeSheetApprovalMgt.GetTimeSheetDialogInstruction(ActionType)));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFilterAllLines(var TimeSheetLine: Record "Time Sheet Line"; ActionType: Option Submit,Reopen)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetTimeSheetHeader(var TimeSheetHeader: Record "Time Sheet Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnProcessOnAfterTimeSheetLinesFiltered(var TimeSheetLine: Record "Time Sheet Line"; "Action": Option "Submit Selected","Submit All","Reopen Selected","Reopen All")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterProcess(var TimeSheetLine: Record "Time Sheet Line"; "Action": Option "Submit Selected","Submit All","Reopen Selected","Reopen All")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeReopenLines(var TimeSheetLine: Record "Time Sheet Line"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSubmitLines(var TimeSheetLine: Record "Time Sheet Line"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnOpenPageOnAfterSetCurrTimeSheetNo(var TimeSheetHeader: Record "Time Sheet Header"; var TimeSheetLine: Record "Time Sheet Line")
    begin
    end;
}


