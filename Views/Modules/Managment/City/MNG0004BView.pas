unit MNG0004BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Silver,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, cxButtons, RzLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  cxTextEdit, cxLabel,
  Base.View.interf, Types.Controllers, State.Controller.interf,
  City.Controller.interf, dxSkinDarkRoom, dxSkinDarkSide;

type
  TFMNG0004BView = class(TFBaseRegisterView, iBaseRegisterView)
    LbUpdatedAt: TcxLabel;
    LbCreatedAt: TcxLabel;
    cxLabel3: TcxLabel;
    LbDescription: TcxLabel;
    LbDistrictId: TcxLabel;
    TxCityId: TcxTextEdit;
    TxName: TcxTextEdit;
    TxStateId: TcxButtonEdit;
    TxStateName: TcxTextEdit;
    TxCreatedAt: TcxTextEdit;
    TxUpdatedAt: TcxTextEdit;
    TxZipCode: TcxTextEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    TxIBGECode: TcxTextEdit;
    acSearchState: TAction;
    procedure acSearchStateExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
    procedure TxNamePropertiesChange(Sender: TObject);
    procedure TxStateIdPropertiesChange(Sender: TObject);
    procedure TxZipCodePropertiesChange(Sender: TObject);
    procedure TxIBGECodePropertiesChange(Sender: TObject);
  private
    FCityController: iCityController;
    FStateController: iStateController;

    procedure selectState;
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
  FMNG0004BView: TFMNG0004BView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views, Facade.Controller;

{ TFMNG0004BView }

procedure TFMNG0004BView.acSearchStateExecute(Sender: TObject);
begin
  inherited;
  selectState;
end;

procedure TFMNG0004BView.BtConfirmarClick(Sender: TObject);
begin
  save;
  inherited;
end;

procedure TFMNG0004BView.deleteRecord;
begin
  FCityController
   .Delete
    .save;
end;

procedure TFMNG0004BView.disableFields;
begin
  TxName.Enabled     := not(FOperation in [toShow, toDelete]);
  TxStateId.Enabled  := not(FOperation in [toShow, toDelete]);
  TxZipCode.Enabled  := not(FOperation in [toShow, toDelete]);
  TxIBGECode.Enabled := not(FOperation in [toShow, toDelete]);

  PnButtonConfirm.Visible := not(FOperation = toShow);
  BtConfirmar.Visible     := not(FOperation = toShow);
end;

procedure TFMNG0004BView.duplicateRecord;
begin
  FCityController
   .duplicate
    .name(TxName.Text)
    .zipCode(TxZipCode.Text)
    .ibgeCode(TxIBGECode.Text)
    .stateId(FStateController.code)
   .save;
end;

procedure TFMNG0004BView.&end;
begin
  {1 } showDataOnScreen;
  {2 } disableFields;
  {3 } showCurrentOperation;

  ShowModal;
end;

procedure TFMNG0004BView.FormCreate(Sender: TObject);
begin
  inherited;
  FCityController := TFacadeController.New.ModulesFacadeController.
    ManagmentFactoryController.cityController;

  FStateController := TFacadeController.New.ModulesFacadeController.
    ManagmentFactoryController.stateController;
end;

procedure TFMNG0004BView.insertRecord;
begin
  FCityController
   .insert
    .name(TxName.Text)
    .zipCode(TxZipCode.Text)
    .ibgeCode(TxIBGECode.Text)
    .stateId(FStateController.code)
   .save;
end;

class function TFMNG0004BView.New: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFMNG0004BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFMNG0004BView.save;
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

function TFMNG0004BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFMNG0004BView.selectState;
var
  stateCodigo: string;
begin
  stateCodigo := TFacadeView.New.modulesFacadeView.ManagmentFactoryView.
    showProgramOfSearch(tsMNG0003CView).showSearch.&end;

  if stateCodigo = EmptyStr then
    Exit;

  FStateController.find(stateCodigo);

  TxStateId.Text := FStateController.stateId;
  TxStateName.Text := FStateController.name;
end;

procedure TFMNG0004BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FCityController.find(FSelectedRecord);
  FStateController.findById(FCityController.stateId);

  TxCityId.Text := FCityController.cityId;
  TxName.Text := FCityController.name;
  TxStateId.Text := FCityController.stateId;
  TxStateName.Text := FCityController.stateName;
  TxZipCode.Text := FCityController.zipCode;
  TxIBGECode.Text := FCityController.ibgeCode;

  TxCreatedAt.Text := FCityController.createdAt;
  TxUpdatedAt.Text := FCityController.updatedAt;

  BtConfirmar.Enabled := False;
end;

procedure TFMNG0004BView.TxIBGECodePropertiesChange(Sender: TObject);
begin
  inherited;
 changeDataAnyFields;
end;

procedure TFMNG0004BView.TxNamePropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFMNG0004BView.TxStateIdPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFMNG0004BView.TxZipCodePropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFMNG0004BView.updateRecord;
begin
  FCityController
   .update
    .name(TxName.Text)
    .zipCode(TxZipCode.Text)
    .ibgeCode(TxIBGECode.Text)
    .stateId(FStateController.code)
   .save;
end;

end.
