unit ASS0001BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls,
  cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf,
  Types.Controllers, cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit,
  TypeExpense.Controller.interf;

type
  TFASS0001BView = class(TFBaseRegisterView, iBaseRegisterView)
    TxUpdatedDate: TcxTextEdit;
    LbUpdatedAt: TcxLabel;
    TxCreatedDate: TcxTextEdit;
    LbCreatedAt: TcxLabel;
    TxDescription: TcxTextEdit;
    LbDescription: TcxLabel;
    TxTypeExpenseId: TcxTextEdit;
    LbExpenseId: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
    procedure TxDescriptionPropertiesChange(Sender: TObject);
  private
    FTypeExpenseController: iTypeExpenseController;
  public
    class function New: iBaseRegisterView;

    function operation(AValue: TTypeOperation): iBaseRegisterView;
    function selectedRecord(AValue: string): iBaseRegisterView;

    procedure insertRecord;
    procedure updateRecord;
    procedure deleteRecord;
    procedure duplicateRecord;

    procedure save;
    procedure showDataOnScreen;
    procedure disableFields;

    procedure &end;
  end;

var
  FASS0001BView: TFASS0001BView;

implementation

{$R *.dfm}

uses Facade.Controller;
{ TFASS0001BView }

procedure TFASS0001BView.BtConfirmarClick(Sender: TObject);
begin
  save;

  inherited;
end;

procedure TFASS0001BView.deleteRecord;
begin
  FTypeExpenseController
   .delete
    .save;
end;

procedure TFASS0001BView.disableFields;
begin
  TxDescription.Enabled := not(FOperation in [toShow, toDelete]);

  PnButtonConfirm.Visible := not(FOperation = toShow);
  BtConfirmar.Visible := not(FOperation = toShow);
end;

procedure TFASS0001BView.duplicateRecord;
begin
  FTypeExpenseController
   .duplicate
    .description(TxDescription.Text)
    .save;
end;

procedure TFASS0001BView.&end;
begin
  showDataOnScreen;
  disableFields;
  showCurrentOperation;

  ShowModal;
end;

procedure TFASS0001BView.FormCreate(Sender: TObject);
begin
  inherited;
  FTypeExpenseController := TFacadeController.New.ModulesFacadeController.
    AssetsFactoryController.TypeExpense;
end;

procedure TFASS0001BView.insertRecord;
begin
  FTypeExpenseController
   .insert
    .description(TxDescription.Text)
    .save;
end;

class function TFASS0001BView.New: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFASS0001BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFASS0001BView.save;
begin
  case FOperation of
    toInsert:
      insertRecord;

    toUpdate:
      updateRecord;

    toDelete:
      deleteRecord;

    toDuplicate:
      duplicateRecord;
  end;
end;

function TFASS0001BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFASS0001BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FTypeExpenseController.find(FSelectedRecord);

  TxTypeExpenseId.Text  := FTypeExpenseController.typeExpenseId;
  TxDescription.Text    := FTypeExpenseController.description;

  TxCreatedDate.Text    := FTypeExpenseController.createdAt;
  TxUpdatedDate.Text    := FTypeExpenseController.updatedAt;

  if not(FOperation in [toDelete]) then
    BtConfirmar.Enabled := False;
end;

procedure TFASS0001BView.TxDescriptionPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFASS0001BView.updateRecord;
begin
  FTypeExpenseController
   .update
    .description(TxDescription.Text)
    .save;
end;

end.
