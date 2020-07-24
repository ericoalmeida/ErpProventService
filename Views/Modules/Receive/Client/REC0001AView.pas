unit REC0001AView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics,
   cxLookAndFeels,
   cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
   dxSkinDevExpressStyle,
   dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
   dxSkinOffice2007Silver,
   cxControls, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData,
   cxDataStorage,
   cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
   Data.DB, cxDBData,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
   FireDAC.Comp.Client,
   FireDAC.Comp.DataSet, cxClasses, cxGridLevel, cxGridCustomView,
   cxGridCustomTableView,
   cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxLabel,
   Vcl.StdCtrls, cxButtons, RzLabel,
   dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, dxSkinDarkRoom, dxSkinDarkSide,
   System.ImageList,
   Vcl.ImgList, cxImageList, Base.View.interf, cxImageComboBox;

type
   TFREC0001AView = class(TFBaseListView, iBaseListView)
      FdQDataCODE: TStringField;
      FdQDataPERSONID: TIntegerField;
      FdQDataNAME: TStringField;
      FdQDataPHONENUMBER: TStringField;
      FdQDataEMAIL: TStringField;
      FdQDataSTATUS: TIntegerField;
      FdQDataUSERNAME: TStringField;
      FdQDataCREATEDAT: TSQLTimeStampField;
      FdQDataUPDATEDAT: TSQLTimeStampField;
      VwDadosPERSONID: TcxGridDBColumn;
      VwDadosNAME: TcxGridDBColumn;
      VwDadosPHONENUMBER: TcxGridDBColumn;
      VwDadosEMAIL: TcxGridDBColumn;
      VwDadosSTATUS: TcxGridDBColumn;
      VwDadosUSERNAME: TcxGridDBColumn;
      VwDadosCREATEDAT: TcxGridDBColumn;
      VwDadosUPDATEDAT: TcxGridDBColumn;
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure BtInsertClick(Sender: TObject);
      procedure BtUpdateClick(Sender: TObject);
      procedure BtShowClick(Sender: TObject);
      procedure BtDeleteClick(Sender: TObject);
      procedure BtDuplicateClick(Sender: TObject);
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
   FREC0001AView: TFREC0001AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;

{ TFREC0001AView }

procedure TFREC0001AView.BtDeleteClick(Sender: TObject);
begin
   inherited;

   { 1 } deleteRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
end;

procedure TFREC0001AView.BtDuplicateClick(Sender: TObject);
begin
   inherited;

   { 1 } duplicateRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
end;

procedure TFREC0001AView.BtInsertClick(Sender: TObject);
begin
   inherited;

   { 1 } insertRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
end;

procedure TFREC0001AView.BtShowClick(Sender: TObject);
begin
   inherited;

   { 1 } showRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
end;

procedure TFREC0001AView.BtUpdateClick(Sender: TObject);
begin
   inherited;

   { 1 } updateRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
end;

procedure TFREC0001AView.deleteRecord;
begin
   TFacadeView.New.modulesFacadeView.receiveFactory.showProgramOfRegister
     (trREC0001BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

procedure TFREC0001AView.duplicateRecord;
begin
   TFacadeView.New.modulesFacadeView.receiveFactory.showProgramOfRegister
     (trREC0001BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

procedure TFREC0001AView.&end;
begin

   Show;
end;

procedure TFREC0001AView.FormCreate(Sender: TObject);
begin
   inherited;

   FColumnStatus := VwDadosSTATUS;
   FdQData.Connection := FFdConnection;
end;

procedure TFREC0001AView.FormShow(Sender: TObject);
begin
   inherited;

   FFieldOrder := 'NAME';

   { 1 } listRecords;
   { 2 } totalRecords;
end;

procedure TFREC0001AView.insertRecord;
begin
   TFacadeView.New.modulesFacadeView.receiveFactory.showProgramOfRegister
     (trREC0001BView).operation(FOperation).&end;
end;

procedure TFREC0001AView.listRecords;
begin
   FdQData.ParamByName('companyId').AsString := FSessionCompany;
   FdQData.Close;
   FdQData.Open();
end;

class function TFREC0001AView.New: iBaseListView;
begin
   Result := Self.Create(nil);
end;

procedure TFREC0001AView.showRecord;
begin
   TFacadeView.New.modulesFacadeView.receiveFactory.showProgramOfRegister
     (trREC0001BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

procedure TFREC0001AView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;

   { 1 } filterRecords;
   { 2 } totalRecords;
end;

procedure TFREC0001AView.updateRecord;
begin
   TFacadeView.New.modulesFacadeView.receiveFactory.showProgramOfRegister
     (trREC0001BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

end.
