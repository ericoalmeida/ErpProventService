unit ORD0002BView;

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
  Types.Controllers, cxControls, cxContainer, cxEdit, cxTextEdit, cxLabel, cxMaskEdit,
  cxDropDownEdit, Operators.Controller.Interf;

type
  TFORD0002BView = class(TFBaseRegisterView, iBaseRegisterView)
    CbStatus: TcxComboBox;
    LbStatus: TcxLabel;
    TxTypeExpenseId: TcxTextEdit;
    LbExpenseId: TcxLabel;
    LbDescription: TcxLabel;
    TxDescription: TcxTextEdit;
    LbCreatedAt: TcxLabel;
    TxCreatedDate: TcxTextEdit;
    LbUpdatedAt: TcxLabel;
    TxUpdatedDate: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure CbStatusPropertiesChange(Sender: TObject);
    procedure TxDescriptionPropertiesChange(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    FOperatorController: iOperatorController;
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
  FORD0002BView: TFORD0002BView;

implementation

{$R *.dfm}

uses Facade.Controller;
{ TFORD0002BView }

procedure TFORD0002BView.BtConfirmarClick(Sender: TObject);
begin
  save;

  inherited;
end;

procedure TFORD0002BView.CbStatusPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFORD0002BView.deleteRecord;
begin
 FOperatorController
  .delete
  .save;
end;

procedure TFORD0002BView.disableFields;
begin
  CbStatus.Enabled := not(FOperation in [toShow, toDelete]);
  TxDescription.Enabled := not(FOperation in [toShow, toDelete]);

  PnButtonConfirm.Visible := not(FOperation = toShow);
  BtConfirmar.Visible := not(FOperation = toShow);
end;

procedure TFORD0002BView.duplicateRecord;
begin
 FOperatorController
  .duplicate
   .companyId(FSessionCompany)
   .name(TxDescription.Text)
   .status(CbStatus.ItemIndex)
   .userId(FSessionUser)
  .save;
end;

procedure TFORD0002BView.&end;
begin
  showDataOnScreen;
  disableFields;
  showCurrentOperation;

  ShowModal;
end;

procedure TFORD0002BView.FormCreate(Sender: TObject);
begin
  inherited;

  FOperatorController := TFacadeController.New.ModulesFacadeController.
    OrderOfServiceFactoryController.oepratorController;
end;

procedure TFORD0002BView.insertRecord;
begin
 FOperatorController
  .insert
   .companyId(FSessionCompany)
   .name(TxDescription.Text)
   .status(CbStatus.ItemIndex)
   .userId(FSessionUser)
  .save;
end;

class function TFORD0002BView.New: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFORD0002BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFORD0002BView.save;
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

function TFORD0002BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFORD0002BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FOperatorController.find(FSelectedRecord);

  TxTypeExpenseId.Text  := FOperatorController.operatorId;
  TxDescription.Text    := FOperatorController.name;

  TxCreatedDate.Text    := FOperatorController.createdAt;
  TxUpdatedDate.Text    := FOperatorController.updatedAt;

  if not(FOperation in [toDelete]) then
    BtConfirmar.Enabled := False;
end;

procedure TFORD0002BView.TxDescriptionPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFORD0002BView.updateRecord;
begin
 FOperatorController
  .update
   .companyId(FSessionCompany)
   .name(TxDescription.Text)
   .status(CbStatus.ItemIndex)
   .userId(FSessionUser)
  .save;
end;

end.
