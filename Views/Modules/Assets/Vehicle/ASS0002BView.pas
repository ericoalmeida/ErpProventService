unit ASS0002BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, System.Actions, Vcl.ActnList, Vcl.StdCtrls,
  cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, cxControls, cxContainer, cxEdit,
  cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit, Base.View.interf, Types.Controllers,
  Vehicle.Controller.Interf, ERGTextEdit;

type
  TFASS0002BView = class(TFBaseRegisterView, iBaseRegisterView)
    TxVehicleId: TcxTextEdit;
    LbVehicleId: TcxLabel;
    LbDescription: TcxLabel;
    TxCreatedDate: TcxTextEdit;
    LbCreatedAt: TcxLabel;
    TxUpdatedDate: TcxTextEdit;
    LbUpdatedAt: TcxLabel;
    CbStatus: TcxComboBox;
    LbStatus: TcxLabel;
    LbUserName: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    TxDescription: TERGTextEdit;
    TxModel: TERGTextEdit;
    TxCategory: TERGTextEdit;
    TxBrand: TERGTextEdit;
    TxBoard: TERGTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure TxDescriptionPropertiesChange(Sender: TObject);
    procedure TxModelPropertiesChange(Sender: TObject);
    procedure TxBrandPropertiesChange(Sender: TObject);
    procedure TxCategoryPropertiesChange(Sender: TObject);
    procedure TxBoardPropertiesChange(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
    procedure CbStatusPropertiesChange(Sender: TObject);
  private
    FVehicleController: iVehicleController;
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
  FASS0002BView: TFASS0002BView;

implementation

{$R *.dfm}

uses Facade.Controller;

{ TFASS0002BView }

procedure TFASS0002BView.BtConfirmarClick(Sender: TObject);
begin
  if not(validate) then Exit;

  save;

  Close;
end;

procedure TFASS0002BView.CbStatusPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFASS0002BView.deleteRecord;
begin
 FVehicleController
  .delete
  .save;
end;

procedure TFASS0002BView.disableFields;
begin
  CbStatus.Enabled      := not(FOperation in [toShow, toDelete]);
  TxDescription.Enabled := not(FOperation in [toShow, toDelete]);
  TxModel.Enabled       := not(FOperation in [toShow, toDelete]);
  TxBrand.Enabled       := not(FOperation in [toShow, toDelete]);
  TxCategory.Enabled    := not(FOperation in [toShow, toDelete]);
  TxBoard.Enabled       := not(FOperation in [toShow, toDelete]);

  PnButtonConfirm.Visible := not(FOperation = toShow);
  BtConfirmar.Visible := not(FOperation = toShow);
end;

procedure TFASS0002BView.duplicateRecord;
begin
 FVehicleController
  .duplicate
   .companyId(FSessionCompany)
   .description(TxDescription.Text)
   .model(TxModel.Text)
   .brand(TxBrand.Text)
   .category(TxCategory.Text)
   .board(TxBoard.Text)
   .status(CbStatus.ItemIndex)
   .userId(FSessionUser)
  .save;
end;

procedure TFASS0002BView.&end;
begin
  {1 } showDataOnScreen;
  {2 } disableFields;
  {3 } showCurrentOperation;

  ShowModal;
end;

procedure TFASS0002BView.FormCreate(Sender: TObject);
begin
  inherited;

  FVehicleController := TFacadeController.New.ModulesFacadeController.
    AssetsFactoryController.vehicleController;
end;

procedure TFASS0002BView.insertRecord;
begin
 FVehicleController
  .insert
   .companyId(FSessionCompany)
   .description(TxDescription.Text)
   .model(TxModel.Text)
   .brand(TxBrand.Text)
   .category(TxCategory.Text)
   .board(TxBoard.Text)
   .status(CbStatus.ItemIndex)
   .userId(FSessionUser)
  .save;
end;

class function TFASS0002BView.New: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFASS0002BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFASS0002BView.save;
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

function TFASS0002BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFASS0002BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FVehicleController.find(FSelectedRecord);

  TxVehicleId.Text   := FVehicleController.vehicleId;
  TxDescription.Text := FVehicleController.description;
  TxModel.Text       := FVehicleController.model;
  TxBrand.Text       := FVehicleController.brand;
  TxCategory.Text    := FVehicleController.category;
  TxBoard.Text       := FVehicleController.board;

  TxCreatedDate.Text    := FVehicleController.createdAt;
  TxUpdatedDate.Text    := FVehicleController.updatedAt;

  if not(FOperation in [toDelete]) then
    BtConfirmar.Enabled := False;
end;

procedure TFASS0002BView.TxBoardPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFASS0002BView.TxBrandPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFASS0002BView.TxCategoryPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFASS0002BView.TxDescriptionPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFASS0002BView.TxModelPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFASS0002BView.updateRecord;
begin
 FVehicleController
  .update
   .companyId(FSessionCompany)
   .description(TxDescription.Text)
   .model(TxModel.Text)
   .brand(TxBrand.Text)
   .category(TxCategory.Text)
   .board(TxBoard.Text)
   .status(CbStatus.ItemIndex)
   .userId(FSessionUser)
  .save;
end;

end.
