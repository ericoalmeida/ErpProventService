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
   dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf;

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
      procedure FormShow(Sender: TObject);
      procedure BtInsertClick(Sender: TObject);
      procedure BtUpdateClick(Sender: TObject);
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
   FBDG0001AView: TFBDG0001AView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;
{ TFBDG0001AView }

procedure TFBDG0001AView.BtInsertClick(Sender: TObject);
begin
   inherited;
   insertRecord;
   listRecords;
end;

procedure TFBDG0001AView.BtUpdateClick(Sender: TObject);
begin
   inherited;

   updateRecord;
   listRecords;
end;

procedure TFBDG0001AView.deleteRecord;
begin

end;

procedure TFBDG0001AView.duplicateRecord;
begin

end;

procedure TFBDG0001AView.&end;
begin

   Show;
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

end;

procedure TFBDG0001AView.updateRecord;
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfRegister
     (trBDG0001BView).operation(FOperation)
     .selectedRecord(FdQDataCODE.AsString).&end;
end;

end.
