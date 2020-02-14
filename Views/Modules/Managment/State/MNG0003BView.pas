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
  Types.Controllers, State.Controller.interf;

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
    procedure FormCreate(Sender: TObject);
  private
    FStateController: iStateController;
  public
    { Public declarations }
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
  FMNG0003BView: TFMNG0003BView;

implementation

{$R *.dfm}

uses Facade.Controller;

{ TFMNG0003BView }

procedure TFMNG0003BView.delete;
begin

end;

procedure TFMNG0003BView.disableFields;
begin
  TxDescription.Enabled := not(FOperation in [toShow, toDelete]);
  TxCountryId.Enabled   := not(FOperation in [toShow, toDelete]);
  BtConfirmar.Visible   := not(FOperation = toShow);
end;

procedure TFMNG0003BView.duplicate;
begin

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
end;

procedure TFMNG0003BView.insert;
begin

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

procedure TFMNG0003BView.recover;
begin

end;

procedure TFMNG0003BView.save;
begin

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

  TxStateId.Text     := FStateController.stateId;
  TxDescription.Text := FStateController.description;
  TxCountryId.Text   := FStateController.countryId;
  TxCountryName.Text := FStateController.countryDescription;
  TxCreatedDate.Text := FStateController.createdDate;
  TxUpdatedDate.Text := FStateController.updatedDate;
end;

procedure TFMNG0003BView.update;
begin

end;

end.
