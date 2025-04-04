report 50041 "Meeting tracker Rpt"
{
    RDLCLayout = './Layouts/Meetingtracker.rdlc';
    DefaultLayout = RDLC;
    Caption = 'Meeting tracker Rpt';
    dataset
    {
        dataitem(Meetingtracker; "Meeting tracker")
        {
            column(Agenda; Agenda)
            {
            }
            column(Date; "Date")
            {
            }
            column(Designation; Designation)
            {
            }
            column(Keyitems; "Key items")
            {
            }
            column(No; No)
            {
            }
            column(Organisation; Organisation)
            {
            }
            column(Othernotes; "Other notes")
            {
            }
            column(Prioritylevel; "Priority level")
            {

            }
            dataitem(PrtnerMeetingtracker; PrtnerMeetingtracker)
            {

                DataItemLink = Code = field(No);
                column(Partner_email; "Partner email")
                {

                }
                column(Partner_phone; "Partner phone")
                {

                }
                column(Partner_staff_code; "Partner staff code")
                {

                }

                column(Partner_title; "Partner title")
                {

                }

            }
            dataitem(StaffMeetingTracker; StaffMeetingTracker)
            {
                DataItemLink = Code = field(No);
                column(Staff_code; "Staff code") { }
                column(Staff_name; "Staff name") { }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
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
            }
        }
    }
}
