unit BaseReport.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, dxGDIPlusClasses;

type
  TFBaseReportView = class(TForm)
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
