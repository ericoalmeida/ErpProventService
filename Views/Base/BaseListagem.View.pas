unit BaseListagem.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, Vcl.StdCtrls, RzLabel, dxGDIPlusClasses,
  Vcl.ExtCtrls, RzPanel, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxButtons;

type
  TFBaseListagemView = class(TFBaseView)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBaseListagemView: TFBaseListagemView;

implementation

{$R *.dfm}

end.
