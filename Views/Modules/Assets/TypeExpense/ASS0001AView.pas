unit ASS0001AView;

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
  Base.View.interf, TASSTYPEEXPENSE.Entity.Model, cxImageComboBox;

type
  TFASS0001AView = class(TFBaseListView, iBaseListView)
    FdQDataCODE: TStringField;
    FdQDataTYPEEXPENSEID: TIntegerField;
    FdQDataDESCRIPTION: TStringField;
    FdQDataSTATUS: TIntegerField;
    FdQDataCREATEDAT: TSQLTimeStampField;
    FdQDataUPDATEDAT: TSQLTimeStampField;
    VwDadosTYPEEXPENSEID: TcxGridDBColumn;
    VwDadosDESCRIPTION: TcxGridDBColumn;
    VwDadosSTATUS: TcxGridDBColumn;
    VwDadosUSERNAME: TcxGridDBColumn;
    VwDadosCREATEDAT: TcxGridDBColumn;
    VwDadosUPDATEDAT: TcxGridDBColumn;
    FdQDataUSERNAME: TStringField;
    procedure BtInsertClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure BtShowClick(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtDuplicateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TxBuscarPropertiesChange(Sender: TObject);
  private

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
  FASS0001AView: TFASS0001AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;
{ TFASS0001AView }

procedure TFASS0001AView.BtDeleteClick(Sender: TObject);
begin
  inherited;

  {1 } deleteRecord;
  {2 } listRecords;
  {3 } totalRecords;
  {4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFASS0001AView.BtDuplicateClick(Sender: TObject);
begin
  inherited;

  {1 } duplicateRecord;
  {2 } listRecords;
  {3 } totalRecords;
  {4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFASS0001AView.BtInsertClick(Sender: TObject);
begin
  inherited;

  {1 } insertRecord;
  {2 } listRecords;
  {3 } totalRecords;
  {4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFASS0001AView.BtShowClick(Sender: TObject);
begin
  inherited;

  {1 } showRecord;
  {2 } listRecords;
  {3 } totalRecords;
  {4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFASS0001AView.BtUpdateClick(Sender: TObject);
begin
  inherited;

  {1 } updateRecord;
  {2 } listRecords;
  {3 } totalRecords;
  {4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFASS0001AView.deleteRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .assetsFactoryView
    .showProgramOfRegister(trASS0001BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFASS0001AView.duplicateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .assetsFactoryView
    .showProgramOfRegister(trASS0001BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFASS0001AView.&end;
begin

  Show;
end;

procedure TFASS0001AView.FormCreate(Sender: TObject);
begin
  inherited;
  FColumnStatus      := VwDadosSTATUS;
  FdQData.Connection := FFdConnection;
end;

procedure TFASS0001AView.FormShow(Sender: TObject);
begin
  inherited;
  FFieldOrder := 'DESCRIPTION';

  {1 } listRecords;
  {2 } totalRecords;
  {3 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFASS0001AView.insertRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .assetsFactoryView
    .showProgramOfRegister(trASS0001BView)
     .operation(FOperation)
     .&end;
end;

procedure TFASS0001AView.listRecords;
begin
    FdQData.ParamByName('companyId').AsString := FSessionCompany;
    FdQData.Close;
    FdQData.Open();
end;

class function TFASS0001AView.New: iBaseListView;
begin
  Result := Self.Create(nil);
end;

procedure TFASS0001AView.showRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .assetsFactoryView
    .showProgramOfRegister(trASS0001BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFASS0001AView.TxBuscarPropertiesChange(Sender: TObject);
begin
  inherited;

  {1 } filterRecords;
  {2 } totalRecords;
end;

procedure TFASS0001AView.updateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .assetsFactoryView
    .showProgramOfRegister(trASS0001BView)
     .operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

end.
