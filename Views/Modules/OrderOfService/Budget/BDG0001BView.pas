unit BDG0001BView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, cxButtons, RzLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf, Types.Controllers,
  RzTabs, cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMemo,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxMaskEdit, cxDropDownEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxCalendar, Budget.Controller.Interf;

type
  TFBDG0001BView = class(TFBaseRegisterView, iBaseRegisterView)
    RzPageControl1: TRzPageControl;
    TSPrincipal: TRzTabSheet;
    TSFornecedores: TRzTabSheet;
    TSProdutos: TRzTabSheet;
    TxUpdatedDate: TcxTextEdit;
    TxCreatedDate: TcxTextEdit;
    LbUpdatedAt: TcxLabel;
    LbCreatedAt: TcxLabel;
    TxProductId: TcxTextEdit;
    LbExpenseId: TcxLabel;
    TxDescription: TcxMemo;
    LbDescription: TcxLabel;
    cxButton1: TcxButton;
    VwDados: TcxGridDBTableView;
    LVDados: TcxGridLevel;
    DBDados: TcxGrid;
    DBProdutos: TcxGrid;
    VWProdutos: TcxGridDBTableView;
    LVProdutos: TcxGridLevel;
    cxButton2: TcxButton;
    LbStatus: TcxLabel;
    EbEmissionDate: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    FBudgetController: iBudgetController;
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
  FBDG0001BView: TFBDG0001BView;

implementation

{$R *.dfm}

uses Facade.Controller;

{ TFBDG0001BView }

procedure TFBDG0001BView.BtConfirmarClick(Sender: TObject);
begin
  save;

  inherited;
end;

procedure TFBDG0001BView.deleteRecord;
begin

end;

procedure TFBDG0001BView.disableFields;
begin

end;

procedure TFBDG0001BView.duplicateRecord;
begin

end;

procedure TFBDG0001BView.&end;
begin
  showDataOnScreen;
  disableFields;
  showCurrentOperation;

  ShowModal;
end;

procedure TFBDG0001BView.FormCreate(Sender: TObject);
begin
  inherited;

  FBudgetController := TFacadeController.New.ModulesFacadeController.
    OrderOfServiceFactoryController.budgetController;
end;

procedure TFBDG0001BView.insertRecord;
begin
  FBudgetController
   .insert
    .companyId(FSessionCompany)
    .description(TxDescription.Text)
    .emissionDate(EbEmissionDate.Date)
    .userId(FSessionUser)
   .save;
end;

class function TFBDG0001BView.New: iBaseRegisterView;
begin
  Result := Self.Create(nil);
end;

function TFBDG0001BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
  Result := Self;
  FOperation := AValue;
end;

procedure TFBDG0001BView.save;
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

function TFBDG0001BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

procedure TFBDG0001BView.showDataOnScreen;
begin

end;

procedure TFBDG0001BView.updateRecord;
begin

end;

end.
