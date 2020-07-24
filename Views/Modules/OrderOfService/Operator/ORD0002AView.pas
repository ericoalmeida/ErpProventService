unit ORD0002AView;

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
   FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, System.ImageList,
   Vcl.ImgList, cxImageList,
   FireDAC.Comp.Client, FireDAC.Comp.DataSet, cxClasses, cxGridLevel,
   cxGridCustomView,
   cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
   cxTextEdit, cxLabel,
   Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
   Base.View.interf,
   cxImageComboBox;

type
   TFORD0002AView = class(TFBaseListView, iBaseListView)
      FdQDataCODE: TStringField;
      FdQDataOPERATORID: TIntegerField;
      FdQDataNAME: TStringField;
      FdQDataSTATUS: TIntegerField;
      FdQDataUSERNAME: TStringField;
      FdQDataCREATEDAT: TSQLTimeStampField;
      FdQDataUPDATEDAT: TSQLTimeStampField;
      VwDadosOPERATORID: TcxGridDBColumn;
      VwDadosNAME: TcxGridDBColumn;
      VwDadosSTATUS: TcxGridDBColumn;
      VwDadosUSERNAME: TcxGridDBColumn;
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
   FORD0002AView: TFORD0002AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;

{ TFORD0002AView }

procedure TFORD0002AView.BtDeleteClick(Sender: TObject);
begin
   inherited;

   { 1 } deleteRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFORD0002AView.BtDuplicateClick(Sender: TObject);
begin
   inherited;

   { 1 } duplicateRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFORD0002AView.BtInsertClick(Sender: TObject);
begin
   inherited;

   { 1 } insertRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFORD0002AView.BtShowClick(Sender: TObject);
begin
   inherited;
   { 1 } showRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFORD0002AView.BtUpdateClick(Sender: TObject);
begin
   inherited;

   { 1 } updateRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFORD0002AView.deleteRecord;
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfRegister
     (trORD0002BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

procedure TFORD0002AView.duplicateRecord;
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfRegister
     (trORD0002BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

procedure TFORD0002AView.&end;
begin

   Show;
end;

procedure TFORD0002AView.FormCreate(Sender: TObject);
begin
   inherited;

   FColumnStatus := VwDadosSTATUS;
   FdQData.Connection := FFdConnection;
end;

procedure TFORD0002AView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'NAME';

   { 1 } listRecords;
   { 2 } totalRecords;
   { 3 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFORD0002AView.insertRecord;
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfRegister
     (trORD0002BView).operation(FOperation).&end;
end;

procedure TFORD0002AView.listRecords;
begin
   FdQData.ParamByName('companyId').AsString := FSessionCompany;
   FdQData.Close;
   FdQData.Open();
end;

class function TFORD0002AView.New: iBaseListView;
begin
   Result := Self.Create(nil);
end;

procedure TFORD0002AView.showRecord;
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfRegister
     (trORD0002BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

procedure TFORD0002AView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;

   filterRecords;
   totalRecords;
end;

procedure TFORD0002AView.updateRecord;
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfRegister
     (trORD0002BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

end.
