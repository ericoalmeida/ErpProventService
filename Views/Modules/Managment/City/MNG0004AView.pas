unit MNG0004AView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Silver,
  cxControls, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, cxClasses, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons, RzLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf;

type
  TFMNG0004AView = class(TFBaseListView, iBaseListView)
    FdQDataCODIGO: TStringField;
    FdQDataCITYID: TIntegerField;
    FdQDataNAME: TStringField;
    FdQDataZIPCODE: TStringField;
    FdQDataIBGECODE: TIntegerField;
    FdQDataSTATEID: TStringField;
    FdQDataSTATENAME: TStringField;
    FdQDataCREATEDAT: TSQLTimeStampField;
    FdQDataUPDATEDAT: TSQLTimeStampField;
    VwDadosCITYID: TcxGridDBColumn;
    VwDadosNAME: TcxGridDBColumn;
    VwDadosZIPCODE: TcxGridDBColumn;
    VwDadosIBGECODE: TcxGridDBColumn;
    VwDadosSTATENAME: TcxGridDBColumn;
    VwDadosCREATEDAT: TcxGridDBColumn;
    VwDadosUPDATEDAT: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure BtInsertClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure BtShowClick(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtDuplicateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
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
  FMNG0004AView: TFMNG0004AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;

{ TFMNG0004AView }

procedure TFMNG0004AView.BtDeleteClick(Sender: TObject);
begin
  inherited;

  {1 } deleteRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFMNG0004AView.BtDuplicateClick(Sender: TObject);
begin
  inherited;

  {1 } duplicateRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFMNG0004AView.BtInsertClick(Sender: TObject);
begin
  inherited;

  {1 } insertRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFMNG0004AView.BtShowClick(Sender: TObject);
begin
  inherited;

  {1 } showRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFMNG0004AView.BtUpdateClick(Sender: TObject);
begin
  inherited;

  {1 } updateRecord;
  {2 } listRecords;
  {3 } totalRecords;
end;

procedure TFMNG0004AView.deleteRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0004BView)
     .operation(FOperation)
      .selectedRecord(FdQDataCODIGO.AsString)
     .&end;
end;

procedure TFMNG0004AView.duplicateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0004BView)
     .operation(FOperation)
      .selectedRecord(FdQDataCODIGO.AsString)
     .&end;
end;

procedure TFMNG0004AView.&end;
begin

  Show;
end;

procedure TFMNG0004AView.FormShow(Sender: TObject);
begin
  inherited;
  FFieldOrder := 'NOME';

  listRecords;
  totalRecords;
end;

procedure TFMNG0004AView.insertRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0004BView)
     .operation(FOperation)
     .&end;
end;

procedure TFMNG0004AView.listRecords;
begin
  FdQData.Close();
  FdQData.Open();
end;

class function TFMNG0004AView.New: iBaseListView;
begin
  Result := Self.Create(nil);
end;

procedure TFMNG0004AView.showRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0004BView)
     .operation(FOperation)
      .selectedRecord(FdQDataCODIGO.AsString)
     .&end;
end;

procedure TFMNG0004AView.updateRecord;
begin
 TFacadeView.New
  .modulesFacadeView
   .ManagmentFactoryView
    .showProgramOfRegister(trMNG0004BView)
     .operation(FOperation)
      .selectedRecord(FdQDataCODIGO.AsString)
     .&end;
end;

end.
