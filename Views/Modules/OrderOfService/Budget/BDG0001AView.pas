unit BDG0001AView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics,
   cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
   dxSkinDarkRoom,
   dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxControls,
   cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
   cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
   Data.DB,
   cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Stan.Async, FireDAC.DApt, System.ImageList, Vcl.ImgList, cxImageList,
   FireDAC.Comp.Client, FireDAC.Comp.DataSet, cxClasses, cxGridLevel,
   cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
   cxGrid, cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons, RzLabel,
   dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf,
  DataMFirebird.Model;

type
   TFBDG0001AView = class(TFBaseListView, iBaseListView)
      FdQDataCODE: TStringField;
      FdQDataBUDGETID: TIntegerField;
      FdQDataDESCRIPTION: TStringField;
      FdQDataEMISSIONDATE: TDateField;
      FdQDataUSERNAME: TStringField;
      FdQDataCREATEDAT: TSQLTimeStampField;
      FdQDataUPDATEDAT: TSQLTimeStampField;
      VwDadosBUDGETID: TcxGridDBColumn;
      VwDadosDESCRIPTION: TcxGridDBColumn;
      VwDadosEMISSIONDATE: TcxGridDBColumn;
      VwDadosUSERNAME: TcxGridDBColumn;
      VwDadosCREATEDAT: TcxGridDBColumn;
      VwDadosUPDATEDAT: TcxGridDBColumn;
    RzPanel1: TRzPanel;
    cxButton1: TcxButton;
    QueryExporta: TFDQuery;
      procedure FormShow(Sender: TObject);
      procedure BtInsertClick(Sender: TObject);
      procedure BtUpdateClick(Sender: TObject);
      procedure BtShowClick(Sender: TObject);
      procedure BtDeleteClick(Sender: TObject);
      procedure BtDuplicateClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
   private
      { Private declarations }
      procedure exportFile;
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
   FBDG0001AView: TFBDG0001AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;
{ TFBDG0001AView }

procedure TFBDG0001AView.BtDeleteClick(Sender: TObject);
begin
  inherited;
  
   deleteRecord;
   listRecords;
end;

procedure TFBDG0001AView.BtDuplicateClick(Sender: TObject);
begin
  inherited;
  
   duplicateRecord;
   listRecords;
end;

procedure TFBDG0001AView.BtInsertClick(Sender: TObject);
begin
   inherited;
   insertRecord;
   listRecords;
end;

procedure TFBDG0001AView.BtShowClick(Sender: TObject);
begin
  inherited;
  
   showRecord;
   listRecords;
end;

procedure TFBDG0001AView.BtUpdateClick(Sender: TObject);
begin
   inherited;

   updateRecord;
   listRecords;
end;

procedure TFBDG0001AView.cxButton1Click(Sender: TObject);
begin
  inherited;

  exportFile;
end;

procedure TFBDG0001AView.deleteRecord;
begin
   TFacadeView.New
     .modulesFacadeView
      .orderOfServiceFactory
      .showProgramOfRegister(trBDG0001BView)
      .operation(FOperation)
      .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFBDG0001AView.duplicateRecord;
begin
   TFacadeView.New
     .modulesFacadeView
      .orderOfServiceFactory
      .showProgramOfRegister(trBDG0001BView)
      .operation(FOperation)
      .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFBDG0001AView.&end;
begin

   Show;
end;

procedure TFBDG0001AView.exportFile;
  Var
    i : Integer;
    F : TextFile;
    Arquivo : string;
begin
   Arquivo := 'C:\ERGSis\exportacoes\orcamento_' +
     FdQDataBUDGETID.AsString + '.csv';
   AssignFile(F, Arquivo);
   ReWrite(F);


   try
      try
         QueryExporta.ParamByName('companyId').AsString := FSessionCompany;
         QueryExporta.ParamByName('code').AsString := FdQDataCODE.AsString;

         QueryExporta.Open();

         For i := 0 To Pred(QueryExporta.FieldCount) Do
         Begin
            Write(F, QueryExporta.Fields[i].FieldName);
            If (i < Pred(QueryExporta.FieldCount)) Then
               Write(F, ';');
         End;

         WriteLn(F);

         While (Not QueryExporta.Eof) Do
         Begin
            For i := 0 To Pred(QueryExporta.FieldCount) Do
            Begin
               Write(F, QueryExporta.Fields[i].AsString);
               If (i < Pred(QueryExporta.FieldCount)) Then
                  Write(F, ';');
            End;

            WriteLn(F);
            QueryExporta.Next;
         End;

      except
         on E: Exception do begin
            ShowMessage(e.Message);
         end;
      end;
   finally
      Flush(F);
      CloseFile(F);

      QueryExporta.Close;

      ShowMessage('Exportação concluída!');

   end;

end;

procedure TFBDG0001AView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'DESCRIPTION';

   { 1 } listRecords;
   { 2 } totalRecords;
   { 3 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFBDG0001AView.insertRecord;
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfRegister
     (trBDG0001BView).operation(FOperation).&end;
end;

procedure TFBDG0001AView.listRecords;
begin
   FdQData.ParamByName('companyId').AsString := FSessionCompany;
   FdQData.Close;
   FdQData.Open();
end;

class function TFBDG0001AView.New: iBaseListView;
begin
   Result := Self.Create(nil);
end;

procedure TFBDG0001AView.showRecord;
begin
   TFacadeView.New
     .modulesFacadeView
      .orderOfServiceFactory
      .showProgramOfRegister(trBDG0001BView)
      .operation(FOperation)
      .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

procedure TFBDG0001AView.updateRecord;
begin
   TFacadeView.New
    .modulesFacadeView
     .orderOfServiceFactory
      .showProgramOfRegister(trBDG0001BView)
      .operation(FOperation)
      .selectedRecord(FdQDataCODE.AsString)
     .&end;
end;

end.
