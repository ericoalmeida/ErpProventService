unit MNG0005BView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
   cxLookAndFeels,
   cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom,
   dxSkinDarkSide,
   dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, System.Actions,
   Vcl.ActnList, Vcl.StdCtrls,
   cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, cxControls,
   cxContainer, cxEdit,
   cxMaskEdit, cxButtonEdit, cxTextEdit, cxLabel, RzTabs, dxBarBuiltInMenu,
   cxPC,
   Base.View.interf,
   Types.Controllers, Company.Controller.interf, District.Controller.interf,
   ERGButtonEdit, ERGTextEdit;

type
   TFMNG0005BView = class(TFBaseRegisterView, iBaseRegisterView)
      LbUpdatedAt: TcxLabel;
      TxUpdatedAt: TcxTextEdit;
      TxCreatedAt: TcxTextEdit;
      LbCreatedAt: TcxLabel;
      TxEmail: TcxTextEdit;
      LbEmail: TcxLabel;
      TxPhoneNumber: TcxTextEdit;
      LbPhoneNumber: TcxLabel;
      TxDistrictName: TcxTextEdit;
      LbDistrictId: TcxLabel;
      LbAddress: TcxLabel;
      TxIE: TcxTextEdit;
      LbIE: TcxLabel;
      LbCNPJ: TcxLabel;
      LbFancyName: TcxLabel;
      LbName: TcxLabel;
      TxCompanyId: TcxTextEdit;
      LbCompanyId: TcxLabel;
      AcSelectDistrict: TAction;
      TxDistrictId: TERGButtonEdit;
      TxName: TERGTextEdit;
      TxFancyName: TERGTextEdit;
      TxCNPJ: TERGTextEdit;
      TxAddress: TERGTextEdit;
      procedure FormCreate(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
      procedure AcSelectDistrictExecute(Sender: TObject);
      procedure TxNamePropertiesChange(Sender: TObject);
      procedure TxFancyNamePropertiesChange(Sender: TObject);
      procedure TxCNPJPropertiesChange(Sender: TObject);
      procedure TxIEPropertiesChange(Sender: TObject);
      procedure TxAddressPropertiesChange(Sender: TObject);
      procedure TxDistrictIdPropertiesChange(Sender: TObject);
      procedure TxPhoneNumberPropertiesChange(Sender: TObject);
      procedure TxEmailPropertiesChange(Sender: TObject);
   private
      FCompanyController: iCompanyController;
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
   FMNG0005BView: TFMNG0005BView;

implementation

{$R *.dfm}

uses Facade.Controller, Facade.View, Types.Views;
{ TFMNG0005BView }

procedure TFMNG0005BView.AcSelectDistrictExecute(Sender: TObject);
begin
   inherited;
   selectDistrict;
end;

procedure TFMNG0005BView.BtConfirmarClick(Sender: TObject);
begin
   if not(validate) then
      Exit;

   save;

   Close;
end;

procedure TFMNG0005BView.deleteRecord;
begin
   FCompanyController.delete.save;
end;

procedure TFMNG0005BView.disableFields;
begin
   TxName.Enabled := not(FOperation in [toShow, toDelete]);
   TxFancyName.Enabled := not(FOperation in [toShow, toDelete]);
   TxCNPJ.Enabled := not(FOperation in [toShow, toDelete]);
   TxIE.Enabled := not(FOperation in [toShow, toDelete]);
   TxAddress.Enabled := not(FOperation in [toShow, toDelete]);
   TxDistrictId.Enabled := not(FOperation in [toShow, toDelete]);
   TxPhoneNumber.Enabled := not(FOperation in [toShow, toDelete]);
   TxEmail.Enabled := not(FOperation in [toShow, toDelete]);

   PnButtonConfirm.Visible := not(FOperation = toShow);
   BtConfirmar.Visible := not(FOperation = toShow);
end;

procedure TFMNG0005BView.duplicateRecord;
begin
   FCompanyController.duplicate.name(TxName.Text).fancyName(TxFancyName.Text)
     .cpfcnpj(TxCNPJ.Text).rgie(TxIE.Text).address(TxAddress.Text)
     .districtId(FDistrictController.code).phoneNumber(TxPhoneNumber.Text)
     .email(TxEmail.Text).save;
end;

procedure TFMNG0005BView.&end;
begin
   { 1 } showDataOnScreen;
   { 2 } disableFields;
   { 3 } showCurrentOperation;

   ShowModal;
end;

procedure TFMNG0005BView.FormCreate(Sender: TObject);
begin
   inherited;
   FCompanyController := TFacadeController.New.ModulesFacadeController.
     ManagmentFactoryController.companyController;

   FDistrictController := TFacadeController.New.ModulesFacadeController.
     ManagmentFactoryController.districtController;
end;

procedure TFMNG0005BView.insertRecord;
begin
   FCompanyController.insert.name(TxName.Text).fancyName(TxFancyName.Text)
     .cpfcnpj(TxCNPJ.Text).rgie(TxIE.Text).address(TxAddress.Text)
     .districtId(FDistrictController.code).phoneNumber(TxPhoneNumber.Text)
     .email(TxEmail.Text).save;
end;

class function TFMNG0005BView.New: iBaseRegisterView;
begin
   Result := Self.Create(nil);
end;

function TFMNG0005BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
   Result := Self;
   FOperation := AValue;
end;

procedure TFMNG0005BView.save;
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

procedure TFMNG0005BView.selectDistrict;
var
   districtCode: string;
begin
   districtCode := TFacadeView.New.modulesFacadeView.ManagmentFactoryView.
     showProgramOfSearch(tsMNG0001CView).showSearch.&end;

   if districtCode = EmptyStr then
      Exit;

   FDistrictController.find(districtCode);

   TxDistrictId.Text := FDistrictController.districtId;
   TxDistrictName.Text := FDistrictController.description;
end;

function TFMNG0005BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

procedure TFMNG0005BView.showDataOnScreen;
begin
   if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
      Exit;

   FCompanyController.find(FSelectedRecord);
   FDistrictController.findById(FCompanyController.districtId);

   TxCompanyId.Text := FCompanyController.companyId;
   TxName.Text := FCompanyController.name;
   TxFancyName.Text := FCompanyController.fancyName;
   TxCNPJ.Text := FCompanyController.cpfcnpj;
   TxIE.Text := FCompanyController.rgie;
   TxAddress.Text := FCompanyController.address;
   TxDistrictId.Text := FCompanyController.districtId;
   TxDistrictName.Text := FCompanyController.districtName;
   TxPhoneNumber.Text := FCompanyController.phoneNumber;
   TxEmail.Text := FCompanyController.email;

   TxCreatedAt.Text := FCompanyController.createdAt;
   TxUpdatedAt.Text := FCompanyController.updatedAt;

   if not(FOperation in [toDelete]) then
      BtConfirmar.Enabled := False;
end;

procedure TFMNG0005BView.TxAddressPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFMNG0005BView.TxCNPJPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFMNG0005BView.TxDistrictIdPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFMNG0005BView.TxEmailPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFMNG0005BView.TxFancyNamePropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFMNG0005BView.TxIEPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFMNG0005BView.TxNamePropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFMNG0005BView.TxPhoneNumberPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFMNG0005BView.updateRecord;
begin
   FCompanyController.update.name(TxName.Text).fancyName(TxFancyName.Text)
     .cpfcnpj(TxCNPJ.Text).rgie(TxIE.Text).address(TxAddress.Text)
     .districtId(FDistrictController.code).phoneNumber(TxPhoneNumber.Text)
     .email(TxEmail.Text).save;
end;

end.
