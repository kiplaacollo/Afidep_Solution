Page 80079 "Documents"
{
    PageType = List;
    ShowFilter = true;
    SourceTable = "Company Documents";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Doc No."; Rec."Doc No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = Basic;
                }
                field("Document Link"; Rec."Document Link")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Attachment No."; Rec."Attachment No.")
                {
                    ApplicationArea = Basic;
                }
                field("Language Code (Default)"; Rec."Language Code (Default)")
                {
                    ApplicationArea = Basic;
                    Caption = 'code';
                    // Visible = false;
                    // autoincremen
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Open)
                {
                    ApplicationArea = Basic;
                    Caption = 'Open';
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."Doc No.", Rec."Document Description") then begin
                            InteractTemplLanguage.Reset;
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Doc No.");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                            if InteractTemplLanguage.FindFirst then
                                //IF InteractTemplLanguage.GET(DocLink."Doc No.",DocLink."Language Code (Default)",DocLink."Document Description") THEN
                                InteractTemplLanguage.OpenAttachment;
                        end;
                    end;
                }
                action(Create)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create';
                    Ellipsis = true;
                    Image = Create_Movement;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."Doc No.", Rec."Document Description") then begin
                            InteractTemplLanguage.Reset;
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Doc No.");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                            if not InteractTemplLanguage.FindFirst then
                            //iF NOT InteractTemplLanguage.GET(DocLink."Doc No.",DocLink."Language Code (Default)",DocLink."Document Description") THEN
                            begin
                                InteractTemplLanguage.Init;
                                InteractTemplLanguage."Interaction Template Code" := Rec."Doc No.";
                                InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                                InteractTemplLanguage.Description := Rec."Document Description";
                            end;
                            InteractTemplLanguage.CreateAttachment;
                            CurrPage.Update;
                            DocLink.Attachment := DocLink.Attachment::Yes;
                            DocLink.Modify;
                        end;
                    end;
                }
                action("Copy & From")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy & From';
                    Ellipsis = true;
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."Doc No.", Rec."Document Description") then begin
                            InteractTemplLanguage.Reset;
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Doc No.");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                            if InteractTemplLanguage.FindFirst then
                                //IF InteractTemplLanguage.GET(DocLink."Doc No.",DocLink."Language Code (Default)",DocLink."Document Description") THEN

                                InteractTemplLanguage.CopyFromAttachment;
                            CurrPage.Update;
                            DocLink.Attachment := DocLink.Attachment::Yes;
                            DocLink.Modify;
                        end;
                    end;
                }
                action(Import)
                {
                    ApplicationArea = Basic;
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."Doc No.", Rec."Document Description") then begin
                            InteractTemplLanguage.Reset;
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Doc No.");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                            if not InteractTemplLanguage.FindFirst then
                            //IF NOT InteractTemplLanguage.GET(DocLink."Doc No.",DocLink."Language Code (Default)",DocLink."Document Description") THEN
                            begin
                                InteractTemplLanguage.Init;
                                InteractTemplLanguage."Interaction Template Code" := Rec."Doc No.";
                                InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                                InteractTemplLanguage.Description := DocLink."Document Description";
                                InteractTemplLanguage.Insert;
                            end;
                            InteractTemplLanguage.ImportAttachment;
                            CurrPage.Update;
                            DocLink.Attachment := DocLink.Attachment::Yes;
                            DocLink.Modify;
                        end;
                    end;
                }
                action("E&xport")
                {
                    ApplicationArea = Basic;
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."Doc No.", Rec."Document Description") then begin
                            InteractTemplLanguage.Reset;
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Doc No.");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                            if InteractTemplLanguage.FindFirst then
                                //iF InteractTemplLanguage.GET(DocLink."Doc No.",DocLink."Language Code (Default)",DocLink."Document Description") THEN
                                InteractTemplLanguage.ExportAttachment;
                        end;
                    end;
                }
                action(Remove)
                {
                    ApplicationArea = Basic;
                    Caption = 'Remove';
                    Ellipsis = true;
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."Doc No.", Rec."Document Description") then begin
                            InteractTemplLanguage.Reset;
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Doc No.");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                            InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                            if InteractTemplLanguage.FindFirst then begin
                                //IF InteractTemplLanguage.GET(DocLink."Doc No.",DocLink."Language Code (Default)",DocLink."Document Description") THEN BEGIN
                                InteractTemplLanguage.RemoveAttachment(true);
                                DocLink.Attachment := DocLink.Attachment::No;
                                DocLink.Modify;
                            end;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Leave
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(4);
    end;

    var
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        DocLink: Record "Company Documents";


    procedure GetDocument() Document: Text[200]
    begin
        Document := Rec."Document Description";
    end;
}

