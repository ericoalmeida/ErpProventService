unit MNG0006AView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics,
   cxLookAndFeels,
   cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom,
   dxSkinDarkSide,
   dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxControls, cxContainer,
   cxEdit, cxStyles,
   cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
   cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
   FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
   FireDAC.Comp.DataSet,
   cxClasses, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
   cxGridTableView,
   cxGridDBTableView, cxGrid, cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons,
   RzLabel,
   dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf,
   TMNGUSER.Entity.Model, ormbr.container.DataSet.interfaces,
   ormbr.container.fdmemtable, cxImageComboBox, System.ImageList, Vcl.ImgList,
   cxImageList;

type
   TFMNG0006AView = class(TFBaseListView, iBaseListView)
      FdDataCODE: TStringField;
      FdDataUSERID: TIntegerField;
      FdDataNAME: TStringField;
      FdDataEMAIL: TStringField;
      FdDataUSERNAME: TStringField;
      FdDataKEYPASS: TStringField;
      FdDataSTATUS: TIntegerField;
      VwDadosUSERID: TcxGridDBColumn;
      VwDadosNAME: TcxGridDBColumn;
      VwDadosEMAIL: TcxGridDBColumn;
      VwDadosUSERNAME: TcxGridDBColumn;
      VwDadosSTATUS: TcxGridDBColumn;
      FdDataCREATEDAT: TSQLTimeStampField;
      FdDataUPDATEDAT: TSQLTimeStampField;
      VwDadosCREATEDAT: TcxGridDBColumn;
      VwDadosUPDATEDAT: TcxGridDBColumn;
      procedure FormShow(Sender: TObject);
      procedure BtInsertClick(Sender: TObject);
      procedure BtUpdateClick(Sender: TObject);
      procedure BtShowClick(Sender: TObject);
      procedure BtDeleteClick(Sender: TObject);
      procedure BtDuplicateClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure TxBuscarPropertiesChange(Sender: TObject);
   private
      FContainer: IContainerDataSet<TTMNGUSER>;

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
   FMNG0006AView: TFMNG0006AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;

{ TFMNG0006AView }

procedure TFMNG0006AView.BtDeleteClick(Sender: TObject);
begin
   inherited;

   { 1 } deleteRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdDataEmpty;
end;

procedure TFMNG0006AView.BtDuplicateClick(Sender: TObject);
begin
   inherited;

   { 1 } duplicateRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdDataEmpty;
end;

procedure TFMNG0006AView.BtInsertClick(Sender: TObject);
begin
   inherited;

   { 1 } insertRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdDataEmpty;
end;

procedure TFMNG0006AView.BtShowClick(Sender: TObject);
begin
   inherited;

   { 1 } showRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdDataEmpty;
end;

procedure TFMNG0006AView.BtUpdateClick(Sender: TObject);
begin
   inherited;

   { 1 } updateRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdDataEmpty;
end;

procedure TFMNG0006AView.deleteRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0006BView).operation(FOperation)
     .selectedRecord(FdDataCODE.AsString).&end;
end;

procedure TFMNG0006AView.duplicateRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0006BView).operation(FOperation)
     .selectedRecord(FdDataCODE.AsString).&end;
end;

procedure TFMNG0006AView.&end;
begin
   Show;
end;

procedure TFMNG0006AView.FormCreate(Sender: TObject);
begin
   inherited;
   FContainer := TContainerFDMemTable<TTMNGUSER>.Create(FConnection, FdData);
   FColumnStatus := VwDadosSTATUS;
end;

procedure TFMNG0006AView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'NAME';

   { 1 } listRecords;
   { 2 } totalRecords;
   { 3 } disableButtonsWhenfdDataEmpty;
end;

procedure TFMNG0006AView.insertRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0006BView).operation(FOperation).&end;
end;

procedure TFMNG0006AView.listRecords;
begin
   FContainer.OpenWhere('', FFieldOrder);
end;

class function TFMNG0006AView.New: iBaseListView;
begin
   Result := Self.Create(nil);
end;

procedure TFMNG0006AView.showRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0006BView).operation(FOperation)
     .selectedRecord(FdDataCODE.AsString).&end;
end;

procedure TFMNG0006AView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;

   { 1 } filterRecords;
   { 2 } totalRecords;
end;

procedure TFMNG0006AView.updateRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0006BView).operation(FOperation)
     .selectedRecord(FdDataCODE.AsString).&end;
end;

end.
