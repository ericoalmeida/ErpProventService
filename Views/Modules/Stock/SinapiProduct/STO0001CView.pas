unit STO0001CView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, cxControls, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons, RzLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Datasnap.DBClient, ImportSinapiProduct.Controller.interf,
  Base.View.interf;

type
  iImportSinapiProductView = interface
    ['{7B70317A-76D1-40F2-B3D7-990D3044D427}']

    procedure &end;
  end;

  TFSTO0001CView = class(TForm, iImportSinapiProductView)
    PnContainer: TRzPanel;
    PnHeader: TRzPanel;
    ImTitle: TImage;
    LbTitle: TRzLabel;
    PnProgram: TRzPanel;
    LbProgram: TRzLabel;
    PnContainerBody: TRzPanel;
    PnFooterBody: TRzPanel;
    PnButtonCancel: TRzPanel;
    BtSair: TcxButton;
    PnButtonConfirm: TRzPanel;
    BtConfirmar: TcxButton;
    PnContent: TRzPanel;
    PnGridHeader: TRzPanel;
    PnGridFooter: TRzPanel;
    LbTotalRegistros: TRzLabel;
    PnGrid: TRzPanel;
    DbDados: TcxGrid;
    VwDados: TcxGridDBTableView;
    LvDados: TcxGridLevel;
    PnImport: TRzPanel;
    BtImport: TcxButton;
    DsData: TDataSource;
    VwDadosCODE_SINAPI: TcxGridDBColumn;
    VwDadosDESCRIPTION: TcxGridDBColumn;
    StGridStyles: TcxStyleRepository;
    StHeader: TcxStyle;
    stContentOdd: TcxStyle;
    stContentEven: TcxStyle;
    StInactive: TcxStyle;
    StSelection: TcxStyle;
    StIndicator: TcxStyle;
    StDefaultColumn: TcxStyle;
    StDefaultHeaderColumn: TcxStyle;
    StColumnSelected: TcxStyle;
    StHeaderColumnSelected: TcxStyle;
    CdData: TClientDataSet;
    CdDataCODE_SINAPI: TStringField;
    CdDataDESCRIPTION: TStringField;
    CdDataUNITMEASURE: TStringField;
    CdDataORIGINPRICE: TStringField;
    CdDataAVERAGEPRICE_SINAPI: TBCDField;
    VwDadosUNITMEASURE: TcxGridDBColumn;
    OdChooseFile: TOpenDialog;
    procedure BtSairClick(Sender: TObject);
    procedure BtImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
     FRecordShow: Integer;
     FMessage: iBaseMessageView;
     FImportSinapiProductController: iImportSinapiProductController;

    function removeWhiteSpacesOnText(AValue: string): string;
    function formatTextInAPrice(AValue: string): string;

    procedure importCSVFile(AFile: string);
    procedure totalRecords;
    procedure totalImportRecords;
    procedure importSinapiProducts;
  public
    class function New: iImportSinapiProductView;

    procedure &end;
  end;

var
  FSTO0001CView: TFSTO0001CView;

implementation

{$R *.dfm}

uses Facade.Controller, Types.Views, Facade.View;

{ TFSTO0001CView }

procedure TFSTO0001CView.BtConfirmarClick(Sender: TObject);
begin
  importSinapiProducts;
end;

procedure TFSTO0001CView.BtImportClick(Sender: TObject);
begin
  try
    if OdChooseFile.Execute then
    begin
      importCSVFile(OdChooseFile.FileName);
    end;

  except
    on E: Exception do
    begin
      CdData.emptyDataset;

      FMessage
       .messages('Arquivo selecionado é inválido!')
       .&end;
    end;

  end;

  totalRecords;
end;

procedure TFSTO0001CView.BtSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFSTO0001CView.&end;
begin
  ShowModal;
end;

function TFSTO0001CView.formatTextInAPrice(AValue: string): string;
begin
  AValue := StringReplace(AValue, '.', '', [rfReplaceAll, rfIgnoreCase]);
  AValue := StringReplace(AValue, '', '0,00', [rfReplaceAll, rfIgnoreCase]);

  Result := AValue;
end;

