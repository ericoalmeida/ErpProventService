unit MNG0002BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle,
  Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
  Base.View.interf, Types.Controllers, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxLabel,
  Country.Controller.interf, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Silver;

type
  TFMNG0002BView = class(TFBaseRegisterView, iBaseRegisterView)
    cxLabel2: TcxLabel;
    cxLabel1: TcxLabel;
    TxUpdatedDate: TcxTextEdit;
    TxCreatedDate: TcxTextEdit;
    LbDescription: TcxLabel;
    TxDescription: TcxTextEdit;
    TxCountryId: TcxTextEdit;
    LbCountryId: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    FCountryController: iCountryController;

  public

    class function new: iBaseRegisterView;

    function operation(AValue: TTypeOperation): iBaseRegisterView;
    function selectedRecord(AValue: string): iBaseRegisterView;

    procedure insert;
    procedure update;
    procedure recover;
    procedure delete;
    procedure duplicate;

    procedure save;
    procedure showDataOnScreen;
    procedure disableFields;

    procedure &end;
  end;

var
  FMNG0002BView: TFMNG0002BView;

implementation

{$R *.dfm}

uses Facade.Controller;
{ TFMNG0002BView }

procedure TFMNG0002BView.BtConfirmarClick(Sender: TObject);
begin
  save;
  inherited;
end;

procedure TFMNG0002BView.delete;
begin
  FCountryController
   .delete
    .save;
end;

procedure TFMNG0002BView.disableFields;
begin
  TxDescription.Enabled := not(FOperation in [toShow, toDelete]);
  BtConfirmar.Visible := not(FOperation = toShow);
end;

procedure TFMNG0002BView.duplicate;
begin
  FCountryController
   .duplicate
    .description(TxDescription.Text)
     .save;
end;

procedure TFMNG0002BView.&end;
begin
  showDataOnScreen;
  disableFields;
  showCurrentOperation;

  ShowModal;
end;

procedure TFMNG0002BView.FormCreate(Sender: TObject);
begin
  inherited;
  FCountryController := TFacadeController.new.ModulesFacadeController.
    ManagmentFactoryController.countryController
end;

procedure TFMNG0002BView.insert;
begin
  FCountryController
   .insert
    .description(TxDescription.Text)
    .save;
end;

class function TFMNG0002BView.new: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFMNG0002BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFMNG0002BView.recover;
begin

end;

procedure TFMNG0002BView.save;
begin
  case FOperation of
    toInsert:
      insert;

    toUpdate:
      update;

    toDelete:
      delete;

    toDuplicate:
      duplicate;
  end;
end;

function TFMNG0002BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFMNG0002BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FCountryController.find(FSelectedRecord);

  TxCountryId.Text := FCountryController.countryId;
  TxDescription.Text := FCountryController.description;
  TxCreatedDate.Text := FCountryController.createdDate;
  TxUpdatedDate.Text := FCountryController.updatedDate;
end;

procedure TFMNG0002BView.update;
begin
  FCountryController
   .update
    .description(TxDescription.Text)
     .save;
end;

end.
