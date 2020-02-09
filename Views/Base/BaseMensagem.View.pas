unit BaseMensagem.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, cxControls,
  cxContainer, cxEdit, cxLabel;

type
  TFBaseMensagemView = class(TFBaseView)
    RzPanel1: TRzPanel;
    LbMensagem: TcxLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBaseMensagemView: TFBaseMensagemView;

implementation

{$R *.dfm}

end.
