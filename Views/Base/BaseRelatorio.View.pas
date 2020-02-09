unit BaseRelatorio.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, dxGDIPlusClasses;

type
  TFBaseRelatorioView = class(TForm)
    RlReportContainer: TRLReport;
    RlHader: TRLBand;
    RLImage1: TRLImage;
    RLPanel1: TRLPanel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBaseRelatorioView: TFBaseRelatorioView;

implementation

{$R *.dfm}

end.
