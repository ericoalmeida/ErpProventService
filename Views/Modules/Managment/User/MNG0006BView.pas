unit MNG0006BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls,
  cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf,
  Types.Controllers, cxControls, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxLabel,
  cxTextEdit, User.Controller.Interf, ERGTextEdit;

type
  TFMNG0006BView = class(TFBaseRegisterView, iBaseRegisterView)
    LbEmail: TcxLabel;
    LbName: TcxLabel;
    TxUserId: TcxTextEdit;
    LbUserId: TcxLabel;
    LbStatus: TcxLabel;
    LbUserName: TcxLabel;
    LbUpdatedAt: TcxLabel;
    LbCreatedAt: TcxLabel;
    TxCreatedAt: TcxTextEdit;
    TxUpdatedAt: TcxTextEdit;
    LbKeyPass: TcxLabel;
    PnUpdateKey: TRzPanel;
    BtUpdatePassword: TcxButton;
    CbStatus: TcxComboBox;
    TxName: TERGTextEdit;
    TxEmail: TERGTextEdit;
    TxUserName: TERGTextEdit;
    TxKeyPass: TERGTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure BtUpdatePasswordClick(Sender: TObject);
    procedure CbStatusPropertiesChange(Sender: TObject);
    procedure TxNamePropertiesChange(Sender: TObject);
    procedure TxEmailPropertiesChange(Sender: TObject);
    procedure TxUserNamePropertiesChange(Sender: TObject);
    procedure TxKeyPassPropertiesChange(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    FUserController : iUserController;

    procedure showMessageDuplicatedMail;
    procedure showMessageDuplicatedUserName;

    function userNameExists: Boolean;
    function userMailExists: Boolean;
  public
    { Public declarations }
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
  FMNG0006BView: TFMNG0006BView;

implementation

{$R *.dfm}

uses Facade.Controller, Facade.View, Types.Views;
{ TFMNG0006BView }

procedure TFMNG0006BView.BtConfirmarClick(Sender: TObject);
begin
  {1} if userMailExists then Exit;
  {2} if userNameExists then Exit;

  if not(validate) then Exit;

  {3}save;

  {4}Close;
end;

procedure TFMNG0006BView.BtUpdatePasswordClick(Sender: TObject);
begin
  inherited;
  TxKeyPass.Enabled := True;
end;

procedure TFMNG0006BView.CbStatusPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFMNG0006BView.deleteRecord;
begin
  FUserController
   .delete
   .save
end;

procedure TFMNG0006BView.disableFields;
begin
  TxName.Enabled     := not(FOperation in [toShow, toDelete]);
  TxName.Enabled     := not(FOperation in [toShow, toDelete]);
  TxEmail.Enabled    := not(FOperation in [toShow, toDelete]);
  TxUserName.Enabled := not(FOperation in [toShow, toDelete]);
  TxKeyPass.Enabled  := not(FOperation in [toUpdate, toShow, toDelete]);
  CbStatus.Enabled   := not(FOperation in [toShow, toDelete]);

  PnUpdateKey.Visible     := not(FOperation in [toInsert, toShow, toDelete]);

  PnButtonConfirm.Visible := not(FOperation = toShow);
  BtConfirmar.Visible     := not(FOperation = toShow);
end;

procedure TFMNG0006BView.duplicateRecord;
begin
  FUserController
   .duplicate
    .name(TxName.Text)
    .email(TxEmail.Text)
    .username(TxUserName.Text)
    .keypass(TxKeyPass.Text)
    .status(CbStatus.ItemIndex)
   .save
end;

procedure TFMNG0006BView.&end;
begin
  {1 } showDataOnScreen;
  {2 } disableFields;
  {3 } showCurrentOperation;

   ShowModal;
end;

procedure TFMNG0006BView.FormCreate(Sender: TObject);
begin
  inherited;

  FUserController := TFacadeController.New.ModulesFacadeController.
    ManagmentFactoryController.userController;
end;

procedure TFMNG0006BView.insertRecord;
begin
  FUserController
   .insert
    .name(TxName.Text)
    .email(TxEmail.Text)
    .username(TxUserName.Text)
    .keypass(TxKeyPass.Text)
    .status(CbStatus.ItemIndex)
   .save
end;

class function TFMNG0006BView.New: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFMNG0006BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result     := Self;
  FOperation := AValue;
end;

procedure TFMNG0006BView.save;
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

function TFMNG0006BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFMNG0006BView.showDataOnScreen;
begin
  if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
    Exit;

  FUserController.find(FSelectedRecord);

  TxUserId.Text       := FUserController.userId;
  TxName.Text         := FUserController.name;
  TxEmail.Text        := FUserController.email;
  TxUserName.Text     := FUserController.username;
  CbStatus.ItemIndex  := FUserController.status;

  TxCreatedAt.Text    := FUserController.createdAt;
  TxUpdatedAt.Text    := FUserController.updatedAt;

  if not(FOperation in [toDelete]) then
    BtConfirmar.Enabled := False;
end;

procedure TFMNG0006BView.showMessageDuplicatedMail;
begin
  TFacadeView.
    New
     .messagesFactoryView.typeMessage(tmWarning)
      .Messages(Format('Já existe um usuário com o email "%s" ',
        [TxEmail.Text]))
      .&end;
end;

procedure TFMNG0006BView.showMessageDuplicatedUserName;
begin
  TFacadeView.
    New
     .messagesFactoryView.typeMessage(tmWarning)
      .Messages(Format('Já existe um usuário "%s" ',
        [TxUserName.Text]))
      .&end;
end;

procedure TFMNG0006BView.TxEmailPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFMNG0006BView.TxKeyPassPropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFMNG0006BView.TxNamePropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFMNG0006BView.TxUserNamePropertiesChange(Sender: TObject);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFMNG0006BView.updateRecord;
begin
  FUserController
   .update
    .name(TxName.Text)
    .email(TxEmail.Text)
    .username(TxUserName.Text)
    .keypass(TxKeyPass.Text)
    .status(CbStatus.ItemIndex)
   .save
end;

function TFMNG0006BView.userMailExists: Boolean;
begin
  Result := False;

  case FOperation of
    toInsert:
      begin
        if FUserController.emailExists(TxEmail.Text) then
        begin
          showMessageDuplicatedMail;

          TxEmail.Clear;
          TxEmail.SetFocus;
          Result := True;
        end;
      end;

    toUpdate:
      begin
        if FUserController.emailExists(FUserController.code, TxEmail.Text) then
        begin
          showMessageDuplicatedMail;

          TxEmail.Clear;
          TxEmail.SetFocus;
          Result := True;
        end;
      end;

    toDuplicate:
      begin
        if FUserController.emailExists(TxEmail.Text) then
        begin
          showMessageDuplicatedMail;

          TxEmail.Clear;
          TxEmail.SetFocus;
          Result := True;
        end;
      end;
  end;
end;

function TFMNG0006BView.userNameExists: Boolean;
begin
  Result := False;

  case FOperation of
    toInsert:
      begin
        if FUserController.userNameExists(TxUserName.Text) then
        begin
          showMessageDuplicatedUserName;

          TxUserName.Clear;
          TxUserName.SetFocus;
          Result := True;
        end;
      end;

    toUpdate:
      begin
        if FUserController.userNameExists(FUserController.code, TxUserName.Text) then
        begin
          showMessageDuplicatedUserName;

          TxUserName.Clear;
          TxUserName.SetFocus;
          Result := True;
        end;
      end;

    toDuplicate:
      begin
        if FUserController.userNameExists(TxUserName.Text) then
        begin
          showMessageDuplicatedUserName;

          TxUserName.Clear;
          TxUserName.SetFocus;
          Result := True;
        end;
      end;
  end;
end;

end.
