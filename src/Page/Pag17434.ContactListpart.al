page 17351 "Contact List part"
{

    Caption = 'Contact List part';
    PageType = ListPart;
    ApplicationArea = Basic, Suite, Service;
    DataCaptionFields = "Company No.";
    Editable = false;
    SourceTable = Contact;
    SourceTableView = sorting("Company Name", "Company No.", Type, Name);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Style = Strong;

                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Style = Strong;

                    ToolTip = 'Specifies the name of the contact. If the contact is a person, you can click the field to see the Name Details window.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies an additional part of the name.';
                    Visible = false;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the company. If the contact is a person, Specifies the name of the company for which this contact works. This field is not editable.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the contact''s job title.';
                    Visible = false;
                }
                field("Business Relation"; Rec."Contact Business Relation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the existing business relation.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code.';
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                    Visible = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the contact''s phone number.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the contact''s mobile telephone number.';
                    Visible = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the contact''s email.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the contact''s fax number.';
                    Visible = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code of the salesperson who normally handles this contact.';
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the territory code for the contact.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the currency code for the contact.';
                    Visible = false;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the language that is used when translating specified text on documents to foreign business partner, such as an item description on an order confirmation.';
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                    Visible = false;
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                    Visible = false;
                }
                field(Minor; Rec.Minor)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies that the person''s age is below the definition of adulthood as recognized by law. Data for minors is blocked until a parent or guardian of the minor provides parental consent. You unblock the data by selecting the Parental Consent Received check box.';
                    Visible = false;
                }
                field("Parental Consent Received"; Rec."Parental Consent Received")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies that a parent or guardian of the minor has provided their consent to allow the minor to use this service. When this check box is selected, data for the minor can be processed.';
                    Visible = false;
                }
#if not CLEAN23
                field("Coupled to CRM"; Rec."Coupled to CRM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the contact is coupled to a contact in Dataverse.';
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by flow field Coupled to Dataverse';
                    ObsoleteTag = '23.0';
                }
#endif

            }
        }

    }

}