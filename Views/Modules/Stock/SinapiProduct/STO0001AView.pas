unit STO0001AView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxControls, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, System.ImageList, Vcl.ImgList, cxImageList,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxLabel,
  Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf,
  cxImageComboBox;

type
  TFSTO0001AView = class(TFBaseListView, iBaseListView)
    FdQDataCODE: TStringField;
    FdQDataPRODUCTID: TIntegerField;
    FdQDataCODE_SINAPI: TStringField;
    FdQDataDESCRIPTION: TStringField;
    FdQDataUNITMEASURE: TStringField;
    FdQDataORIGINPRICE: TStringField;
    FdQDataAVERAGEPRICE: TBCDField;
    FdQDataAVERAGEPRICE_SINAPI: TBCDField;
    FdQDataSTATUS: TIntegerField;
    FdQDataUSERNAME: TStringField;
    FdQDataCREATEDAT: TSQLTimeStampField;
    FdQDataUPDATEDAT: TSQLTimeStampField;
    VwDadosPRODUCTID: TcxGridDBColumn;
    VwDadosCODE_SINAPI: TcxGridDBColumn;
    VwDadosDESCRIPTION: TcxGridDBColumn;
    VwDadosUNITMEASURE: TcxGridDBColumn;
    VwDadosORIGINPRICE: TcxGridDBColumn;
    VwDadosAVERAGEPRICE: TcxGridDBColumn;
    VwDadosAVERAGEPRICE_SINAPI: TcxGridDBColumn;
    VwDadosSTATUS: TcxGridDBColumn;
    VwDadosUSERNAME: TcxGridDBColumn;
    VwDadosCREATEDAT: TcxGridDBColumn;
    VwDadosUPDATEDAT: TcxGridDBColumn;
    PnImport: TRzPanel;
    BtImport: TcxButton;
    procedure TxBuscarPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtInsertClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure BtShowClick(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtDuplicateClick(Sender: TObject);
    procedure BtImportClick(Sender: TObject);
  private
    { Private declarations }
  public
    class function New: iBaseListView;

    procedure insertRecord;
    procedure updateRecord;
    procedure showRecord;
    procedure deleteRecord;
    procedure duplicateRecord;

    procedure listRecords;

    procedure &end;
  end;

var
  FSTO0001AView: TFSTO0001AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views, STO0001CView;

{ TFSTO0001AView }

procedure TFSTO0001AView.BtDeleteClick(Sender: TObject);
begin
  inherited;

  {1} deleteRecord;
  {2} listRecords;
  {3} totalRecords;
end;

procedure TFSTO0001AView.BtDuplicateClick(Sender: TObject);
begin
  inherited;

  {1} duplicateRecord;
  {2} listRecords;
  {3} totalRecords;
end;

procedure TFSTO0001AView.BtImportClick(Sender: TObject);
begin
  inherited;
  TFSTO0001CView.New.&end;

  {1} listRecords;
  {2} totalRecords;
end;

procedure TFSTO0001AView.BtInsertClick(Sender: TObject);
begin
  inherited;

  {1} insertRecord;
  {2} listRecords;
  {3} totalRecords;
end;

procedure TFSTO0001AView.BtShowClick(Sender: TObject);
begin
  inherited;

  {1} showRecord;
  {2} listRecords;
  {3} totalRecords;
end;

procedure TFSTO0001AView.BtUpdateClick(Sender: TObject);
begin
  inherited;

  {1} updateRecord;
  {2} listRecords;
  {3} totalRecords;
end;

procedure TFSTO0001AView.deleteRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .stockFactory
    .showProgramOfRegister(trSTO0001BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFSTO0001AView.duplicateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .stockFactory
    .showProgramOfRegister(trSTO0001BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFSTO0001AView.&end;
begin

  Show;
end;

procedure TFSTO0001AView.FormCreate(Sender: TObject);
begin
  inherited;
  FColumnStatus := VwDadosSTATUS;
  FdQData.Connection := FFdConnection;
end;

procedure TFSTO0001AView.FormShow(Sender: TObject);
begin
  inherited;

  FFieldOrder := 'DESCRIPTION';

  {1} listRecords;
  {2} totalRecords;
end;

procedure TFSTO0001AView.insertRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .stockFactory
    .showProgramOfRegister(trSTO0001BView)
     .operation(FOperation)
     .&end;
end;

procedure TFSTO0001AView.listRecords;
begin
  FdQData.ParamByName('companyId').AsString := FSessionCompany;
  FdQData.Close;
  FdQData.Open();
end;

class function TFSTO0001AView.New: iBaseListView;
begin
   Result := Self.Create(nil);
end;

procedure TFSTO0001AView.showRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .stockFactory
    .showProgramOfRegister(trSTO0001BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFSTO0001AView.TxBuscarPropertiesChange(Sender: TObject);
begin
  inherited;

  filterRecords;
  totalRecords;
end;

procedure TFSTO0001AView.updateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .stockFactory
    .showProgramOfRegister(trSTO0001BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

end.
