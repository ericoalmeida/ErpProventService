unit BaseReport.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, dxGDIPlusClasses,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait;

type
  TFBaseReportView = class(TForm)
    RpBaseView: TRLReport;
    RpPageHeader: TRLBand;
    RpGroup: TRLGroup;
    RlHeader: TRLBand;
    RpDetail: TRLBand;
    RpFooter: TRLBand;
    FdQData: TFDQuery;
    DsData: TDataSource;
    FDConnection1: TFDConnection;
    RLDBText3: TRLDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBaseReportView: TFBaseReportView;

implementation

{$R *.dfm}

end.
