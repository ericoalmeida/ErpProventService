unit MNG0003BView;

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
  Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
  cxControls,
  cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, cxLabel, cxTextEdit,
  Base.View.interf,
  Types.Controllers, State.Controller.interf, Country.Controller.interf,
  System.Actions,
  Vcl.ActnList;

type
  TFMNG0003BView = class(TFBaseRegisterView, iBaseRegisterView)
    TxUpdatedDate: TcxTextEdit;
    cxLabel2: TcxLabel;
    TxCreatedDate: TcxTextEdit;
    cxLabel1: TcxLabel;
    TxCountryName: TcxTextEdit;
    TxCountryId: TcxButtonEdit;
    cxLabel3: TcxLabel;
    TxDescription: TcxTextEdit;
    LbDescription: TcxLabel;
    TxStateId: TcxTextEdit;
    LbDistrictId: TcxLabel;
    acFind: TAction;
    procedure FormCreate(Sender: TObject);
    procedure acFindExecute(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    FStateController: iStateController;
    FCountryController: iCountryController;

    procedure selectCountry;
  public
    { Public declarations }
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
  FMNG0003BView: TFMNG0003BView;

implementation

{$R *.dfm}

uses Facade.Controller, Facade.View, Types.Views;

{ TFMNG0003BView }

procedure TFMNG0003BView.acFindExecute(Sender: TObject);
begin
  inherited;
  selectCountry;
end;

procedure TFMNG0003BView.BtConfirmarClick(Sender: TObject);
begin
  save;
  inherited;
end;

procedure TFMNG0003BView.deleteRecord;
begin
  FStateController
    .delete
      .save;
end;

procedure TFMNG0003BView.disableFields;
begin
  TxDescription.Enabled := not(FOperation in [toShow, toDelete]);
  TxCountryId.Enabled := not(FOperation in [toShow, toDelete]);
  BtConfirmar.Visible := not(FOperation = toShow);
end;

procedure TFMNG0003BView.duplicateRecord;
begin
  FStateController
    .duplicate
     .description(TxDescription.Text)
      .countryId(FCountryController.codigo)
      .save;
end;

procedure TFMNG0003BView.&end;
begin
  showDataOnScreen;
  disableFields;
  showCurrentOperation;

  ShowModal;
end;

procedure TFMNG0003BView.FormCreate(Sender: TObject);
begin
  inherited;
  FStateController := TFacadeController.new.ModulesFacadeController.
    ManagmentFactoryController.stateController;

  FCountryController := TFacadeController.new.ModulesFacadeController.
    ManagmentFactoryController.countryController;
end;

procedure TFMNG0003BView.insertRecord;
begin
  FStateController
    .insert
     .description(TxDescription.Text)
      .countryId(FCountryController.codigo)
      .save;
end;

class function TFMNG0003BView.new: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFMNG0003BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFMNG0003BView.save;
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

procedure TFMNG0003BView.selectCountry;
var
  countryCodigo: string;
begin
  countryCodigo := TFacadeView.new.modulesFacadeView.ManagmentFactoryView.
    showProgramOfSearch(tsMNG0002CView).showSearch.&end;

  if countryCodigo = EmptyStr then
    Exit;

  FCountryController.find(countryCodigo);

  TxCountryId.Text := FCountryController.countryId;
  TxCountryName.Text := FCountryController.description;
end;

function TFMNG0003BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFMNG0003BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FStateController.find(FSelectedRecord);
  FCountryController.findById(FStateController.countryId);

  TxStateId.Text := FStateController.stateId;
  TxDescription.Text := FStateController.description;
  TxCountryId.Text := FStateController.countryId;
  TxCountryName.Text := FStateController.countryDescription;
  TxCreatedDate.Text := FStateController.createdDate;
  TxUpdatedDate.Text := FStateController.updatedDate;
end;

procedure TFMNG0003BView.updateRecord;
begin
  FStateController
    .update
     .description(TxDescription.Text)
      .countryId(FCountryController.codigo)
      .save;
end;

end.
