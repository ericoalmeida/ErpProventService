unit ORD0003BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, System.Actions, Vcl.ActnList, Vcl.StdCtrls,
  cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, cxControls, cxContainer, cxEdit,
  cxMaskEdit, cxButtonEdit, cxLabel, cxTextEdit, cxCurrencyEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxDropDownEdit, cxCalendar, Base.View.interf, Types.Controllers, ServiceProvided.Controller.Interf,
  Person.Controller.Interf, Operators.Controller.Interf, Service.Controller.Interf,
  Vehicle.Controller.Interf, cxSpinEdit, cxTimeEdit, cxMemo, ERGTotalHorasEdit, Math, Vcl.Mask,
  RzEdit;

type
  TFORD0003BView = class(TFBaseRegisterView, iBaseRegisterView)
    TxServiceProvidedId: TcxTextEdit;
    LbDistrictId: TcxLabel;
    cxLabel3: TcxLabel;
    TxClientId: TcxButtonEdit;
    TxClientName: TcxTextEdit;
    TxOperatorName: TcxTextEdit;
    TxOperatorId: TcxButtonEdit;
    cxLabel1: TcxLabel;
    TxMachineName: TcxTextEdit;
    TxMachine: TcxButtonEdit;
    cxLabel2: TcxLabel;
    TxServiceName: TcxTextEdit;
    TxServiceId: TcxButtonEdit;
    cxLabel4: TcxLabel;
    LbUpdatedAt: TcxLabel;
    TxUpdatedDate: TcxTextEdit;
    TxCreatedDate: TcxTextEdit;
    LbCreatedAt: TcxLabel;
    cxLabel5: TcxLabel;
    TxTotal: TcxCurrencyEdit;
    cxLabel7: TcxLabel;
    TxData: TcxDateEdit;
    cxLabel8: TcxLabel;
    LbCanceled: TRzLabel;
    ActSelectClient: TAction;
    TxUnityPrice: TcxCurrencyEdit;
    TxTotalKm: TcxCurrencyEdit;
    TxTotalHours: TERGTotalHorasEdit;
    cxLabel10: TcxLabel;
    cxLabel6: TcxLabel;
    ActSelectOperator: TAction;
    ActSelectVehicle: TAction;
    ActSelectService: TAction;
    procedure FormCreate(Sender: TObject);
    procedure TxDataPropertiesChange(Sender: TObject);
    procedure TxClientIdPropertiesChange(Sender: TObject);
    procedure TxOperatorIdPropertiesChange(Sender: TObject);
    procedure TxMachinePropertiesChange(Sender: TObject);
    procedure TxServiceIdPropertiesChange(Sender: TObject);
    procedure TxTotalHoursPropertiesChange(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
    procedure ActSelectClientExecute(Sender: TObject);
    procedure TxTotalHoursExit(Sender: TObject);
    procedure TxTotalKmPropertiesChange(Sender: TObject);
    procedure ActSelectOperatorExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActSelectVehicleExecute(Sender: TObject);
    procedure ActSelectServiceExecute(Sender: TObject);
  private
    FServiceProvidedController: iServiceProvidedController;
    FClientController: iPersonController;
    FOperatorController: iOperatorController;
    FServiceController: iServiceController;
    FVehicleController: iVehicleController;

    procedure calcularValorTotalPelasHorasTrabalhadas(AValue: Integer);

    procedure selectClient;
    procedure selectOperator;
    procedure selectVehicle;
    procedure selectService;
  protected
    procedure showCurrentOperation; override;
    procedure disabledFieldsOnCanceledOs;
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
  FORD0003BView: TFORD0003BView;

implementation

{$R *.dfm}

uses Facade.Controller, Facade.View, Types.Views, DateUtils;

{ TFORD0003BView }

procedure TFORD0003BView.ActSelectClientExecute(Sender: TObject);
begin
  inherited;

  selectClient;
end;

procedure TFORD0003BView.ActSelectOperatorExecute(Sender: TObject);
begin
  inherited;
  selectOperator;
end;

procedure TFORD0003BView.ActSelectServiceExecute(Sender: TObject);
begin
  inherited;
  selectService;
end;

procedure TFORD0003BView.ActSelectVehicleExecute(Sender: TObject);
begin
  inherited;
  selectVehicle;
end;

procedure TFORD0003BView.BtConfirmarClick(Sender: TObject);
begin
  PnButtonConfirm.SetFocus;

  save;

  inherited;
end;

procedure TFORD0003BView.calcularValorTotalPelasHorasTrabalhadas(AValue: Integer);
var
 pricePerMinute: Currency;
 Hour, Minutes, Seconds: Cardinal;
begin
  if AValue = 0 then Exit;

  Hour    := AValue div 3600;                         //3600 segundos por hora;
  Seconds := AValue mod 3600;                         //3600 segundos por hora;
  Minutes := Hour * 60;
  Minutes := Minutes + Seconds div 60;

  pricePerMinute := (FServiceController.price / 60);  //60 minutos por hora
  TxTotal.Value  := (pricePerMinute * Minutes);
end;

procedure TFORD0003BView.deleteRecord;
begin
  FServiceProvidedController
   .delete
   .save;
end;

procedure TFORD0003BView.disabledFieldsOnCanceledOs;
begin
  TxData.Enabled          := False;
  TxClientId.Enabled      := False;
  TxOperatorId.Enabled    := False;
  TxMachine.Enabled       := False;
  TxServiceId.Enabled     := False;
  TxTotalHours.Enabled    := False;
  TxTotalKm.Enabled       := False;

  LbCanceled.Visible := True;

  PnButtonConfirm.Visible := False;
  BtConfirmar.Visible     := False;
end;

procedure TFORD0003BView.disableFields;
begin
  TxData.Enabled        := not(FOperation in [toShow, toDelete]);
  TxClientId.Enabled    := not(FOperation in [toShow, toDelete]);
  TxOperatorId.Enabled  := not(FOperation in [toShow, toDelete]);
  TxMachine.Enabled     := not(FOperation in [toShow, toDelete]);
  TxServiceId.Enabled   := not(FOperation in [toShow, toDelete]);
  TxTotalHours.Enabled  := not(FOperation in [toShow, toDelete]);
  TxTotalKm.Enabled     := not(FOperation in [toShow, toDelete]);


  PnButtonConfirm.Visible := not(FOperation = toShow);
  BtConfirmar.Visible     := not(FOperation = toShow);


  if (FOperation in [toInsert]) then
    Exit;

  if FServiceProvidedController.status = 1 then
   disabledFieldsOnCanceledOs;
end;

procedure TFORD0003BView.duplicateRecord;
begin
  FServiceProvidedController
   .duplicate
    .companyId(FSessionCompany)
    .providedAt(TxData.Date)
    .clientId(FClientController.code)
    .operatorId(FOperatorController.code)
    .machineId(FVehicleController.code)
    .serviceId('{DDC3284A-E0F3-46BE-B8AA-6C72B84E73A8}')
    .totalHours(TxTotalHours.Hours)
    .totalKm(TxTotalKm.Value)
    .total(TxTotal.Value)
    .userId(FSessionUser)
   .save;
end;

procedure TFORD0003BView.&end;
begin
  { 1 } showDataOnScreen;
  { 2 } disableFields;
  { 3 } showCurrentOperation;

  ShowModal;
end;

procedure TFORD0003BView.FormCreate(Sender: TObject);
begin
  inherited;
  FServiceProvidedController := TFacadeController.New.ModulesFacadeController.
    OrderOfServiceFactoryController.serviceProvidedController;

  FClientController := TFacadeController.New.ModulesFacadeController.
    ManagmentFactoryController.personController;

  FOperatorController := TFacadeController.New.ModulesFacadeController.
    OrderOfServiceFactoryController.oepratorController;

  FVehicleController := TFacadeController.New.ModulesFacadeController.
    AssetsFactoryController.vehicleController;

  FServiceController := TFacadeController.New.ModulesFacadeController.
    OrderOfServiceFactoryController.serviceController;
end;

procedure TFORD0003BView.FormShow(Sender: TObject);
begin
  inherited;

  if FOperation = toInsert then
  TxTotalHours.Value := 0;
end;

procedure TFORD0003BView.insertRecord;
begin
  FServiceProvidedController
   .insert
    .companyId(FSessionCompany)
    .providedAt(TxData.Date)
    .clientId(FClientController.code)
    .operatorId(FOperatorController.code)
    .machineId(FVehicleController.code)
    .serviceId('{DDC3284A-E0F3-46BE-B8AA-6C72B84E73A8}')
    .totalHours(TxTotalHours.Hours)
    .totalKm(TxTotalKm.Value)
    .total(TxTotal.Value)
    .userId(FSessionUser)
   .save;
end;

class function TFORD0003BView.New: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFORD0003BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFORD0003BView.save;
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

procedure TFORD0003BView.selectClient;
var
  codeClient: string;
begin
  codeClient := TFacadeView.new.modulesFacadeView.receiveFactory.
    showProgramOfSearch(tsREC0001CView).showSearch.&end;

    if codeClient = EmptyStr then Exit;

    FClientController.find(codeClient);

    TxClientId.Text   := FClientController.personId;
    TxClientName.Text := FClientController.name;
end;

function TFORD0003BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFORD0003BView.selectOperator;
var
  codeOperator: string;
begin
  codeOperator := TFacadeView.new.modulesFacadeView.orderOfServiceFactory.
    showProgramOfSearch(tsORD0002CView).showSearch.&end;

    if codeOperator = EmptyStr then Exit;

    FOperatorController.find(codeOperator);

    TxOperatorId.Text   := FOperatorController.operatorId;
    TxOperatorName.Text := FOperatorController.name;
end;

procedure TFORD0003BView.selectService;
var
  codeService: string;
begin
  codeService := TFacadeView.new.modulesFacadeView.orderOfServiceFactory.
    showProgramOfSearch(tsORD0001CView).showSearch.&end;

    if codeService = EmptyStr then Exit;

    FServiceController.find(codeService);

    TxServiceId.Text     := FServiceController.serviceId;
    TxServiceName.Text   := FServiceController.description;
end;

procedure TFORD0003BView.selectVehicle;
var
  codeVehicle: string;
begin
  codeVehicle := TFacadeView.new.modulesFacadeView.assetsFactoryView.
    showProgramOfSearch(tsASS0002CView).showSearch.&end;

    if codeVehicle = EmptyStr then Exit;

    FVehicleController.find(codeVehicle);

    TxMachine.Text     := FVehicleController.vehicleId;
    TxMachineName.Text := FVehicleController.description;
end;

procedure TFORD0003BView.showCurrentOperation;
begin
  inherited;

  case FOperation of
    toDelete:
      begin
        LbOperation.Caption := '(Cancelando)';
        LbOperation.Font.Color := $000000D0;
      end;
  end;
end;

procedure TFORD0003BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FServiceProvidedController.find(FSelectedRecord);
  FClientController.findById(FServiceProvidedController.clientId);
  FOperatorController.findById(FServiceProvidedController.operatorId);
  FVehicleController.findById(FServiceProvidedController.machineId);
  FServiceController.findById(FServiceProvidedController.serviceId);

  TxServiceProvidedId.Text  := FServiceProvidedController.serviceProvidedId;
  TxData.Date               := FServiceProvidedController.providedAt;
  TxClientId.Text           := FClientController.personId;
  TxClientName.Text         := FClientController.name;
  TxOperatorId.Text         := FOperatorController.operatorId;
  TxOperatorName.Text       := FOperatorController.name;
  TxMachine.Text            := FVehicleController.vehicleId;
  TxMachineName.Text        := FVehicleController.description;
  TxServiceId.Text          := FServiceController.serviceId;
  TxServiceName.Text        := FServiceController.description;
  TxUnityPrice.Value        := FServiceController.price;
  TxTotalHours.Value        := FServiceProvidedController.totalHours;
  TxTotalKm.Value           := FServiceProvidedController.totalKm;
  TxTotal.Value             := FServiceProvidedController.total;
  TxCreatedDate.Text        := FServiceProvidedController.createdAt;
  TxUpdatedDate.Text        := FServiceProvidedController.updatedAt;

  if not(FOperation in [toDelete]) then
    BtConfirmar.Enabled := False;
end;

procedure TFORD0003BView.TxClientIdPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFORD0003BView.TxDataPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFORD0003BView.TxMachinePropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFORD0003BView.TxOperatorIdPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFORD0003BView.TxServiceIdPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;

  TxTotalHours.Enabled := not(TxServiceId.Text = EmptyStr);
  TxTotalKm.Enabled := not(TxServiceId.Text = EmptyStr);
end;

procedure TFORD0003BView.TxTotalHoursExit(Sender: TObject);
begin
  inherited;
  calcularValorTotalPelasHorasTrabalhadas(TxTotalHours.Hours);
end;

procedure TFORD0003BView.TxTotalHoursPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFORD0003BView.TxTotalKmPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFORD0003BView.updateRecord;
begin
  FServiceProvidedController
   .update
    .companyId(FSessionCompany)
    .providedAt(TxData.Date)
    .clientId(FClientController.code)
    .operatorId(FOperatorController.code)
    .machineId(FVehicleController.code)
    .serviceId('{DDC3284A-E0F3-46BE-B8AA-6C72B84E73A8}')
    .totalHours(TxTotalHours.Hours)
    .totalKm(TxTotalKm.Value)
    .total(TxTotal.Value)
    .userId(FSessionUser)
   .save;
end;

end.
