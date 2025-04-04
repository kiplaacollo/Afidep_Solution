tableextension 50105 "PurchaseHeaderExtension" extends "Purchase Header"
{
    fields
    {

        field(9002; DocApprovalType2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Purchase,Requisition,Quote,Capex';
            OptionMembers = Purchase,Requisition,Quote,Capex;
        }
        field(172010; "Type of Payment2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = General,Imprest,PurchaseRequisition,ExpenseRequisition;
            OptionCaption = 'General,Imprest,PurchaseRequisition,ExpenseRequisition';
        }
        field(9003; PR; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9004; Requisition; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9005; Service; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9006; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9007; "Doc Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,PurchReq,"Mission Proposal";
        }
        field(9008; Completed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9009; "Requisition No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where(PR = const(true),
                                                           Status = const(Released));

            trigger OnValidate()
            begin
                /* //CHECK WHETHER HAS LINES AND DELETE
                 // if Confirm('If you change the requisition no. the current lines will be deleted. Do you want to continue?') then begin

                 //   PurchLine.Reset;
                 // PurchLine.SetRange(PurchLine."Document No.", "No.");

                 //if PurchLine.Find('-') then
                 //  PurchLine.DeleteAll;


                 //POPULATTE PURCHASE LINE WHEN USER SELECTS RFQ.
                 RFQ.Reset;
                 RFQ.SetRange("Document No.", "Requisition No");
                 if RFQ.Find('-') then begin
                     repeat
                         PurchLine2.Init;

                         LineNo := LineNo + 1000;
                         PurchLine2."Document Type" := "Document Type";
                         PurchLine2.Validate("Document Type");
                         PurchLine2."Document No." := "No.";
                         PurchLine2.Validate("Document No.");
                         PurchLine2."Line No." := LineNo;
                         PurchLine2.Type := RFQ.Type;
                         PurchLine2."No." := RFQ."No.";
                         PurchLine2.Validate("No.");
                         PurchLine2.Description := RFQ.Description;
                         PurchLine2."Description 2" := RFQ."Description 2";
                         PurchLine2.Quantity := RFQ.Quantity;
                         PurchLine2.Validate(Quantity);
                         PurchLine2."Unit of Measure Code" := RFQ."Unit of Measure Code";
                         PurchLine2.Validate("Unit of Measure Code");
                         PurchLine2."Direct Unit Cost" := RFQ."Direct Unit Cost";
                         PurchLine2.Validate("Direct Unit Cost");
                         PurchLine2."Location Code" := RFQ."Location Code";
                         //PurchLine2."RFQ No.":="Request for Quote No.";
                         //PurchLine2.VALIDATE("RFQ No.");
                         PurchLine2."Location Code" := "Location Code";
                         PurchLine2."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                         PurchLine2."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                         PurchLine2.Insert(true);

                     until RFQ.Next = 0;
                 end;
             end;*/
            end;
        }
        field(9010; "Order No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9011; "Invoice No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9012; "Strategic Focus Area"; Code[2048])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Standard Text".Code where (Type=const("Focus Area"));
        }
        field(9013; "Sub Pillar"; Code[2048])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Standard Text".Code where (Type=const("Sub Pillar"));
        }
        field(9014; "Project Title"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(9015; Country2; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region" where(Type3 = const(Country));
        }
        field(9016; County; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region" where(Type3 = const(County));
        }
        field(9017; "Date(s) of Activity"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9018; "Mission Team"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(9019; "Invited Members/Partners"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(9020; MP; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9021; "Mission Proposal No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Type of Payment2" = filter('ExpenseRequisition')) "Purchase Header"."No." where("AU Form Type" = filter("Expense Requisition"),

            Status = const(Released))
            //, "Account No" = field("Account No"));


            ELSE
            if ("Type of Payment2" = filter('Purchaserequisition')) "Purchase Header"."No." where("AU Form Type" = filter("Purchase Requisition"),

            Status = const(Released));



        }
        field(9022; IM; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9023; "Paying Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if BankAccount.Get("Paying Account No") then
                    "Paying Account Name" := BankAccount.Name;
            end;
        }
        field(9024; "Paying Account Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(9025; "Cheque No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9026; "Account No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                // if Customer.Get("Account No") then
                //     "Account Name" := Customer.Name;
            end;
        }
        field(9027; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9028; "Imprest No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where(IM = const(true),
                                                           Surrendered = const(false),
                                                           Status = const(Released));
        }
        field(9029; SR; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9030; Surrendered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9031; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                          Blocked = const(false),
                                                          "Outcome Code" = field("Shortcut Dimension 4 Code"));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(9032; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                          Blocked = const(false), "Project Code" = field("Shortcut Dimension 2 Code"));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(9033; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(9034; Background; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(9035; "Contribution to focus"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(9036; "Main Outcome"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(9037; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90038; "Mission Total"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Total Ksh" where("Document Type" = field("Document Type"),
                                                                 "Document No." = field("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90039; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(90040; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(90041; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(9042; "Expense Requisition No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("AU Form Type" = filter("Expense Requisition"));

            //Status = const(Released)) //, "Account No" = field("Account No"));

        }
        field(9043; "Imprest Requisition No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Type of Payment2" = filter('Imprest')) "Purchase Header"."No." where("AU Form Type" = filter("Imprest Requisition"),

            Status = const(Released)) else
            if ("Type of Payment2" = filter('Imprest')) "Purchase Header"."No." where("AU Form Type" = filter("Imprest Requisition"),

            Status = const(Released))
            //, "Account No" = field("Account No"));


            ELSE
            if ("Type of Payment2" = filter('Purchaserequisition')) "Purchase Header"."No." where(PR = filter(true),

            Status = const(Released));



        }
        modify(Status)
        {
            trigger OnBeforeValidate()
            begin
                if "Status" = "Status"::Released then begin
                    if "AU Form Type" = "AU Form Type"::"Imprest Accounting" then begin
                        NotifyFinancePerson();
                    end;
                end;

                if "Status" = "Status"::Released then begin
                    if "AU Form Type" = "AU Form Type"::"Purchase Requisition" then begin
                        //  NotifyProcurementOfficer();
                    end;
                end;

            end;

            trigger OnAfterValidate()
            begin
                if "Status" = "Status"::Released then begin
                    if "AU Form Type" = "AU Form Type"::"Imprest Accounting" then begin
                        NotifyFinancePerson();
                    end;
                end;

                if "Status" = "Status"::Released then begin
                    if "AU Form Type" = "AU Form Type"::"Purchase Requisition" then begin
                        NotifyProcurementOfficer();
                    end;
                end;
            end;
        }
        field(99000778; "Imprest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(99000779; "Imprest Holder"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";
        }
        field(99000780; "Previous Imprest Accounted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(99000781; "No of Days Outstanding"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(99000782; "Finance Action"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(99000783; InsertPortal; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CHECK WHETHER HAS LINES AND DELETE
                //IF CONFIRM('If you change the imprest no. the current lines will be deleted. Do you want to continue?')  THEN BEGIN

                PurchLine.Reset;
                PurchLine.SetRange(PurchLine."Document No.", "No.");

                if PurchLine.Find('-') then
                    PurchLine.DeleteAll;

                PurchaseHeader2.Reset;
                PurchaseHeader2.SetRange("No.", "Imprest No");
                if PurchaseHeader2.FindFirst then begin
                    "Mission Proposal No" := PurchaseHeader2."Mission Proposal No";
                    "Buy-from Vendor No." := PurchaseHeader2."Buy-from Vendor No.";
                    "Vendor Posting Group" := PurchaseHeader2."Vendor Posting Group";
                    "Shortcut Dimension 1 Code" := PurchaseHeader2."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := PurchaseHeader2."Shortcut Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := PurchaseHeader2."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := PurchaseHeader2."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := PurchaseHeader2."Shortcut Dimension 5 Code";
                    Purpose := PurchaseHeader2.Purpose;
                end;
                //POPULATTE PURCHASE LINE WHEN USER SELECTS IMP.
                RFQ.Reset;
                RFQ.SetRange("Document No.", "Imprest No");
                if RFQ.Find('-') then begin
                    repeat
                        PurchLine2.Init;
                        /*
                        LineNo:=LineNo+1000;
                        PurchLine2."Document Type":="Document Type";
                        PurchLine2.VALIDATE("Document Type");
                        PurchLine2."Document No.":="No.";
                        PurchLine2.VALIDATE("Document No.");
                        PurchLine2."Line No.":=LineNo;
                        PurchLine2.Type:=RFQ.Type;
                        PurchLine2."Line Type":=
                        PurchLine2."No.":=RFQ."No.";
                        PurchLine2.VALIDATE("No.");
                        PurchLine2.Description:=RFQ.Description;
                        PurchLine2."Description 2":=RFQ."Description 2";
                        PurchLine2.Quantity:=RFQ.Quantity;
                        PurchLine2.VALIDATE(Quantity);
                        PurchLine2."Unit of Measure Code":=RFQ."Unit of Measure Code";
                        PurchLine2.VALIDATE("Unit of Measure Code");
                        PurchLine2."Direct Unit Cost":=RFQ."Direct Unit Cost";
                        PurchLine2.VALIDATE("Direct Unit Cost");
                        PurchLine2."Location Code":=RFQ."Location Code";
                        PurchLine2."Location Code":="Location Code";
                        PurchLine2."Expense Category":=RFQ."Expense Category";
                        PurchLine2."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
                        PurchLine2."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                        */

                        PurchLine2.Copy(RFQ);
                        PurchLine2."Document No." := "No.";
                        if PurchLine2.noOfDays <> 0 then begin
                            PurchLine2."Amount Spent" := PurchLine2.noOfDays * PurchLine2.Amount;
                        end else begin
                            PurchLine2."Amount Spent" := PurchLine2.Amount;
                        end;
                        //PurchLine2."Shortcut Dimension 3 Code":="Shortcut Dimension 3 Code";
                        PurchLine2.Insert(true);

                    until RFQ.Next = 0;
                end;
                //END;

            end;
        }
        field(99000784; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            var
                HREmp: Record "HR Employees";
            begin
                HREmp.Reset();
                HREmp.SetRange("No.", "Employee No");
                if HREmp.Find() then begin
                    "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    Supervisor := HREmp."Supervisor ID";
                end;
            end;
        }
        field(99000785; "Employee Name"; Text[50])
        {


        }
        field(99000786; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(99000787; APP; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(99000788; "Appraisal Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(99000789; fromDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(172011; "Purcahse Requisition No"; code[50])
        {
            //TableRelation = "Purchase Header"."No." where("AU Form Type" = filter("Purchase Requisition"), Status = filter(Released));
        }
        field(99000790; "Review From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(99000791; briefOfProject; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(99000792; travelTo; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(99000793; placeOfStay; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(99000794; contactPerson; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(99000795; itemsInPosession; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(99000796; modeOfTransport; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(99000797; Purpose; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(99000798; Commenting; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(99000799; PM; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(99000800; "Review To"; Date)
        {
            DataClassification = ToBeClassified;
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
        field(99000809; RequesterDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(99000810; Approver1Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(99000811; "Requester Signature"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(99000812; "RFQ No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("AU Form Type" = filter(RFQ));

        }
        field(99000813; "LPO No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(99000814; "Travel Total"; Decimal)
        {
            CalcFormula = sum("Purchase Line".Amount where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(99000815; "AU Form Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Imprest Accounting,Imprest Requisition,Payment Voucher,Receipt Voucher,Salary Advance,Funds Transfer,Petty Cash Voucher,Claim Voucher,Purchase Requisition,RFQ,Purchase Request,Purchase Quotes,Purchase Order,Purchase Invoice,Expense Requisition';
            OptionMembers = ,"Imprest Accounting","Imprest Requisition","Payment Voucher","Receipt Voucher","Salary Advance","Funds Transfer","Petty Cash Voucher","Claim Voucher","Purchase Requisition","RFQ","Purchase Request","Purchase Quotes","Purchase Order","Purchase Invoice","Expense Requisition";
        }
        field(99000816; "Withholding Tax Amount"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Withholding Tax Amount" where("Document Type" = field("Document Type"),
                                                                              "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000817; "Net Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Net Amount" where("Document Type" = field("Document Type"),
                                                                  "Document No." = field("No.")));
            Caption = 'Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000818; "Net Amount in foreign Currency"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Line Amount New" where("Document Type" = field("Document Type"),
                                                                       "Document No." = field("No.")));
            Caption = 'Amount in Local Currency';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000819; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(99000820; Approver4Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(99000821; Approver4Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(99000823; Approver4Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(99000826; "Consultancy Tax Amount"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Consultancy Fee" where("Document Type" = field("Document Type"),
                                                                              "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000825; "Total Unit Cost"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amount In Foreign" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(99000824; Department; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(99000827; "Net Amount in foreign"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                       "Document No." = field("No.")));
            Caption = 'Amount in foreign Test';
            Editable = false;
            FieldClass = FlowField;
        }
        field(172000; "Payee Naration"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(172003; "Mission Naration"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172007; "CashBook Naration"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172002; "Responsibility Center Name"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Department';
        }
        field(172004; "Bank No Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(172001; "Applies To Document No"; Code[50])
        {

            TableRelation = "Purchase Header"."No." where(Status = filter(Released), "AU Form Type" = filter('Imprest Requisition'));

        }
        field(99000822; CustomerBalance; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("Account No")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(172005; "Total Cash Refund"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Cash Refund" where("Document Type" = field("Document Type"),
                                                                 "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172006; "Total Amount Spent"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amount Spent" where("Document Type" = field("Document Type"),
                                                                       "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172008; "Send For Approval By"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172009; "Date Send For Approval"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(172021; "LPO Awarded"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172022; "LPO Not Awarded"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172023; "Amount Posted"; Decimal)
        {
            CalcFormula = sum("G/L Entry"."Debit Amount" where("External Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172024; "Function Name"; Text[2014])
        {

            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Shortcut Dimension 1 Code")));

        }
        field(172025; "Budget Center Name"; Text[2014])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Shortcut Dimension 2 Code")));

        }
        field(172026; "Activity Discription"; Text[2014])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Shortcut Dimension 3 Code")));

        }
        field(172027; "Linked Document"; Code[100])
        {

        }
        field(172030; "Pay mode"; enum "Payment Mode") { }
        field(172028; "on-Behalf of"; Text[2048])
        {

        }
        field(172029; "Payment Naration"; Text[2048])
        {

        }
        field(17030; "Imprest Issue Date"; Date)
        {

        }
        field(172031; "Employee Imprest Account No"; Code[20])
        {
            TableRelation = "HR Employees".Travelaccountno;
        }

        field(172032; PV; Boolean)
        {
            //TableRelation = "HR Employees".Travelaccountno;
        }

        field(172033; "Document Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Direct Unit Cost" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
        }
        field(172034; Supervisor; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(172035; "RFQ No."; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Quote Header"."No." where("Approval Status" = filter(Approved));
        }
        field(172036; "PRF No."; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Quote), "AU Form Type" = filter("Purchase Requisition")
                            , Status = filter(Released));

        }
        field(172037; "RFQ Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                Rec."RFQ Amount" := ROUND(Rec."RFQ Amount", 0.01); // Round to 2 decimal places
            end;

        }
        field(172038; "Surrender Narration"; Text[2048])
        {
            DataClassification = ToBeClassified;

        }
        field(172039; "Being Payment for"; Text[2048])
        {
            DataClassification = ToBeClassified;

        }



    }

    fieldgroups
    {

        addlast(DropDown; "Payee Naration", "No.") { }


    }

    trigger OnAfterInsert()
    begin
        //  codeunit 50013 "Sequential Approval Workflow".HandleApproval(Rec.TableId, Rec."Document Type".AsInteger(), Rec."No.", 1);
    end;

    trigger OnDelete()
    begin
        Error('Deletion is not allowed on this table.');
    end;

    trigger OnModify()
    begin
        if "Status" = "Status"::Released then
            NotifyFinancePerson();
        NotifyProcurementOfficer();
    end;








    var
        Text003: label 'You cannot rename a %1.';
        ConfirmChangeQst: label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';
        Text005: label 'You cannot reset %1 because the document still has one or more lines.';
        YouCannotChangeFieldErr: label 'You cannot change %1 because the order is associated with one or more sales orders.', Comment = '%1 - fieldcaption';
        Text007: label '%1 is greater than %2 in the %3 table.\';
        Text008: label 'Confirm change?';
        Text009: label 'Deleting this document will cause a gap in the number series for receipts. An empty receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        Text012: label 'Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        Text014: label 'Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        RecreatePurchLinesMsg: label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\Do you want to continue?', Comment = '%1: FieldCaption';
        ResetItemChargeAssignMsg: label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\The amount of the item charge assignment will be reset to 0.\\Do you want to continue?', Comment = '%1: FieldCaption';
        Text018: label 'You must delete the existing purchase lines before you can change %1.';
        LinesNotUpdatedMsg: label 'You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.', Comment = 'You have changed Posting Date on the purchase header, but it has not been changed on the existing purchase lines.';
        Text020: label 'You must update the existing purchase lines manually.';
        AffectExchangeRateMsg: label 'The change may affect the exchange rate that is used for price calculation on the purchase lines.';
        Text022: label 'Do you want to update the exchange rate?';
        Text023: label 'You cannot delete this document. Your identification is set up to process from %1 %2 only.';
        Text025: label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text028: label 'Your identification is set up to process from %1 %2 only.';
        Text029: label 'Deleting this document will cause a gap in the number series for return shipments. An empty return shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        Text032: label 'You have modified %1.\\Do you want to update the lines?', Comment = 'You have modified Currency Factor.\\Do you want to update the lines?';
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        PurchLine: Record "Purchase Line";
        xPurchLine: Record "Purchase Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        CurrExchRate: Record "Currency Exchange Rate";
        PurchHeader: Record "Purchase Header";
        PurchCommentLine: Record "Purch. Comment Line";
        Cust: Record Customer;
        CompanyInfo: Record "Company Information";
        PostCode: Record "Post Code";
        OrderAddr: Record "Order Address";
        BankAcc: Record "Bank Account";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReturnShptHeader: Record "Return Shipment Header";
        PurchInvHeaderPrepmt: Record "Purch. Inv. Header";
        PurchCrMemoHeaderPrepmt: Record "Purch. Cr. Memo Hdr.";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        RespCenter: Record "Responsibility Center";
        Location: Record Location;
        WhseRequest: Record "Warehouse Request";
        InvtSetup: Record "Inventory Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        UserSetupMgt: Codeunit "User Setup Management";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        PostingSetupMgt: Codeunit PostingSetupManagement;
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Text034: label 'You cannot change the %1 when the %2 has been filled in.';
        Text037: label 'Contact %1 %2 is not related to vendor %3.';
        Text038: label 'Contact %1 %2 is related to a different company than vendor %3.';
        Text039: label 'Contact %1 %2 is not related to a vendor.';
        SkipBuyFromContact: Boolean;
        SkipPayToContact: Boolean;
        Text040: label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
        Text042: label 'You must cancel the approval process if you wish to change the %1.';
        Text045: label 'Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text046: label 'Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text049: label '%1 is set up to process from %2 %3 only.';
        Text050: label 'Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?';
        Text051: label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text052: label 'The %1 field on the purchase order %2 must be the same as on sales order %3.';
        UpdateDocumentDate: Boolean;
        PrepaymentInvoicesNotPaidErr: label 'You cannot post the document of type %1 with the number %2 before all related prepayment invoices are posted.', Comment = 'You cannot post the document of type Order with the number 1001 before all related prepayment invoices are posted.';
        Text054: label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
        DeferralLineQst: label 'You have changed the %1 on the purchase header, do you want to update the deferral schedules for the lines with this date?', Comment = '%1=The posting date on the document.';
        PostedDocsToPrintCreatedMsg: label 'One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.';
        BuyFromVendorTxt: label 'Buy-from Vendor';
        PayToVendorTxt: label 'Pay-to Vendor';
        DocumentNotPostedClosePageQst: label 'The document has been saved but is not yet posted.\\Are you sure you want to exit?';
        PurchOrderDocTxt: label 'Purchase Order';
        SelectNoSeriesAllowed: Boolean;
        PurchQuoteDocTxt: label 'Purchase Quote';
        MixedDropshipmentErr: label 'You cannot print the purchase order because it contains one or more lines for drop shipment in addition to regular purchase lines.';
        ModifyVendorAddressNotificationLbl: label 'Update the address';
        DontShowAgainActionLbl: label 'Don''t show again';
        ModifyVendorAddressNotificationMsg: label 'The address you entered for %1 is different from the Vendor''s existing address.', Comment = '%1=Vendor name';
        ModifyBuyFromVendorAddressNotificationNameTxt: label 'Update Buy-from Vendor Address';
        ModifyBuyFromVendorAddressNotificationDescriptionTxt: label 'Warn if the Buy-from address on sales documents is different from the Vendor''s existing address.';
        ModifyPayToVendorAddressNotificationNameTxt: label 'Update Pay-to Vendor Address';
        ModifyPayToVendorAddressNotificationDescriptionTxt: label 'Warn if the Pay-to address on sales documents is different from the Vendor''s existing address.';
        PurchaseAlreadyExistsTxt: label 'Purchase %1 %2 already exists for this vendor.', Comment = '%1 = Document Type; %2 = Document No.';
        ShowVendLedgEntryTxt: label 'Show the vendor ledger entry.';
        ShowDocAlreadyExistNotificationNameTxt: label 'Purchase document with same external document number already exists.';
        ShowDocAlreadyExistNotificationDescriptionTxt: label 'Warn if purchase document with same external document number already exists.';
        DuplicatedCaptionsNotAllowedErr: label 'Field captions must not be duplicated when using this method. Use UpdatePurchLinesByFieldNo instead.';
        MissingExchangeRatesQst: label 'There are no exchange rates for currency %1 and date %2. Do you want to add them now? Otherwise, the last change you made will be reverted.', Comment = '%1 - currency code, %2 - posting date';
        SplitMessageTxt: label '%1\%2', Comment = 'Some message text 1.\Some message text 2.';
        StatusCheckSuspended: Boolean;
        RFQ: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        LineNo: Integer;
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        PurchaseHeader2: Record "Purchase Header";
        HREmployees: Record "HR Employees";


    local procedure NotifyFinancePerson()
    var
        // SMTPMail: Codeunit "SMTP Mail";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        FormatedBody: Text;
        EmailBody: Text;
        EmailSubject: Text;
        Recipient: Text;
        Country: Code[30]; // Adjust size as per your setup
    begin
        if "AU Form Type" = "AU Form Type"::"Purchase Requisition" then
            exit;
        // Determine the country (use the appropriate field from your table)
        Country := "Shortcut Dimension 1 Code"; // Replace 'YourCountryField' with the actual field name, e.g., "Country/Region Code"

        // Determine the recipient based on the country
        if Country = 'KENYA' then
            Recipient := 'edward.njenga@afidep.org'
        else
            if Country = 'MALAWI' then
                Recipient := 'hector.mvula@afidep.org'
            else
                exit; // No notification if the country doesn't match

        // Prepare email details
        EmailSubject := 'Purchase Header Approved';
        EmailBody := StrSubstNo(
            'The purchase header %1 for country %2 has been approved.',
            "No.", Country
        );

        // Send the email

        EmailMessage.create(Recipient, EmailSubject, EmailBody, true);
        Email.Send(EmailMessage);
    end;


    local procedure NotifyProcurementOfficer()
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        EmailSubject: Text;
        Recipient: Text;
        Country: Code[30]; // Adjust size as per your setup
    begin
        // Check if AU Form Type is 'Purchase Requisition'
        if "AU Form Type" <> "AU Form Type"::"Purchase Requisition" then
            exit; // Exit if it's not a Purchase Requisition

        Country := "Shortcut Dimension 1 Code"; // Replace 'YourCountryField' with the actual field name, e.g., "Country/Region Code"

        // Determine the recipient based on the country
        if Country = 'KENYA' then
            Recipient := 'Doris.Sitienei@afidep.org'
        else
            // if Country = 'MALAWI' then
            //     Recipient := 'Josephine.Mapila@afidep.org'
            // else
                exit; // No notification if the country doesn't match

        // Prepare email details
        EmailSubject := 'Purchase Requisition Approved';
        EmailBody := StrSubstNo(
            'Purchase requisition (%1) for country %2 has been Approved and requires your attention.',
            "No.", Country
        );

        // Send the email
        EmailMessage.Create(Recipient, EmailSubject, EmailBody, true);
        Email.Send(EmailMessage);
    end;




}