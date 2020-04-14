unit ORD0003AView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxControls, cxContainer,
  cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, System.ImageList,
  Vcl.ImgList, cxImageList,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, cxClasses, cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit,
  cxLabel,
  Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
  Base.View.interf, cxImageComboBox;

type
  TFORD0003AView = class(TFBaseListView, iBaseListView)
    FdQDataCODE: TStringField;
    FdQDataSERVICEPROVIDEDID: TIntegerField;
    FdQDataPROVIDEDAT: TDateField;
    FdQDataCLIENTNAME: TStringField;
    FdQDataCREATEDAT: TSQLTimeStampField;
    FdQDataUPDATEDAT: TSQLTimeStampField;
    VwDadosSERVICEPROVIDEDID: TcxGridDBColumn;
    VwDadosPROVIDEDAT: TcxGridDBColumn;
    VwDadosCLIENTNAME: TcxGridDBColumn;
    VwDadosTOTALHOURS: TcxGridDBColumn;
    VwDadosTOTAL: TcxGridDBColumn;
    VwDadosCREATEDAT: TcxGridDBColumn;
    VwDadosUPDATEDAT: TcxGridDBColumn;
    FdQDataUSERNAME: TStringField;
    FdQDataSTATUS: TIntegerField;
    VwDadosSTATUS: TcxGridDBColumn;
    VwDadosUSERNAME: TcxGridDBColumn;
    FdQDataTOTAL: TFMTBCDField;
    FdQDataSERVICENAME: TStringField;
    VwDadosSERVICENAME: TcxGridDBColumn;
    FdQDataTOTALHOURS: TStringField;
    VwDadosTOTALKM: TcxGridDBColumn;
    FdQDataTOTALKM: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TxBuscarPropertiesChange(Sender: TObject);
    procedure BtInsertClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure BtShowClick(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtDuplicateClick(Sender: TObject);
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
  FORD0003AView: TFORD0003AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;

{ TFORD0003AView }

procedure TFORD0003AView.BtDeleteClick(Sender: TObject);
begin
  inherited;

  {1 } deleteRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFORD0003AView.BtDuplicateClick(Sender: TObject);
begin
  inherited;

  {1 } duplicateRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFORD0003AView.BtInsertClick(Sender: TObject);
begin
  inherited;

  {1 } insertRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFORD0003AView.BtShowClick(Sender: TObject);
begin
  inherited;

  {1 } showRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFORD0003AView.BtUpdateClick(Sender: TObject);
begin
  inherited;

  {1 } updateRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFORD0003AView.deleteRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .orderOfServiceFactory
    .showProgramOfRegister(trORD0003BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFORD0003AView.duplicateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .orderOfServiceFactory
    .showProgramOfRegister(trORD0003BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFORD0003AView.&end;
begin


  Show;
end;

procedure TFORD0003AView.FormCreate(Sender: TObject);
begin
  inherited;
  FColumnStatus      := VwDadosSTATUS;
  FdQData.Connection := FFdConnection;
end;

procedure TFORD0003AView.FormShow(Sender: TObject);
begin
  inherited;
  FFieldOrder := 'PROVIDEDAT';

  {1 } listRecords;
  {2 } totalRecords;
end;

procedure TFORD0003AView.insertRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .orderOfServiceFactory
    .showProgramOfRegister(trORD0003BView)
     .operation(FOperation)
     .&end;
end;

procedure TFORD0003AView.listRecords;
begin
    FdQData.ParamByName('companyId').AsString := FSessionCompany;
    FdQData.Close;
    FdQData.Open();
end;

class function TFORD0003AView.New: iBaseListView;
begin
  Result := Self.Create(nil);
end;

procedure TFORD0003AView.showRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .orderOfServiceFactory
    .showProgramOfRegister(trORD0003BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFORD0003AView.TxBuscarPropertiesChange(Sender: TObject);
begin
  inherited;

  filterRecords;
  totalRecords;
end;

procedure TFORD0003AView.updateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .orderOfServiceFactory
    .showProgramOfRegister(trORD0003BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

end.
