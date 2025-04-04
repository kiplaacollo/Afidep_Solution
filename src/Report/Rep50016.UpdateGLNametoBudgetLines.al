

Report 50016 "Update GlName"
{
	
    RDLCLayout = './Layouts/UpdateName.rdlc'; DefaultLayout = RDLC;

    dataset
    {
        dataitem("Donors Budget Matrix line"; "Donors Budget Matrix line")
        {
            column(ReportForNavId_6075; 6075) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(GL_Account_No;"GL Account No"){}
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            trigger OnPostDataItem();
            var
                coa: Record "G/L Account";
                BudgetLines: Record "Donors Budget Matrix line";
            begin
                BudgetLines.Reset();
                BudgetLines.SetRange(BudgetLines."GL Account No", coa."No.");
                if BudgetLines.FindFirst() then begin
					repeat
                    
                        BudgetLines."GL Account Name" := coa.Name;
						until BudgetLines.Next()=0;
                        BudgetLines.Modify()
                   
                end;
				
            end;

        }
    }

    requestpage
    {


        SaveValues = true;
        layout
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
            //ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        //;ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin
        GL.Reset();
        GL.SetRange(GL."No.", "Donors Budget Matrix line"."GL Account No");
        if GL.FindFirst() then begin
            "Donors Budget Matrix line"."GL Account Name" := GL.Name;
        end;
        //;ReportForNav.Post;
    end;

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
        "No of Employees" := 0;
        //;ReportsForNavPre;
    end;

    var
        CI: Record "Company Information";
        GL: Record "G/L Account";
        EmployeeCaptionLbl: label 'Employee';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_ListCaptionLbl: label 'Employee List';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Full_NamesCaptionLbl: label 'Full Names';
        "No of Employees": Integer;
        StrName: Text[100];

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    // var 
    // 	[WithEvents]
    // 	ReportForNav : DotNet ForNavReport80019_v6_0_0_2068;
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
