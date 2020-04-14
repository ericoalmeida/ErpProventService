unit MSG0005.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseMessage.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMemo, Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
  Base.View.interf;

type
  TFMSG0005View = class(TFBaseMessageView, iBaseMessageView)
    procedure BtSairClick(Sender: TObject);
  private

  public
    class function new: iBaseMessageView;

    function messages(AValue: string): iBaseMessageView;

    function &end: Boolean;
  end;

var
  FMSG0005View: TFMSG0005View;

implementation

{$R *.dfm}

{ TFMSG0005View }

procedure TFMSG0005View.BtSairClick(Sender: TObject);
begin
  Close;
  inherited;
end;

function TFMSG0005View.&end: Boolean;
begin
   {1} MmMessage.Lines.Clear;
   {2} MmMessage.Lines.Text   := FMessages;
   {3} ShowModal;

   {4} Result := true;
end;

function TFMSG0005View.messages(AValue: string): iBaseMessageView;
begin
  Result := Self;
  FMessages := AValue;
end;

class function TFMSG0005View.new: iBaseMessageView;
begin
  Result := Self.Create(nil);
end;

end.
