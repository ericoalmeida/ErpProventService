unit MNG0001AView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle,
  cxControls, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxClasses,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid,
  cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses,
  Vcl.ExtCtrls, RzPanel, ormbr.container.DataSet.interfaces,
  ormbr.container.fdmemtable,
  TGERBAIRRO.Entity.Model, Base.View.interf, FireDAC.Stan.Async, FireDAC.DApt,
  dxSkinOffice2016Colorful, dxSkinOffice2016Dark;

type
  TFMNG0001AView = class(TFBaseListView, iBaseListView)
    FdDataBAIRROID: TIntegerField;
    FdDataDESCRICAO: TStringField;
    FdDataDATACADASTRO: TDateTimeField;
    FdDataDATAATUALIZACAO: TDateTimeField;
    VwDadosBAIRROID: TcxGridDBColumn;
    VwDadosDESCRICAO: TcxGridDBColumn;
    VwDadosDATACADASTRO: TcxGridDBColumn;
    VwDadosDATAATUALIZACAO: TcxGridDBColumn;
    FdDataCODIGO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TxBuscarPropertiesChange(Sender: TObject);
    procedure BtInsertClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure BtShowClick(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtDuplicateClick(Sender: TObject);
  private
    FContainer: IContainerDataSet<TTGERBAIRRO>;
  public
    class function new: iBaseListView;

    procedure insertRecord;
    procedure updateRecord;
    procedure showRecord;
    procedure deleteRecord;
    procedure duplicateRecord;

    procedure listRecords;

    procedure &end;
  end;

var
  FMNG0001AView: TFMNG0001AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;

procedure TFMNG0001AView.BtDeleteClick(Sender: TObject);
begin
  inherited;
  deleteRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0001AView.BtDuplicateClick(Sender: TObject);
begin
  inherited;
  duplicateRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0001AView.BtInsertClick(Sender: TObject);
begin
  inherited;
  insertRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0001AView.BtShowClick(Sender: TObject);
begin
  inherited;
  showRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0001AView.BtUpdateClick(Sender: TObject);
begin
  inherited;
  updateRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0001AView.deleteRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0001BView )
     .operation(FOperation)
     .selectedRecord(FdDataCODIGO.AsString)
     .&end;
end;

procedure TFMNG0001AView.duplicateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0001BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODIGO.AsString)
     .&end;
end;

procedure TFMNG0001AView.&end;
begin

  show;
end;

procedure TFMNG0001AView.FormCreate(Sender: TObject);
begin
  inherited;
  FContainer := TContainerFDMemTable<TTGERBAIRRO>.Create(FConnection, FdData);
end;

procedure TFMNG0001AView.FormShow(Sender: TObject);
begin
  inherited;
  FFieldOrder := 'DESCRICAO';

  { 1 } listRecords;
  { 2 } totalRecords;
end;

procedure TFMNG0001AView.insertRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0001BView)
     .operation(FOperation)
     .&end;
end;

procedure TFMNG0001AView.listRecords;
begin
  FContainer.OpenWhere('', FFieldOrder);
end;

class function TFMNG0001AView.new: iBaseListView;
begin
  Result := Self.Create(nil);
end;

procedure TFMNG0001AView.showRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0001BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODIGO.AsString)
     .&end;
end;

procedure TFMNG0001AView.TxBuscarPropertiesChange(Sender: TObject);
begin
  inherited;

  filterRecords;
  totalRecords;
end;

procedure TFMNG0001AView.updateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0001BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODIGO.AsString)
     .&end;
end;

end.
