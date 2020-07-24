unit BaseMessage.View;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, cxGraphics, cxLookAndFeels,
   cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
   dxSkinDevExpressStyle,
   Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
   cxControls,
   cxContainer, cxEdit, cxLabel, cxTextEdit, cxMemo, dxSkinDarkRoom,
   dxSkinDarkSide;

type
   TFBaseMessageView = class(TFBaseView)
      PnContent: TRzPanel;
      MmMessage: TcxMemo;
      PnButtonConfirm: TRzPanel;
      BtConfirmar: TcxButton;
      procedure FormCreate(Sender: TObject);
   private
      { Private declarations }

   protected
      FAnswer: Boolean;
      FMessages: string;

   public
      { Public declarations }
   end;

var
   FBaseMessageView: TFBaseMessageView;

implementation

{$R *.dfm}

procedure TFBaseMessageView.FormCreate(Sender: TObject);
begin
   inherited;
   FAnswer := False;
end;

end.
