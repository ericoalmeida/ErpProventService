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
   Datasnap.DBClient, BudgetProviders.Controller.Interf, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataMFirebird.Model,
  BudgetProducts.Controller.Interf;

type
   TFBDG0001BView = class(TFBaseRegisterView, iBaseRegisterView)
    Paginas: TRzPageControl;
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
    FDQuery: TFDQuery;
    cxButton3: TcxButton;
    Panel1: TPanel;
    Panel2: TPanel;
    cxButton4: TcxButton;
    CDSProdutos: TClientDataSet;
    CDSProdutosCODE: TStringField;
    CDSProdutosPRODUCTID: TIntegerField;
    CDSProdutosDESCRIPTION: TStringField;
    CDSProdutosCODIGO_SINAPI: TStringField;
    CDSProdutosQTDE: TFloatField;
    VWProdutosCODIGO_SINAPI: TcxGridDBColumn;
    VWProdutosQTDE: TcxGridDBColumn;
      procedure FormCreate(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
      procedure TxDescriptionPropertiesChange(Sender: TObject);
      procedure EbEmissionDatePropertiesChange(Sender: TObject);
      procedure cxButton1Click(Sender: TObject);
      procedure CdsProdutosAfterPost(DataSet: TDataSet);
      procedure CdsFornecedorAfterPost(DataSet: TDataSet);
      procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure CdsFornecedorAfterDelete(DataSet: TDataSet);
    procedure CdsProdutosAfterDelete(DataSet: TDataSet);
    procedure cxButton4Click(Sender: TObject);
    procedure CDSProdutosAfterEdit(DataSet: TDataSet);
   private
      { Private declarations }
      FBudgetController: iBudgetController;
      FBudgetProvidersController: IBudgetProvidersController;
      FBudgetProductsController: IBudgetProductsController;


    procedure saveProviders;
    procedure loadProviders;

    procedure saveProducts;
    procedure loadProducts;       
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

procedure TFBDG0001BView.CdsFornecedorAfterDelete(DataSet: TDataSet);
begin
  inherited;
  changeDataAnyFields;
end;

procedure TFBDG0001BView.CdsFornecedorAfterPost(DataSet: TDataSet);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFBDG0001BView.CdsProdutosAfterDelete(DataSet: TDataSet);
begin
  inherited;
   changeDataAnyFields;
end;

procedure TFBDG0001BView.CDSProdutosAfterEdit(DataSet: TDataSet);
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
   CdsProdutosCODE.AsString          := FProductController.code;
   CdsProdutosPRODUCTID.AsInteger    := FProductController.productId.ToInteger;
   CdsProdutosCODIGO_SINAPI.AsString := FProductController.codeSinapi;
   CdsProdutosDESCRIPTION.AsString   := FProductController.description;
   CDSProdutosQTDE.AsFloat           := 1;
   CdsProdutos.Post;
end;

procedure TFBDG0001BView.cxButton3Click(Sender: TObject);
begin
  inherited;

   CdsFornecedor.Delete;
end;

procedure TFBDG0001BView.cxButton4Click(Sender: TObject);
begin
  inherited;
  
  CdsProdutos.Delete;
end;

procedure TFBDG0001BView.deleteRecord;
begin
   FBudgetController.delete.save;
end;

procedure TFBDG0001BView.disableFields;
begin
   EbEmissionDate.Enabled := not(FOperation in [toShow, toDelete]);
   TxDescription.Enabled  := not(FOperation in [toShow, toDelete]);

   cxButton1.Enabled := not(FOperation in [toShow, toDelete]);
   cxButton2.Enabled := not(FOperation in [toShow, toDelete]);
   cxButton3.Enabled := not(FOperation in [toShow, toDelete]);
   cxButton4.Enabled := not(FOperation in [toShow, toDelete]);   
end;

procedure TFBDG0001BView.duplicateRecord;
begin
   FBudgetController.duplicate.companyId(FSessionCompany)
     .description(TxDescription.Text).emissionDate(EbEmissionDate.Date)
     .userId(FSessionUser).save;

     
   saveProviders;
   saveProducts;        
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

procedure TFBDG0001BView.saveProducts;
begin
  if CdsProdutos.IsEmpty then Exit;


  if FOperation in [toInsert, toDuplicate] then
    FBudgetProductsController.cleanOldRecords(FSessionCompany, FBudgetController.budgetCode)
  else
    FBudgetProductsController.cleanOldRecords(FSessionCompany, FBudgetController.code); 

  
  CdsProdutos.First;
  while not (CdsProdutos.Eof) do
  begin
    FBudgetProductsController
     .insert
      .companyId(FSessionCompany)
      .budgetId(FBudgetController.budgetCode)
      .productId(CdsProdutosCODE.AsString)
      .qtde(CDSProdutosQTDE.AsFloat)
      .userId(FSessionUser)
      .save;

    CdsProdutos.Next;
  end;
end;

procedure TFBDG0001BView.saveProviders;
begin
  if CdsFornecedor.IsEmpty then Exit;


  if FOperation in [toInsert, toDuplicate] then
    FBudgetProvidersController.cleanOldRecords(FSessionCompany, FBudgetController.budgetCode)
  else
    FBudgetProvidersController.cleanOldRecords(FSessionCompany, FBudgetController.code); 

  
  CdsFornecedor.First;
  while not (CdsFornecedor.Eof) do
  begin
    FBudgetProvidersController
     .insert
      .companyId(FSessionCompany)
      .budgetId(FBudgetController.budgetCode)
      .providerId(CdsFornecedorCODE.AsString)
      .userId(FSessionUser)
      .save;

    CdsFornecedor.Next;
  end;
end;

procedure TFBDG0001BView.FormCreate(Sender: TObject);
begin
   inherited;
   Paginas.ActivePage  := TSPrincipal;
   EbEmissionDate.Date := Now;

   FBudgetController := TFacadeController.New.ModulesFacadeController.
     OrderOfServiceFactoryController.budgetController;

   FBudgetProvidersController := TFacadeController.New.ModulesFacadeController.
     OrderOfServiceFactoryController.budgetProvidersController;

   FBudgetProductsController := TFacadeController.New.ModulesFacadeController.
     OrderOfServiceFactoryController.budgetProductsController;     
end;

procedure TFBDG0001BView.insertRecord;
begin
   FBudgetController.insert.companyId(FSessionCompany)
     .description(TxDescription.Text).emissionDate(EbEmissionDate.Date)
     .userId(FSessionUser).save;

     
   saveProviders;
   saveProducts;     
end;

procedure TFBDG0001BView.loadProducts;
begin
   with FDQuery do
   begin
      SQL.Clear;
      SQL.Add(
        'select                                                          ' +
        'b.code,                                                         ' +
        'b.productid,                                                    ' +
        'a.qtde,                                                         ' +
        'b.code_sinapi,                                                  ' +
        'b.description                                                   ' +
        'from                                                            ' +
        'tordbudgetproducts a                                            ' +
        'left join tstosinapiproduct b on (b.companyid = a.companyid)    ' +
        'and(b.code = a.productid)                                       ' +
        'where                                                           ' +
        Format('a.companyid = %s and a.budgetid = %s ',
        [QuotedStr(FSessionCompany), QuotedStr(FBudgetController.code)]));

      Open();

      if not(IsEmpty = True) then
      begin
         First;

         while not Eof do
         begin
            CdsProdutos.Append;
            CdsProdutosCODE.AsString          := FieldByName('code').AsString;
            CdsProdutosPRODUCTID.AsInteger    := FieldByName('productid').AsInteger;
            CDSProdutosQTDE.AsFloat           := FieldByName('qtde').AsFloat;
            CDSProdutosCODIGO_SINAPI.AsString := FieldByName('code_sinapi').AsString;
            CdsProdutosDESCRIPTION.AsString   := FieldByName('description').AsString;
            CdsProdutos.Post;

            Next;
         end;
      end;
   end;
end;

procedure TFBDG0001BView.loadProviders;
begin
   with FDQuery do
   begin
      SQL.Clear;
      SQL.Add(
        'select                                                  ' +
        'b.code,                                                 ' +
        'b.personid,                                             ' +
        'b.name                                                  ' +
        'from                                                    ' +
        'tordbudgetproviders a                                   ' +
        'left join tmngperson b on (b.companyid = a.companyid)   ' +
        'and(b.code = a.providerid)                              ' +
        'where                                                   ' +
        Format('a.companyid = %s and a.budgetid = %s ',
        [QuotedStr(FSessionCompany), QuotedStr(FBudgetController.code)]));

      Open();

      if not(IsEmpty = True) then
      begin
         First;

         while not Eof do
         begin
            CdsFornecedor.Append;
            CdsFornecedorCODE.AsString      :=  FieldByName('code').AsString;
            CdsFornecedorPERSONID.AsInteger := FieldByName('personid').AsInteger;;
            CdsFornecedorNAME.AsString      := FieldByName('name').AsString;;
            CdsFornecedor.Post;

            Next;
         end;
      end;
   end;
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


   loadProviders;
   loadProducts;

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

   saveProviders;  
   saveProducts;                
end;

end.
