unit MNG0002AView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  cxControls, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxClasses,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
  Base.View.interf, TGERPAIS.Entity.Model,  ormbr.container.DataSet.interfaces,
  ormbr.container.fdmemtable;

type
  TFMNG0002AView = class(TFBaseListView, iBaseListView)
    FdDataCODIGO: TStringField;
    FdDataPAISID: TIntegerField;
    FdDataDESCRICAO: TStringField;
    FdDataDATACADASTRO: TDateTimeField;
    FdDataDATAATUALIZACAO: TDateTimeField;
    VwDadosPAISID: TcxGridDBColumn;
    VwDadosDESCRICAO: TcxGridDBColumn;
    VwDadosDATACADASTRO: TcxGridDBColumn;
    VwDadosDATAATUALIZACAO: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TxBuscarPropertiesChange(Sender: TObject);
    procedure BtInsertClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure BtShowClick(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtDuplicateClick(Sender: TObject);
  private
    FContainer: IContainerDataSet<TTGERPAIS>;
  public
    { Public declarations }
    class function new: iBaseListView;

    procedure insert;
    procedure update;
    procedure recover;
    procedure delete;
    procedure duplicate;
    procedure listRecords;
    procedure totalRecords;

    procedure &end;
  end;

var
  FMNG0002AView: TFMNG0002AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;

{ TFMNG0002AView }

procedure TFMNG0002AView.BtDeleteClick(Sender: TObject);
begin
  inherited;
  delete;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.BtDuplicateClick(Sender: TObject);
begin
  inherited;
  duplicate;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.BtInsertClick(Sender: TObject);
begin
  inherited;
  insert;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.BtShowClick(Sender: TObject);
begin
  inherited;
  recover;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.BtUpdateClick(Sender: TObject);
begin
  inherited;
  update;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.delete;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0002BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODIGO.AsString)
     .&end;
end;

procedure TFMNG0002AView.duplicate;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0002BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODIGO.AsString)
     .&end;
end;

procedure TFMNG0002AView.&end;
begin

  Show;
end;

procedure TFMNG0002AView.FormCreate(Sender: TObject);
begin
  inherited;
  FContainer := TContainerFDMemTable<TTGERPAIS>.Create(FConnection, FdData);
end;

procedure TFMNG0002AView.FormShow(Sender: TObject);
begin
  inherited;
  FFieldOrder := 'DESCRICAO';

  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.insert;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0002BView)
     .operation(FOperation)
     .&end;
end;

procedure TFMNG0002AView.listRecords;
begin
 FContainer.OpenWhere('', FFieldOrder);
end;

class function TFMNG0002AView.new: iBaseListView;
begin
  Result := Self.Create(nil);
end;

procedure TFMNG0002AView.recover;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0002BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODIGO.AsString)
     .&end;
end;

procedure TFMNG0002AView.totalRecords;
begin
  FTotalRecords := DsData.DataSet.RecordCount;

  LbTotalRegistros.Caption := Format('Mostrando de 1 até %d de %d registros',
    [FTotalRecords, FTotalRecords]);
end;

procedure TFMNG0002AView.TxBuscarPropertiesChange(Sender: TObject);
begin
  inherited;
  filterRecords;
  totalRecords;
end;

procedure TFMNG0002AView.update;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0002BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODIGO.AsString)
     .&end;
end;

end.
