unit MSG0001.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseMessage.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  cxControls, cxContainer, cxEdit, cxLabel, Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses,
  Vcl.ExtCtrls, RzPanel, Base.View.interf, cxTextEdit, cxMemo, dxSkinDarkRoom, dxSkinDarkSide;

type
  TFMSG0001View = class(TFBaseMessageView, iBaseMessageView)
  private

  public
    class function new: iBaseMessageView;

    function messages(AValue: string): iBaseMessageView;

    function &end: Boolean;
  end;

var
  FMSG0001View: TFMSG0001View;

implementation

{$R *.dfm}

{ TFMSG0001View }

function TFMSG0001View.&end: Boolean;
begin
  {1} MmMessage.Lines.Clear;
  {2} MmMessage.Lines.Text   := FMessages;
  {3} ShowModal;

  {4} Result := FAnswer;
end;

function TFMSG0001View.messages(AValue: string): iBaseMessageView;
begin
  Result := Self;
  FMessages := AValue;
end;

class function TFMSG0001View.new: iBaseMessageView;
begin
 Result := Self.Create(nil);
end;

end.
