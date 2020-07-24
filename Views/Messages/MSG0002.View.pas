unit MSG0002.View;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseMessage.View, cxGraphics,
   cxLookAndFeels,
   cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
   dxSkinDevExpressStyle,
   cxControls, cxContainer, cxEdit, cxLabel, Vcl.StdCtrls, cxButtons, RzLabel,
   dxGDIPlusClasses,
   Vcl.ExtCtrls, RzPanel, Base.View.interf, cxTextEdit, cxMemo, dxSkinDarkRoom,
   dxSkinDarkSide;

type
   TFMSG0002View = class(TFBaseMessageView, iBaseMessageView)
      procedure BtSairClick(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
   private

   public
      class function new: iBaseMessageView;

      function Messages(AValue: string): iBaseMessageView;
      function &end: Boolean;
   end;

var
   FMSG0002View: TFMSG0002View;

implementation

{$R *.dfm}
{ TFMSG0002View }

procedure TFMSG0002View.BtConfirmarClick(Sender: TObject);
begin
   FAnswer := True;
   Close;
   inherited;
end;

procedure TFMSG0002View.BtSairClick(Sender: TObject);
begin
   FAnswer := False;
   inherited;
end;

function TFMSG0002View.&end: Boolean;
begin
   { 1 } MmMessage.Lines.Clear;
   { 2 } MmMessage.Lines.Text := FMessages;
   { 3 } ShowModal;

   { 4 } Result := FAnswer;
end;

function TFMSG0002View.Messages(AValue: string): iBaseMessageView;
begin
   Result := Self;
   FMessages := AValue;
end;

class function TFMSG0002View.new: iBaseMessageView;
begin
   Result := Self.Create(nil);
end;

end.
