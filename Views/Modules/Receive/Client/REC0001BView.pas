unit REC0001BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls,
  cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, cxControls,
  cxContainer, cxEdit,
  cxMaskEdit, cxButtonEdit, cxLabel, cxTextEdit, cxDropDownEdit,
  Base.View.interf, Types.Controllers, Person.Controller.interf, District.Controller.Interf,
  ERGTextEdit, ERGButtonEdit;

type
  TFREC0001BView = class(TFBaseRegisterView, iBaseRegisterView)
    TxCompanyId: TcxTextEdit;
    LbCompanyId: TcxLabel;
    LbName: TcxLabel;
    LbFancyName: TcxLabel;
    LbCNPJ: TcxLabel;
    LbIE: TcxLabel;
    TxIE: TcxTextEdit;
    LbAddress: TcxLabel;
    LbDistrictId: TcxLabel;
    TxDistrictName: TcxTextEdit;
    LbPhoneNumber: TcxLabel;
    TxPhoneNumber: TcxTextEdit;
    LbEmail: TcxLabel;
    TxEmail: TcxTextEdit;
    LbCreatedAt: TcxLabel;
    TxCreatedAt: TcxTextEdit;
    LbUpdatedAt: TcxLabel;
    TxUpdatedAt: TcxTextEdit;
    CbStatus: TcxComboBox;
    LbStatus: TcxLabel;
    ActSelectDistrict: TAction;
    TxDistrictId: TERGButtonEdit;
    TxAddress: TERGTextEdit;
    TxCNPJ: TERGTextEdit;
    TxFancyName: TERGTextEdit;
    TxName: TERGTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure CbStatusPropertiesChange(Sender: TObject);
    procedure TxNamePropertiesChange(Sender: TObject);
    procedure TxFancyNamePropertiesChange(Sender: TObject);
    procedure TxCNPJPropertiesChange(Sender: TObject);
    procedure TxIEPropertiesChange(Sender: TObject);
    procedure TxAddressPropertiesChange(Sender: TObject);
    procedure TxDistrictIdPropertiesChange(Sender: TObject);
    procedure TxPhoneNumberPropertiesChange(Sender: TObject);
    procedure TxEmailPropertiesChange(Sender: TObject);
    procedure ActSelectDistrictExecute(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    FClientController: iPersonController;
    FDistrictController: iDistrictController;

    procedure selectDistrict;
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
  FREC0001BView: TFREC0001BView;

implementation

{$R *.dfm}

uses Facade.Controller, Facade.View, Types.Views;
{ TFREC0001BView }

procedure TFREC0001BView.ActSelectDistrictExecute(Sender: TObject);
begin
  inherited;
  selectDistrict;
end;

procedure TFREC0001BView.BtConfirmarClick(Sender: TObject);
begin
  if not(validate) then Exit;

  save;

  Close;
end;

procedure TFREC0001BView.CbStatusPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFREC0001BView.deleteRecord;
begin
  FClientController
   .delete
   .save;
end;

procedure TFREC0001BView.disableFields;
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

procedure TFREC0001BView.duplicateRecord;
begin
  FClientController
   .duplicate
    .companyId(FSessionCompany)
    .personType(Integer(tpClient))
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

procedure TFREC0001BView.&end;
begin
  { 1 } showDataOnScreen;
  { 2 } disableFields;
  { 3 } showCurrentOperation;

  ShowModal;
end;

procedure TFREC0001BView.FormCreate(Sender: TObject);
begin
  inherited;

  FClientController := TFacadeController.New.ModulesFacadeController.
    ManagmentFactoryController.personController;

  FDistrictController := TFacadeController.New.ModulesFacadeController.
    ManagmentFactoryController.districtController;
end;

procedure TFREC0001BView.insertRecord;
begin
  FClientController
   .insert
    .companyId(FSessionCompany)
    .personType(Integer(tpClient))
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

class function TFREC0001BView.New: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFREC0001BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFREC0001BView.save;
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

procedure TFREC0001BView.selectDistrict;
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

function TFREC0001BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFREC0001BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FClientController.find(FSelectedRecord);
  FDistrictController.findById(FClientController.districtId);

  TxCompanyId.Text    := FClientController.personId;
  TxName.Text         := FClientController.name;
  TxFancyName.Text    := FClientController.fancyName;
  TxCNPJ.Text         := FClientController.cpfcnpj;
  TxIE.Text           := FClientController.rgie;
  TxAddress.Text      := FClientController.address;
  TxDistrictId.Text   := FClientController.districtId;
  TxDistrictName.Text := FClientController.districtName;
  TxPhoneNumber.Text  := FClientController.phoneNumber;
  TxEmail.Text        := FClientController.email;
  CbStatus.ItemIndex  := FClientController.status;

  TxCreatedAt.Text := FClientController.createdAt;
  TxUpdatedAt.Text := FClientController.updatedAt;

  if not(FOperation in [toDelete]) then
    BtConfirmar.Enabled := False;
end;

procedure TFREC0001BView.TxAddressPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFREC0001BView.TxCNPJPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFREC0001BView.TxDistrictIdPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFREC0001BView.TxEmailPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFREC0001BView.TxFancyNamePropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFREC0001BView.TxIEPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFREC0001BView.TxNamePropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFREC0001BView.TxPhoneNumberPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFREC0001BView.updateRecord;
begin
  FClientController
   .update
    .companyId(FSessionCompany)
    .personType(Integer(tpClient))
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