procedure TFSTO0001CView.FormCreate(Sender: TObject);
begin
  FImportSinapiProductController :=
    TFacadeController.New.ModulesFacadeController.StockFactoryController.
    importSinapiProductController;

  FMessage := TFacadeView.New.messagesFactoryView.typeMessage
    (tmWarning);
end;

procedure TFSTO0001CView.importCSVFile(AFile: string);
var
  ArquivoCSV: TextFile;
  I: Integer;
  Linha: String;
  linhasArquivo: TStringList;

  function MontaValor: String;
  var
    ValorMontado: String;
  begin
    ValorMontado := '';

    inc(I);

    While Linha[I] >= ' ' do
    begin
      If Linha[I] = '|' then
        break;

      ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;

    result := Trim(ValorMontado);
  end;
begin
  AssignFile(ArquivoCSV, AFile);
  linhasArquivo := TStringList.Create;

  try
    Reset(ArquivoCSV);
    Readln(ArquivoCSV, Linha);
    linhasArquivo.LoadFromFile(AFile);

    CdData.DisableControls;

    while not Eoln(ArquivoCSV) do
    begin
      I := 0;

      CdData.Append;
      CdDataCODE_SINAPI.AsString := MontaValor;
      CdDataDESCRIPTION.AsString := removeWhiteSpacesOnText(AnsiUpperCase(MontaValor));
      CdDataUNITMEASURE.AsString := AnsiUpperCase(MontaValor);
      CdDataORIGINPRICE.AsString := AnsiUpperCase(MontaValor);
      CdDataAVERAGEPRICE_SINAPI.AsCurrency := StrToFloat(formatTextInAPrice(MontaValor));
      CdData.Post;

      Application.ProcessMessages;

      Readln(ArquivoCSV, Linha);
    end;

  finally
    CloseFile(ArquivoCSV);
    linhasArquivo.Free;

    CdData.EnableControls;
    CdData.First;
  end;
end;

procedure TFSTO0001CView.importSinapiProducts;
begin
  CdData.First;

  FRecordShow := 0;

  while not(CdData.Eof) do
   begin
     FRecordShow := FRecordShow + 1;
     totalImportRecords;
     Application.ProcessMessages;

     FImportSinapiProductController
      .find(CdDataCODE_SINAPI.AsString)
       .import
        .currentProduct(FImportSinapiProductController.recordFound)
         .companyId('{4FC5A103-F75F-43E9-AA50-E454DA804E20}')
         .codeSinapi(CdDataCODE_SINAPI.AsString)
         .description(CdDataDESCRIPTION.AsString)
         .unitMeasure(CdDataUNITMEASURE.AsString)
         .originPrice(CdDataORIGINPRICE.AsString)
         .averagePriceSinapi(CdDataAVERAGEPRICE_SINAPI.AsCurrency)
         .status(0)
         .userId('{177524BA-A3DA-4ECC-BFA4-388A3A06DF9F}')
        .save;

     CdData.Next;
   end;

 Close;
end;

class function TFSTO0001CView.New: iImportSinapiProductView;
begin
  Result := Self.Create(nil);
end;

function TFSTO0001CView.removeWhiteSpacesOnText(AValue: string): string;
var
  tamanhoTexto: Integer;
  I: Integer;
begin
  tamanhoTexto := Length(AValue);

  for I := 0 to Pred(tamanhoTexto) do
  begin
    AValue := StringReplace(AValue, '  ', '', [rfReplaceAll, rfIgnoreCase]);
    AValue := StringReplace(AValue, ';', '', [rfReplaceAll, rfIgnoreCase]);
  end;

  Result := AValue;
end;

procedure TFSTO0001CView.totalImportRecords;
var
  FTotalRecords: Integer;
begin
  FTotalRecords := DsData.DataSet.RecordCount;

  LbTotalRegistros.Caption := Format('Importando %d de %d registros',
    [FRecordShow, FTotalRecords]);
end;

procedure TFSTO0001CView.totalRecords;
var
  FTotalRecords: Integer;
begin
  FTotalRecords := DsData.DataSet.RecordCount;
  FRecordShow   := 1;

  LbTotalRegistros.Caption := Format('Mostrando de %d até %d de %d registros',
    [FRecordShow, FTotalRecords, FTotalRecords]);
end;

end.
