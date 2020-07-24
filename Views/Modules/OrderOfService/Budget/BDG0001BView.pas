unit BDG0001BView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
   cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
   dxSkinDarkRoom,
   dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
   System.Actions, Vcl.ActnList, Vcl.StdCtrls, cxButtons, RzLabel,
   dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf, Types.Controllers,
   RzTabs, cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMemo,
   cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
   cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
   cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
   cxGridTableView, cxGridDBTableView, cxGrid, cxMaskEdit, cxDropDownEdit,
   Vcl.ComCtrls, dxCore, cxDateUtils, cxCalendar, Budget.Controller.interf,
   Datasnap.DBClient;

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
      TxBudgetId: TcxTextEdit;
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
      CdsFornecedor: TClientDataSet;
      CdsFornecedorCODE: TStringField;
      CdsFornecedorPERSONID: TIntegerField;
      CdsFornecedorNAME: TStringField;
      DsFornecedores: TDataSource;
      DsProdutos: TDataSource;
      VwDadosPERSONID: TcxGridDBColumn;
      VwDadosNAME: TcxGridDBColumn;
      VWProdutosPRODUCTID: TcxGridDBColumn;
      VWProdutosDESCRIPTION: TcxGridDBColumn;
      StGridStyles: TcxStyleRepository;
      StHeader: TcxStyle;
      stContentOdd: TcxStyle;
      stContentEven: TcxStyle;
      StInactive: TcxStyle;
      StSelection: TcxStyle;
      StIndicator: TcxStyle;
      StDefaultColumn: TcxStyle;
      StColumnSelected: TcxStyle;
      StHeaderColumnSelected: TcxStyle;
      StDefaultHeaderColumn: TcxStyle;
      CdsProdutos: TClientDataSet;
      CdsProdutosCODE: TStringField;
      CdsProdutosPRODUCTID: TIntegerField;
      CdsProdutosDESCRIPTION: TStringField;
      CdsProdutosCODIGO_SINAPI: TStringField;
      procedure FormCreate(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
      procedure TxDescriptionPropertiesChange(Sender: TObject);
      procedure EbEmissionDatePropertiesChange(Sender: TObject);
      procedure cxButton1Click(Sender: TObject);
      procedure CdsProdutosAfterPost(DataSet: TDataSet);
      procedure CdsFornecedorAfterPost(DataSet: TDataSet);
      procedure cxButton2Click(Sender: TObject);
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

uses Facade.Controller, Person.Controller.interf, Facade.View, Types.Views,
   SinapiProduct.Controller.interf;

{ TFBDG0001BView }

procedure TFBDG0001BView.BtConfirmarClick(Sender: TObject);
begin
   save;

   inherited;
end;

procedure TFBDG0001BView.CdsFornecedorAfterPost(DataSet: TDataSet);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFBDG0001BView.CdsProdutosAfterPost(DataSet: TDataSet);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFBDG0001BView.cxButton1Click(Sender: TObject);
var
   FProviderController: iPersonController;
   codeProvider: string;
begin
   inherited;

   FProviderController := TFacadeController.New.ModulesFacadeController.
     ManagmentFactoryController.personController;

   codeProvider := TFacadeView.New.modulesFacadeView.payFactory.
     showProgramOfSearch(tsPAY0001CView).showSearch.&end;

   if codeProvider = EmptyStr then
      Exit;

   FProviderController.find(codeProvider);

   if CdsFornecedor.Locate('CODE', FProviderController.code,
     [loCaseInsensitive, loPartialKey]) then
      Exit;

   CdsFornecedor.Append;
   CdsFornecedorCODE.AsString := FProviderController.code;
   CdsFornecedorPERSONID.AsInteger := FProviderController.personId.ToInteger;
   CdsFornecedorNAME.AsString := FProviderController.name;
   CdsFornecedor.Post;
end;

procedure TFBDG0001BView.cxButton2Click(Sender: TObject);
var
   FProductController: iSinapiProductController;
   codeProduct: string;
begin
   inherited;

   FProductController := TFacadeController.New.ModulesFacadeController.
     StockFactoryController.sinapiProductController;

   codeProduct := TFacadeView.New.modulesFacadeView.stockFactory.
     showProgramOfSearch(tsSTO0001DView).showSearch.&end;

   if codeProduct = EmptyStr then
      Exit;

   FProductController.find(codeProduct);

   if CdsFornecedor.Locate('CODE', FProductController.code,
     [loCaseInsensitive, loPartialKey]) then
      Exit;

   CdsProdutos.Append;
   CdsProdutosCODE.AsString := FProductController.code;
   CdsProdutosPRODUCTID.AsInteger := FProductController.productId.ToInteger;
   CdsProdutosCODIGO_SINAPI.AsString := FProductController.codeSinapi;
   CdsProdutosDESCRIPTION.AsString := FProductController.description;
   CdsProdutos.Post;
end;

procedure TFBDG0001BView.deleteRecord;
begin

end;

procedure TFBDG0001BView.disableFields;
begin
   EbEmissionDate.Enabled := not(FOperation in [toShow, toDelete]);
   TxDescription.Enabled := not(FOperation in [toShow, toDelete]);
   TxCreatedDate.Enabled := not(FOperation in [toShow, toDelete]);
   TxUpdatedDate.Enabled := not(FOperation in [toShow, toDelete]);
end;

procedure TFBDG0001BView.duplicateRecord;
begin

end;

procedure TFBDG0001BView.EbEmissionDatePropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
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
   FBudgetController.insert.companyId(FSessionCompany)
     .description(TxDescription.Text).emissionDate(EbEmissionDate.Date)
     .userId(FSessionUser).save;
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
   if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
      Exit;

   FBudgetController.find(FSelectedRecord);

   TxBudgetId.Text := FBudgetController.budgetId;
   EbEmissionDate.Date := FBudgetController.emissionDate;
   TxDescription.Text := FBudgetController.description;
   TxCreatedDate.Text := FBudgetController.createdAt;
   TxUpdatedDate.Text := FBudgetController.updatedAt;

   if not(FOperation in [toDelete]) then
      BtConfirmar.Enabled := False;
end;

procedure TFBDG0001BView.TxDescriptionPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFBDG0001BView.updateRecord;
begin
   FBudgetController.update.companyId(FSessionCompany)
     .description(TxDescription.Text).emissionDate(EbEmissionDate.Date)
     .userId(FSessionUser).save;
end;

end.
