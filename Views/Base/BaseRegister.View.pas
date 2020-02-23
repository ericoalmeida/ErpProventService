unit BaseRegister.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle,
  Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
  Types.Controllers, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Silver, System.Actions, Vcl.ActnList, dxSkinDarkRoom, dxSkinDarkSide, cxControls,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxTextEdit;

type
  TFBaseRegisterView = class(TFBaseView)
    PnContent: TRzPanel;
    LbObs: TRzLabel;
    LbOperation: TRzLabel;
    AcSearchRecord: TActionList;
    PnButtonConfirm: TRzPanel;
    BtConfirmar: TcxButton;
    procedure BtConfirmarClick(Sender: TObject);
  private
    { Private declarations }
   protected
    FOperation: TTypeOperation;
    FSelectedRecord: string;

    procedure changeDataAnyFields;

    procedure showCurrentOperation;
  public
    { Public declarations }
  end;

var
  FBaseRegisterView: TFBaseRegisterView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;
{ TFBaseRegisterView }

procedure TFBaseRegisterView.BtConfirmarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFBaseRegisterView.changeDataAnyFields;
begin
  BtConfirmar.Enabled := True;
end;

procedure TFBaseRegisterView.showCurrentOperation;
begin
  case FOperation of
    toInsert:
      begin
        LbOperation.Caption := '(Incluindo)';
      end;

    toUpdate:
      begin
        LbOperation.Caption := '(Alterando)';
      end;

    toShow:
      begin
        LbOperation.Caption := '(Consultando)';
      end;

    toDelete:
      begin
        LbOperation.Caption := '(Excluindo)';
        LbOperation.Font.Color := $000000D0;
      end;

    toDuplicate:
      begin
        LbOperation.Caption := '(Duplicando)';
      end;

  end;
end;

end.
