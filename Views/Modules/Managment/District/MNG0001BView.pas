unit MNG0001BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle,
  Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
  Vcl.Mask, RzEdit,
  cxControls, cxContainer, cxEdit, cxLabel, Types.Controllers, Base.View.interf,
  District.Controller.interf, cxTextEdit, cxMaskEdit, cxButtonEdit,
  dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Silver,
  System.Actions, Vcl.ActnList,
  City.Controller.interf;

type
  TFMNG0001BView = class(TFBaseRegisterView, iBaseRegisterView)
    LbDistrictId: TcxLabel;
    LbDescription: TcxLabel;
    TxCreatedDate: TcxTextEdit;
    TxUpdatedDate: TcxTextEdit;
    TxDescription: TcxTextEdit;
    LbCreatedAt: TcxLabel;
    LbUpdatedAt: TcxLabel;
    TxDistrictId: TcxTextEdit;
    TxCityId: TcxButtonEdit;
    TxCityName: TcxTextEdit;
    cxLabel3: TcxLabel;
    acSelectCity: TAction;
    TxZipCode: TcxTextEdit;
    LbCEP: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
    procedure acSelectCityExecute(Sender: TObject);
  private
    FDistrictController: iDistrictController;
    FCityController: iCityController;

    procedure selectCity;
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
  FMNG0001BView: TFMNG0001BView;

implementation

{$R *.dfm}

uses Facade.Controller, Facade.View, Types.Views;
{ TFMNG0001BView }

procedure TFMNG0001BView.acSelectCityExecute(Sender: TObject);
begin
  inherited;
  selectCity;
end;

procedure TFMNG0001BView.BtConfirmarClick(Sender: TObject);
begin
  save;
  inherited;
end;

procedure TFMNG0001BView.deleteRecord;
begin
  FDistrictController.delete.save;
end;

procedure TFMNG0001BView.disableFields;
begin
  TxDescription.Enabled := not(FOperation in [toShow, toDelete]);
  TxCityId.Enabled      := not(FOperation in [toShow, toDelete]);
  TxZipCode.Enabled     := not(FOperation in [toShow, toDelete]);

  LbCreatedAt.Visible   := not(FOperation in [toInsert]);
  TxCreatedDate.Visible := not(FOperation in [toInsert]);
  LbUpdatedAt.Visible   := not(FOperation in [toInsert]);
  TxUpdatedDate.Visible := not(FOperation in [toInsert]);

  BtConfirmar.Visible := not(FOperation = toShow);
end;

procedure TFMNG0001BView.duplicateRecord;
begin
  FDistrictController
   .duplicate
    .description(TxDescription.Text)
    .cityId(FCityController.code)
    .zipCode(TxZipCode.Text)
   .save;
end;

procedure TFMNG0001BView.&end;
begin
  showDataOnScreen;
  disableFields;
  showCurrentOperation;

  ShowModal;
end;

procedure TFMNG0001BView.FormCreate(Sender: TObject);
begin
  inherited;
  FDistrictController := TFacadeController.new
     .ModulesFacadeController
     .ManagmentFactoryController
    .districtController;

  FCityController := TFacadeController.new
     .ModulesFacadeController
     .ManagmentFactoryController
    .cityController;
end;

procedure TFMNG0001BView.insertRecord;
begin
  FDistrictController
    .insert
     .description(TxDescription.Text)
     .cityId(FCityController.code)
     .zipCode(TxZipCode.Text)
    .save;
end;

class function TFMNG0001BView.new: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFMNG0001BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFMNG0001BView.selectCity;
var
  codeCity: string;
begin
  codeCity := TFacadeView.new.modulesFacadeView.ManagmentFactoryView.
    showProgramOfSearch(tsMNG0004CView).showSearch.&end;

    if codeCity = EmptyStr then Exit;

    FCityController.find(codeCity);

    TxCityId.Text   := FCityController.cityId;
    TxCityName.Text := FCityController.name;
    TxZipCode.Text      := FCityController.zipCode;
end;

function TFMNG0001BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFMNG0001BView.save;
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

procedure TFMNG0001BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FDistrictController.find(FSelectedRecord);
  FCityController.findById(FDistrictController.cityId);

  TxDistrictId.Text  := FDistrictController.districtId;
  TxDescription.Text := FDistrictController.description;
  TxCityId.Text      := FDistrictController.cityId;
  TxCityName.Text    := FDistrictController.cityName;
  TxZipCode.Text     := FDistrictController.zipCode;
  TxCreatedDate.Text := FDistrictController.createdDate;
  TxUpdatedDate.Text := FDistrictController.updatedDate;
end;

procedure TFMNG0001BView.updateRecord;
begin
  FDistrictController
   .update
    .description(TxDescription.Text)
    .cityId(FCityController.code)
    .zipCode(TxZipCode.Text)
   .save;
end;

end.
