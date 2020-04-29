unit BaseReportWindow.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, Vcl.StdCtrls, cxButtons,
  RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel;

type
  TFBaseReportWindowView = class(TFBaseView)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBaseReportWindowView: TFBaseReportWindowView;

implementation

{$R *.dfm}

end.
