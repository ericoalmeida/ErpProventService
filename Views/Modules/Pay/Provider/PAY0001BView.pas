unit PAY0001BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, System.Actions, Vcl.ActnList, Vcl.StdCtrls,
  cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, cxControls, cxContainer, cxEdit,
  cxMaskEdit, cxButtonEdit, cxLabel, cxTextEdit, cxDropDownEdit, Base.View.interf, Types.Controllers,
  Person.Controller.Interf, District.Controller.Interf;

type
  TFPAY0001BView = class(TFBaseRegisterView, iBaseRegisterView)
    TxCompanyId: TcxTextEdit;
    LbCompanyId: TcxLabel;
    LbName: TcxLabel;
    TxName: TcxTextEdit;
    LbFancyName: TcxLabel;
    TxFancyName: TcxTextEdit;
    LbCNPJ: TcxLabel;
    TxCNPJ: TcxTextEdit;
    LbIE: TcxLabel;
    TxIE: TcxTextEdit;
    LbAddress: TcxLabel;
    TxAddress: TcxTextEdit;
    LbDistrictId: TcxLabel;
    TxDistrictId: TcxButtonEdit;
    TxDistrictName: TcxTextEdit;
    LbPhoneNumber: TcxLabel;
    TxPhoneNumber: TcxTextEdit;
    LbEmail: TcxLabel;
    TxEmail: TcxTextEdit;
    LbCreatedAt: TcxLabel;
    TxCreatedAt: TcxTextEdit;
    LbUpdatedAt: TcxLabel;
    TxUpdatedAt: TcxTextEdit;
    LbStatus: TcxLabel;
    CbStatus: TcxComboBox;
    ActSelectDistrict: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ActSelectDistrictExecute(Sender: TObject);
    procedure TxNamePropertiesChange(Sender: TObject);
    procedure TxFancyNamePropertiesChange(Sender: TObject);
    procedure TxCNPJPropertiesChange(Sender: TObject);
    procedure TxIEPropertiesChange(Sender: TObject);
    procedure TxAddressPropertiesChange(Sender: TObject);
    procedure TxDistrictIdPropertiesChange(Sender: TObject);
    procedure TxPhoneNumberPropertiesChange(Sender: TObject);
    procedure TxEmailPropertiesChange(Sender: TObject);
    procedure CbStatusPropertiesChange(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    FProviderController: iPersonController;
    FDistrictController: iDistrictController;

    procedure selectDistrict;
  public
    class function new: iBaseRegisterView;

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
  FPAY0001BView: TFPAY0001BView;

implementation

{$R *.dfm}

uses Facade.Controller, Facade.View, Types.Views;

{ TFPAY0001BView }

procedure TFPAY0001BView.ActSelectDistrictExecute(Sender: TObject);
begin
  inherited;
  selectDistrict;
end;

procedure TFPAY0001BView.BtConfirmarClick(Sender: TObject);
begin
  save;

  inherited;
end;

procedure TFPAY0001BView.CbStatusPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFPAY0001BView.deleteRecord;
begin
  FProviderController
   .delete
   .save;
end;

procedure TFPAY0001BView.disableFields;
begin
  TxName.Enabled := not(FOperation in [toShow, toDelete]);
  TxFancyName.Enabled := not(FOperation in [toShow, toDelete]);
  TxCNPJ.Enabled := not(FOperation in [toShow, toDelete]);
  TxIE.Enabled := not(FOperation in [toShow, toDelete]);
  TxAddress.Enabled := not(FOperation in [toShow, toDelete]);
  TxDistrictId.Enabled := not(FOperation in [toShow, toDelete]);
  TxPhoneNumber.Enabled := not(FOperation in [toShow, toDelete]);
  TxEmail.Enabled := not(FOperation in [toShow, toDelete]);
  CbStatus.Enabled := not(FOperation in [toShow, toDelete]);

  PnButtonConfirm.Visible := not(FOperation = toShow);
  BtConfirmar.Visible := not(FOperation = toShow);
end;

procedure TFPAY0001BView.duplicateRecord;
begin
  FProviderController
   .duplicate
    .companyId(FSessionCompany)
    .personType(Integer(tpProvider))
    .name(TxName.Text)
    .fancyName(TxFancyName.Text)
    .CPFCNPJ(TxCNPJ.Text)
    .RGIE(TxIE.Text)
    .address(TxAddress.Text)
    .districtId(FDistrictController.code)
    .phoneNumber(TxPhoneNumber.Text)
    .email(TxEmail.Text)
    .status(CbStatus.ItemIndex)
    .userId(FSessionUser)
   .save;
end;

procedure TFPAY0001BView.&end;
begin
  { 1 } showDataOnScreen;
  { 2 } disableFields;
  { 3 } showCurrentOperation;

  ShowModal;
end;

procedure TFPAY0001BView.FormCreate(Sender: TObject);
begin
  inherited;

  FProviderController := TFacadeController.New.ModulesFacadeController.
    ManagmentFactoryController.personController;

  FDistrictController := TFacadeController.New.ModulesFacadeController.
    ManagmentFactoryController.districtController;
end;

procedure TFPAY0001BView.insertRecord;
begin
  FProviderController
   .insert
    .companyId(FSessionCompany)
    .personType(Integer(tpProvider))
    .name(TxName.Text)
    .fancyName(TxFancyName.Text)
    .CPFCNPJ(TxCNPJ.Text)
    .RGIE(TxIE.Text)
    .address(TxAddress.Text)
    .districtId(FDistrictController.code)
    .phoneNumber(TxPhoneNumber.Text)
    .email(TxEmail.Text)
    .status(CbStatus.ItemIndex)
    .userId(FSessionUser)
   .save;
end;

class function TFPAY0001BView.new: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFPAY0001BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFPAY0001BView.save;
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

procedure TFPAY0001BView.selectDistrict;
var
  districtCode: string;
begin
  districtCode := TFacadeView.New.modulesFacadeView.ManagmentFactoryView.
    showProgramOfSearch(tsMNG0001CView).showSearch.&end;

  if districtCode = EmptyStr then
    Exit;

  FDistrictController.find(districtCode);

  TxDistrictId.Text   := FDistrictController.districtId;
  TxDistrictName.Text := FDistrictController.description;
end;

function TFPAY0001BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFPAY0001BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FProviderController.find(FSelectedRecord);
  FDistrictController.findById(FProviderController.districtId);

  TxCompanyId.Text    := FProviderController.personId;
  TxName.Text         := FProviderController.name;
  TxFancyName.Text    := FProviderController.fancyName;
  TxCNPJ.Text         := FProviderController.cpfcnpj;
  TxIE.Text           := FProviderController.rgie;
  TxAddress.Text      := FProviderController.address;
  TxDistrictId.Text   := FProviderController.districtId;
  TxDistrictName.Text := FProviderController.districtName;
  TxPhoneNumber.Text  := FProviderController.phoneNumber;
  TxEmail.Text        := FProviderController.email;
  CbStatus.ItemIndex  := FProviderController.status;

  TxCreatedAt.Text := FProviderController.createdAt;
  TxUpdatedAt.Text := FProviderController.updatedAt;

  if not(FOperation in [toDelete]) then
    BtConfirmar.Enabled := False;
end;

procedure TFPAY0001BView.TxAddressPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFPAY0001BView.TxCNPJPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFPAY0001BView.TxDistrictIdPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFPAY0001BView.TxEmailPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFPAY0001BView.TxFancyNamePropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFPAY0001BView.TxIEPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFPAY0001BView.TxNamePropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFPAY0001BView.TxPhoneNumberPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFPAY0001BView.updateRecord;
begin
  FProviderController
   .update
    .companyId(FSessionCompany)
    .personType(Integer(tpProvider))
    .name(TxName.Text)
    .fancyName(TxFancyName.Text)
    .CPFCNPJ(TxCNPJ.Text)
    .RGIE(TxIE.Text)
    .address(TxAddress.Text)
    .districtId(FDistrictController.code)
    .phoneNumber(TxPhoneNumber.Text)
    .email(TxEmail.Text)
    .status(CbStatus.ItemIndex)
    .userId(FSessionUser)
   .save;
end;

end.
