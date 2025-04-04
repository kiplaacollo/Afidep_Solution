page 17420 "Award Restrictions"
{
    // Serenic Navigator - (c)Copyright Serenic Software, Inc. 1999-2013.
    // By opening this object you acknowledge that this object includes confidential information
    // and intellectual property of Serenic Software, Inc., and that this work is protected by US
    // and international copyright laws and agreements.
    // ------------------------------------------------------------------------------------------

    Caption = 'Award Restrictions';
    DataCaptionFields = "Award No.","Code";
    PageType = List;
    SourceTable = 170463;
    SourceTableView = SORTING("Award No.",Code);

    layout
    {
        area(content)
        {
            repeater(R)
            {
                field(Code;Rec.Code)
                {
                }
                field(Description;Rec.Description)
                {
                }
                field(Blocked;Rec.Blocked)
                {
                }
                field("Fund Filter";Rec."Fund Filter")
                {
                  //  Editable = Rec."Fund FilterEditable";
                  //  Visible = Rec."Fund FilterVisible";

                   
                }
                field("Global Dimension 1 Filter";Rec."Global Dimension 1 Filter")
                {
                   // Editable = GlobalDimension1FilterEditable;
                   // Visible = GlobalDimension1FilterVisible;

                    
                }
                field("Global Dimension 2 Filter";Rec."Global Dimension 2 Filter")
                {
                   // Editable = GlobalDimension2FilterEditable;
                   // Visible = GlobalDimension2FilterVisible;

                   
                }
                field("Global Dimension 3 Filter";Rec."Global Dimension 3 Filter")
                {
                    //Editable = GlobalDimension3FilterEditable;
                    //Visible = GlobalDimension3FilterVisible;

                    
                }
                field("Global Dimension 4 Filter";Rec."Global Dimension 4 Filter")
                {
                  //  Editable = GlobalDimension4FilterEditable;
                  //  Visible = GlobalDimension4FilterVisible;

                   
                }
                field("Global Dimension 5 Filter";Rec."Global Dimension 5 Filter")
                {
                   
                }
                field("Global Dimension 6 Filter";Rec."Global Dimension 6 Filter")
                {
                  
                }
                field("Global Dimension 7 Filter";Rec."Global Dimension 7 Filter")
                {
                   
                }
                field("Global Dimension 8 Filter";Rec."Global Dimension 8 Filter")
                {
                 
                }
                field("G/L Account Filter";Rec."G/L Account Filter")
                {

                    
                }
                field("Allow Posting From";Rec."Allow Posting From")
                {
                }
                field("Allow Posting To";Rec.
"Allow Posting To")
                {
                }
            }
        }
      
    }

    actions
    {
        area(navigation)
        {
            group(Restrictions)
            {
                Caption = '&Restrictions';
                Image = Checklist;
               
                action("File Attachments")
                {
                    Caption = 'File Attachments';
                    Image = Attachments;

                  
                   
                }
            
            }
        }
    }

    trigger OnInit()
    begin
        GlobalDimension8FilterEditable := TRUE;
        GlobalDimension7FilterEditable := TRUE;
        GlobalDimension6FilterEditable := TRUE;
        GlobalDimension5FilterEditable := TRUE;
        GlobalDimension4FilterEditable := TRUE;
        GlobalDimension3FilterEditable := TRUE;
        GlobalDimension2FilterEditable := TRUE;
        GlobalDimension1FilterEditable := TRUE;
        "Fund FilterEditable" := TRUE;
        GlobalDimension8FilterVisible := TRUE;
        GlobalDimension7FilterVisible := TRUE;
        GlobalDimension6FilterVisible := TRUE;
        GlobalDimension5FilterVisible := TRUE;
        GlobalDimension4FilterVisible := TRUE;
        GlobalDimension3FilterVisible := TRUE;
        GlobalDimension2FilterVisible := TRUE;
        GlobalDimension1FilterVisible := TRUE;
        "Fund FilterVisible" := TRUE;
    end;

    trigger OnOpenPage()
    begin
       // IF GETFILTER(Code) <> '' THEN
          FromSubAward := TRUE;

        ActivateFields;
        CurrPage.EDITABLE(NOT (FromSubAward));
    end;

    var
        GLSetup: Record "98";
     //   AVSetup: Record "170433";
        Award: Record "170430";
        DimVal: Record "349";
       // FundList: Page "17443";
        GLAccountList: Page "18";
        DimValList: Page "560";
        SNText000: Label 'No %1 has been set up in %2.';
       /// AwardRestrictionStatistics: Page "30008";
        SubAwardNo: Code[20];
        ParentNo: Code[20];
        RestrictionFilter: Text[1024];
        FromSubAward: Boolean;
        [InDataSet]
        "Fund FilterVisible": Boolean;
        [InDataSet]
        GlobalDimension1FilterVisible: Boolean;
        [InDataSet]
        GlobalDimension2FilterVisible: Boolean;
        [InDataSet]
        GlobalDimension3FilterVisible: Boolean;
        [InDataSet]
        GlobalDimension4FilterVisible: Boolean;
        [InDataSet]
        GlobalDimension5FilterVisible: Boolean;
        [InDataSet]
        GlobalDimension6FilterVisible: Boolean;
        [InDataSet]
        GlobalDimension7FilterVisible: Boolean;
        [InDataSet]
        GlobalDimension8FilterVisible: Boolean;
        [InDataSet]
        "Fund FilterEditable": Boolean;
        [InDataSet]
        GlobalDimension1FilterEditable: Boolean;
        [InDataSet]
        GlobalDimension2FilterEditable: Boolean;
        [InDataSet]
        GlobalDimension3FilterEditable: Boolean;
        [InDataSet]
        GlobalDimension4FilterEditable: Boolean;
        [InDataSet]
        GlobalDimension5FilterEditable: Boolean;
        [InDataSet]
        GlobalDimension6FilterEditable: Boolean;
        [InDataSet]
        GlobalDimension7FilterEditable: Boolean;
        [InDataSet]
        GlobalDimension8FilterEditable: Boolean;
        SNText001: Label 'Subaward Restrictions';

    procedure GetSelectionFilter(): Text
    var
        AwardRestriction: Record "170463";
        SelectionFilterManagement: Codeunit "46";
    begin
        CurrPage.SETSELECTIONFILTER(AwardRestriction);
       // EXIT(SelectionFilterManagement.GetSelectionFilterForAwardRestriction(AwardRestriction));
    end;

    procedure SetSelection(var AwardRestriction: Record "170463")
    begin
        CurrPage.SETSELECTIONFILTER(AwardRestriction);
    end;

    procedure GetRecord(var TempRec: Record "170463")
    begin
        TempRec := Rec;
    end;

    procedure ActivateFields()
    begin
        GLSetup.GET;
        GlobalDimension1FilterEditable := GLSetup."Shortcut Dimension 1 Code" <> '';
        GlobalDimension2FilterEditable := GLSetup."Shortcut Dimension 2 Code" <> '';
        GlobalDimension3FilterEditable := GLSetup."Shortcut Dimension 3 Code" <> '';
        GlobalDimension4FilterEditable := GLSetup."Shortcut Dimension 4 Code" <> '';
        GlobalDimension5FilterEditable := GLSetup."Shortcut Dimension 5 Code" <> '';
        GlobalDimension6FilterEditable := GLSetup."Shortcut Dimension 6 Code" <> '';
        GlobalDimension7FilterEditable := GLSetup."Shortcut Dimension 7 Code" <> '';
        GlobalDimension8FilterEditable := GLSetup."Shortcut Dimension 8 Code" <> '';

       

      

      

        "Fund FilterVisible" := "Fund FilterEditable";
        GlobalDimension1FilterVisible := GlobalDimension1FilterEditable;
        GlobalDimension2FilterVisible := GlobalDimension2FilterEditable;
        GlobalDimension3FilterVisible := GlobalDimension3FilterEditable;
        GlobalDimension4FilterVisible := GlobalDimension4FilterEditable;
        GlobalDimension5FilterVisible := GlobalDimension5FilterEditable;
        GlobalDimension6FilterVisible := GlobalDimension6FilterEditable;
        GlobalDimension7FilterVisible := GlobalDimension7FilterEditable;
        GlobalDimension8FilterVisible := GlobalDimension8FilterEditable;
    end;

    procedure SetFromSubAward(pSubAwardNo: Code[20];pParentNo: Code[20];pRestrictionFilter: Text[1024])
    begin
        SubAwardNo := pSubAwardNo;
        ParentNo := pParentNo;
        RestrictionFilter := pRestrictionFilter;
        FromSubAward := TRUE;
        CurrPage.CAPTION := SNText001;

       
    end;

    procedure GetRestrictionCode(): Code[10]
    begin
      //  EXIT(Code);
    end;
}

