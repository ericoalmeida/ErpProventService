unit STO0001DView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseSearch.View, cxGraphics,
   cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
   dxSkinDarkRoom,
   dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxControls,
   cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
   cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
   Data.DB,
   cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Stan.Async, FireDAC.DApt, cxClasses, FireDAC.Comp.Client,
   FireDAC.Comp.DataSet, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
   cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxLabel,
   Vcl.StdCtrls,
   cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
   Base.View.interf,
   DataMFirebird.Model;

type
   TFSTO0001DView = class(TFBaseSearchView, IBaseSearchView)
      FdQDataCODE: TStringField;
      FdQDataPRODUCTID: TIntegerField;
      FdQDataCODE_SINAPI: TStringField;
      FdQDataDESCRIPTION: TStringField;
      VwDadosPRODUCTID: TcxGridDBColumn;
      VwDadosCODE_SINAPI: TcxGridDBColumn;
      VwDadosDESCRIPTION: TcxGridDBColumn;
      procedure FormShow(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
      procedure BtSairClick(Sender: TObject);
      procedure TxBuscarPropertiesChange(Sender: TObject);
   private
      { Private declarations }
   public
      class function New: IBaseSearchView;

      function showSearch: IBaseSearchView;

      procedure listRecords;

      function &end: string;
   end;

var
   FSTO0001DView: TFSTO0001DView;

implementation

{$R *.dfm}
{ TFSTO0001DView }

procedure TFSTO0001DView.BtConfirmarClick(Sender: TObject);
begin
   inherited;
   FSelectedRecord := FdQDataCODE.AsString;
end;

procedure TFSTO0001DView.BtSairClick(Sender: TObject);
begin
   inherited;
   FSelectedRecord := '';
end;

function TFSTO0001DView.&end: string;
begin
   Result := FSelectedRecord;
end;

procedure TFSTO0001DView.FormCreate(Sender: TObject);
begin
   inherited;
   Self.Height := Screen.Height - 400;
   Self.Width := Screen.Width - 400;

   FdQData.Connection := FFdConnection;
end;

procedure TFSTO0001DView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'DESCRIPTION';

   { 1 } listRecords;
   { 2 } totalRecords;
end;

procedure TFSTO0001DView.listRecords;
begin
   FdQData.ParamByName('companyId').AsString := FSessionCompany;
   FdQData.Close;
   FdQData.Open();
end;

class function TFSTO0001DView.New: IBaseSearchView;
begin
   Result := Self.Create(nil);
end;

function TFSTO0001DView.showSearch: IBaseSearchView;
begin
   Result := Self;

   ShowModal;
end;

procedure TFSTO0001DView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;
   DsData.DataSet.Filtered := False;

   if not(TxBuscar.Text = EmptyStr) and not(FFieldOrder = EmptyStr) then
   begin
      DsData.DataSet.Filter := UpperCase(FFieldOrder) + ' like ''%' +
        AnsiUpperCase(TxBuscar.Text) + '%''';

      DsData.DataSet.Filtered := True;
   end;
end;

end.
