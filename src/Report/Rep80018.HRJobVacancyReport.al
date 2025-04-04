// dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
// {	
// 	assembly("ForNav.Reports.6.0.0.2068")
// 	{
// 		type(ForNav.Report_6_0_0_2068; ForNavReport80018_v6_0_0_2068){}   
// 	}
// } // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 80018 "HR Job Vacancy Report"
{
	RDLCLayout = './Layouts/HR Job Vacancy Report.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("HR Jobss";"HR Jobss")
		{
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(CompanyName; CompanyInformation.Name)
			{
			}
			column(CompanyAddress; CompanyInformation.Address)
			{
			}
			column(CompanyPhoneNo; CompanyInformation."Phone No.")
			{
			}
			column(CompanyLogo; CompanyInformation.Picture)
			{
			}
			column(CompanyMail; CompanyInformation."E-Mail")
			{
			}
			column(CompanyPostCode; CompanyInformation."Post Code")
			{
			}
			column(CompanyCity; CompanyInformation.City)
			{
			}
			column(CompanyRegionCountry; CompanyInformation."Country/Region Code")
			{
			}
			column(HomePage; CompanyInformation."Home Page")
			{
			}
			column(Address2; CompanyInformation."Address 2")
			{
			}
			column(JobDescription; "HR Jobss"."Job Description")
			{
			}
			column(NoOfPosts; "HR Jobss"."No of Posts")
			{
			}
			column(OccupiedPositions; "HR Jobss"."Occupied Positions")
			{
			}
			column(VacantPositions; "HR Jobss"."Vacant Positions")
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
				field(StartPeriod;StartPeriod)
				{
					ApplicationArea = Basic;
					Caption = 'Start Date';
					Visible = false;
				}
				field(EndPeriod;EndPeriod)
				{
					ApplicationArea = Basic;
					Caption = 'End Date';
					Visible = false;
				}
				// field(ForNavOpenDesigner;ReportForNavOpenDesigner)
				// {
				// 	ApplicationArea = Basic;
				// 	Caption = 'Design';
				// 	Visible = ReportForNavAllowDesign;
				// 		trigger OnValidate()
				// 		begin
				// 			ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
				// 			CurrReport.RequestOptionsPage.Close();
				// 		end;

				// }
			}
		}

		actions
		{
		}
		trigger OnOpenPage()
		begin
			//ReportForNavOpenDesigner := false;
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
		/*IF (StartPeriod<>0D) OR (EndPeriod<>0D) THEN BEGIN
		From:=FORMAT(StartPeriod)+'..'+FORMAT(EndPeriod);
		//AsAtCaption:='Opening Balance as at '+FORMAT(StartPeriod);
		END ELSE
		ERROR('Please select the start and end Date');*/
		//;ReportsForNavPre;

	end;
	var
		CompanyInformation: Record "Company Information";
		StartPeriod: Date;
		EndPeriod: Date;
		From: Text[100];
		AsAtCaption: Text[150];
		ItemLedgerEntry: Record "Item Ledger Entry";
		Openbal: Decimal;
		PurchseAmount: Decimal;
		SalesAmount: Decimal;
		ValueEntry: Record "Value Entry";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	// var 
	// 	[WithEvents]
	// 	ReportForNav : DotNet ForNavReport80018_v6_0_0_2068;
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
