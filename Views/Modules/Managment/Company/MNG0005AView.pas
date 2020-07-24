unit MNG0005AView;

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
   dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf, dxSkinDarkRoom,
   dxSkinDarkSide,
   Types.Views, System.ImageList, Vcl.ImgList, cxImageList;

type
   TFMNG0005AView = class(TFBaseListView, iBaseListView)
      FdQDataCODE: TStringField;
      FdQDataCOMPANYID: TIntegerField;
      FdQDataNAME: TStringField;
      FdQDataFANCYNAME: TStringField;
      FdQDataCITYNAME: TStringField;
      FdQDataCREATEDAT: TSQLTimeStampField;
      FdQDataUPDATEDAT: TSQLTimeStampField;
      VwDadosCOMPANYID: TcxGridDBColumn;
      VwDadosNAME: TcxGridDBColumn;
      VwDadosFANCYNAME: TcxGridDBColumn;
      VwDadosCITYNAME: TcxGridDBColumn;
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
   FMNG0005AView: TFMNG0005AView;

implementation

{$R *.dfm}

uses Facade.View;

{ TFMNG0005AView }

procedure TFMNG0005AView.BtDeleteClick(Sender: TObject);
begin
   inherited;
   { 1 } deleteRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFMNG0005AView.BtDuplicateClick(Sender: TObject);
begin
   inherited;
   { 1 } duplicateRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFMNG0005AView.BtInsertClick(Sender: TObject);
begin
   inherited;
   { 1 } insertRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFMNG0005AView.BtShowClick(Sender: TObject);
begin
   inherited;
   { 1 } showRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFMNG0005AView.BtUpdateClick(Sender: TObject);
begin
   inherited;
   { 1 } updateRecord;
   { 2 } listRecords;
   { 3 } totalRecords;
   { 4 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFMNG0005AView.deleteRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0005BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

procedure TFMNG0005AView.duplicateRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0005BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

procedure TFMNG0005AView.&end;
begin

   Show;
end;

procedure TFMNG0005AView.FormCreate(Sender: TObject);
begin
   inherited;
   FdQData.Connection := FFdConnection;
end;

procedure TFMNG0005AView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'NAME';

   { 1 } listRecords;
   { 2 } totalRecords;
   { 3 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFMNG0005AView.insertRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0005BView).operation(FOperation).&end;
end;

procedure TFMNG0005AView.listRecords;
begin
   FdQData.Close;
   FdQData.Open();
end;

class function TFMNG0005AView.New: iBaseListView;
begin
   Result := Self.Create(nil);
end;

procedure TFMNG0005AView.showRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0005BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

procedure TFMNG0005AView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;

   filterRecords;
   totalRecords;
end;

procedure TFMNG0005AView.updateRecord;
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfRegister
     (trMNG0005BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

end.
