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
  Base.View.interf, TMNGCOUNTRY.Entity.Model,  ormbr.container.DataSet.interfaces,
  ormbr.container.fdmemtable, FireDAC.Stan.Async, FireDAC.DApt, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Silver, dxSkinDarkRoom, dxSkinDarkSide, System.ImageList, Vcl.ImgList, cxImageList;

type
  TFMNG0002AView = class(TFBaseListView, iBaseListView)
    FdDataCODE: TStringField;
    FdDataCOUNTRYID: TIntegerField;
    FdDataNAME: TStringField;
    FdDataCREATEDAT: TSQLTimeStampField;
    FdDataUPDATEDAT: TSQLTimeStampField;
    VwDadosCOUNTRYID: TcxGridDBColumn;
    VwDadosNAME: TcxGridDBColumn;
    VwDadosCREATEDAT: TcxGridDBColumn;
    VwDadosUPDATEDAT: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TxBuscarPropertiesChange(Sender: TObject);
    procedure BtInsertClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure BtShowClick(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtDuplicateClick(Sender: TObject);
  private
    FContainer: IContainerDataSet<TTMNGCOUNTRY>;
  public
    { Public declarations }
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
  FMNG0002AView: TFMNG0002AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;

{ TFMNG0002AView }

procedure TFMNG0002AView.BtDeleteClick(Sender: TObject);
begin
  inherited;
  deleteRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.BtDuplicateClick(Sender: TObject);
begin
  inherited;
  duplicateRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.BtInsertClick(Sender: TObject);
begin
  inherited;
  insertRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.BtShowClick(Sender: TObject);
begin
  inherited;
  showRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.BtUpdateClick(Sender: TObject);
begin
  inherited;
  updateRecord;
  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.deleteRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0002BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODE.AsString)
     .&end;
end;

procedure TFMNG0002AView.duplicateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0002BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODE.AsString)
     .&end;
end;

procedure TFMNG0002AView.&end;
begin

  Show;
end;

procedure TFMNG0002AView.FormCreate(Sender: TObject);
begin
  inherited;
  FContainer := TContainerFDMemTable<TTMNGCOUNTRY>.Create(FConnection, FdData);
end;

procedure TFMNG0002AView.FormShow(Sender: TObject);
begin
  inherited;
  FFieldOrder := 'NAME';

  listRecords;
  totalRecords;
end;

procedure TFMNG0002AView.insertRecord;
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

procedure TFMNG0002AView.showRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0002BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODE.AsString)
     .&end;
end;

procedure TFMNG0002AView.TxBuscarPropertiesChange(Sender: TObject);
begin
  inherited;

  filterRecords;
  totalRecords;
end;

procedure TFMNG0002AView.updateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0002BView)
     .operation(FOperation)
     .selectedRecord(FdDataCODE.AsString)
     .&end;
end;

end.
