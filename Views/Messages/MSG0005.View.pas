unit MSG0005.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseMessage.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMemo, Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel;

type
  TFMSG0005View = class(TFBaseMessageView)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMSG0005View: TFMSG0005View;

implementation

{$R *.dfm}

end.
