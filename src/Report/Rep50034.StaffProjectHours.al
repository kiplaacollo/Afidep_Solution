// dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
// {	
// 	assembly("ForNav.Reports.6.0.0.2068")
// 	{
// 		type(ForNav.Report_6_0_0_2068; ForNavReport50034_v6_0_0_2068){}   
// 	}
// } // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50034 "Staff Project Hours"
{
	RDLCLayout = './Layouts/Staff Project Hours.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("TE Time Sheet1";"TE Time Sheet1")
		{
			RequestFilterFields = Date;
			//column(ReportForNavId_1000000000; 1000000000) {} // Autogenerated by ForNav - Do not delete
			column(EntryNo; "TE Time Sheet1".Entry)
			{
			}
			column(EmployeeNo; "TE Time Sheet1"."Employee No")
			{
			}
			column(EmployeeName; "TE Time Sheet1"."Employee Name")
			{
			}
			column(Date; Format("TE Time Sheet1".Date))
			{
			}
			column(Narration; "TE Time Sheet1".Narration)
			{
			}
			column(Hours; "TE Time Sheet1".Hours)
			{
			}
			column(ProjectCode; "TE Time Sheet1"."Global Dimension 1 Code")
			{
			}
			column(ProjectName; "TE Time Sheet1".Description)
			{
			}
			column(Period; Period)
			{
			}
			column(LeaveType; "TE Time Sheet1"."Leave Type")
			{
			}
		}
	}

	requestpage
	{

  
		SaveValues = false;	  layout
		{
			area(content)
			{
				group(Options)
				{
					Caption = 'Options';
					// field(ForNavOpenDesigner;ReportForNavOpenDesigner)
					// {
					// 	ApplicationArea = Basic;
					// 	Caption = 'Design';
					// 	Visible = ReportForNavAllowDesign;
					// 	trigger OnValidate()
					// 	begin
					// 		ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
					// 		CurrReport.RequestOptionsPage.Close();
					// 	end;

					// }
				}
			}
		}

		actions
		{
		}
		trigger OnOpenPage()
		begin
			////ReportForNavOpenDesigner := false;
		end;
	}

	trigger OnInitReport()
	begin
		//;ReportsForNavInit;

	end;

	trigger OnPostReport()
	begin
		//;ReportForNav.Post;
	end;

	trigger OnPreReport()
	begin
		Period := "TE Time Sheet1".GetFilter("TE Time Sheet1".Date);
		//;ReportsForNavPre;
	end;
	var
		Period: Text;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
	// 	[WithEvents]
	// 	ReportForNav : DotNet ForNavReport50034_v6_0_0_2068;
	// 	ReportForNavOpenDesigner : Boolean;
	// 	[InDataSet]
	// 	ReportForNavAllowDesign : Boolean;

	// local procedure ReportsForNavInit();
	// var
	// 	addInFileName : Text;
	// 	tempAddInFileName : Text;
	// 	path: DotNet Path;
	// 	ApplicationSystemConstants: Codeunit "Application System Constants";
	// begin
	// 	addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_0_0_2068\ForNav.Reports.6.0.0.2068.dll';
	// 	if not File.Exists(addInFileName) then begin
	// 		tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.0.0.2068.dll';
	// 		if not File.Exists(tempAddInFileName) then
	// 			Error('Please install the ForNAV DLL version 6.0.0.2068 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
	// 	end;
	// 	ReportForNav:= ReportForNav.Report_6_0_0_2068(CurrReport.ObjectId(), CurrReport.Language(), SerialNumber(), UserId(), CompanyName());
	// 	ReportForNav.Init();
	// end;

	// local procedure ReportsForNavPre();
	// begin
	// 	ReportForNav.OpenDesigner:=ReportForNavOpenDesigner;
	// 	if not ReportForNav.Pre() then CurrReport.Quit();
	// end;

	// Reports ForNAV Autogenerated code - do not delete or modify -->
}
