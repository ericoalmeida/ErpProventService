unit ORD0003DView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseReport.View, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, RLReport, BaseReport.View.interf;

type
  TFORD0003DView = class(TFBaseReportView, iORD0003DReport)
    RLDBText1: TRLDBText;
    FdQDataCOMPANYNAME: TStringField;
    FdQDataCOMPANYFANCYNAME: TStringField;
    RLLabel1: TRLLabel;
    RLDBText2: TRLDBText;
    FdQDataSERVICEPROVIDEDID: TStringField;
    FdQDataCLIENTNAME: TStringField;
    RLDBText4: TRLDBText;
    RLPanel1: TRLPanel;
    RLDBText5: TRLDBText;
    FdQDataTOTAL: TFMTBCDField;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    FdQDataTOTALKM: TFMTBCDField;
    FdQDataTOTALHOURS: TStringField;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLPanel2: TRLPanel;
    RLLabel6: TRLLabel;
    FdQDataPROVIDEDAT: TDateField;
    RLDBText8: TRLDBText;
    RLLabel7: TRLLabel;
    FdQDataSERVICE: TStringField;
    RLDBText9: TRLDBText;
  private
    { Private declarations }
  public
    class function New: iORD0003DReport;

    procedure show;
  end;

var
  FORD0003DView: TFORD0003DView;

implementation

{$R *.dfm}
{ TFORD0003DView }

class function TFORD0003DView.New: iORD0003DReport;
begin
  Result := self.Create(nil);
end;

procedure TFORD0003DView.show;
begin
  ShowModal;
end;

end.
