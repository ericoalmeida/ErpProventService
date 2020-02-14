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
  District.Controller.interf, cxTextEdit, cxMaskEdit, cxButtonEdit, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Silver;

type
  TFMNG0001BView = class(TFBaseRegisterView, iBaseRegisterView)
    LbDistrictId: TcxLabel;
    LbDescription: TcxLabel;
    TxCreatedDate: TcxTextEdit;
    TxUpdatedDate: TcxTextEdit;
    TxDescription: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    TxDistrictId: TcxTextEdit;
    TxCityId: TcxButtonEdit;
    TxCityName: TcxTextEdit;
    cxLabel3: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    FDistrictController: iDistrictController;
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
  FMNG0001BView: TFMNG0001BView;

implementation

{$R *.dfm}

uses Facade.Controller;
{ TFMNG0001BView }

procedure TFMNG0001BView.BtConfirmarClick(Sender: TObject);
begin
  save;
  inherited;
end;

procedure TFMNG0001BView.delete;
begin
  FDistrictController
   .delete
    .save;
end;

procedure TFMNG0001BView.disableFields;
begin
  TxDescription.Enabled := not(FOperation in [toShow, toDelete]);
  TxCityId.Enabled      := not(FOperation in [toShow, toDelete]);
  BtConfirmar.Visible   := not(FOperation = toShow);
end;

procedure TFMNG0001BView.duplicate;
begin
  FDistrictController
   .duplicate
    .description(TxDescription.Text)
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
  FDistrictController := TFacadeController.new.ModulesFacadeController.
    ManagmentFactoryController.districtController;
end;

procedure TFMNG0001BView.insert;
begin
  FDistrictController
   .insert
    .description(TxDescription.Text)
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

procedure TFMNG0001BView.recover;
begin

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
      insert;

    toUpdate:
      update;

    toDelete:
      delete;

    toDuplicate:
      duplicate;
  end;
end;

procedure TFMNG0001BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;


  FDistrictController.find(FSelectedRecord);

  TxDistrictId.Text := FDistrictController.districtId;
  TxDescription.Text := FDistrictController.description;
  TxCreatedDate.Text := FDistrictController.createdDate;
  TxUpdatedDate.Text := FDistrictController.updatedDate;
end;

procedure TFMNG0001BView.update;
begin
  FDistrictController
   .update
    .description(TxDescription.Text)
     .save;
end;

end.
