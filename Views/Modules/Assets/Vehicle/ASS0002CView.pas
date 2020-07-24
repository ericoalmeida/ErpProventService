unit ASS0002CView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseSearch.View, cxGraphics,
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
   FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, cxClasses,
   FireDAC.Comp.Client,
   FireDAC.Comp.DataSet, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
   cxGridTableView,
   cxGridDBTableView, cxGrid, cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons,
   RzLabel,
   dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf;

type
   TFASS0002CView = class(TFBaseSearchView, IBaseSearchView)
      FdQDataCODE: TStringField;
      FdQDataVEHICLEID: TIntegerField;
      FdQDataDESCRIPTION: TStringField;
      FdQDataMODEL: TStringField;
      FdQDataBRAND: TStringField;
      FdQDataCATEGORY: TStringField;
      FdQDataBOARD: TStringField;
      FdQDataSTATUS: TIntegerField;
      FdQDataUSERNAME: TStringField;
      FdQDataCREATEDAT: TSQLTimeStampField;
      FdQDataUPDATEDAT: TSQLTimeStampField;
      VwDadosVEHICLEID: TcxGridDBColumn;
      VwDadosDESCRIPTION: TcxGridDBColumn;
      VwDadosMODEL: TcxGridDBColumn;
      VwDadosBRAND: TcxGridDBColumn;
      VwDadosUPDATEDAT: TcxGridDBColumn;
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure TxBuscarPropertiesChange(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
      class function New: IBaseSearchView;

      function showSearch: IBaseSearchView;

      procedure listRecords;

      function &end: string;
   end;

var
   FASS0002CView: TFASS0002CView;

implementation

{$R *.dfm}
{ TFASS0002CView }

procedure TFASS0002CView.BtConfirmarClick(Sender: TObject);
begin
   FSelectedRecord := FdQDataCODE.AsString;
   inherited;
end;

function TFASS0002CView.&end: string;
begin
   Result := FSelectedRecord;
end;

procedure TFASS0002CView.FormCreate(Sender: TObject);
begin
   inherited;

   Self.Height := Screen.Height - 400;
   Self.Width := Screen.Width - 400;

   FdQData.Connection := FFdConnection;
end;

procedure TFASS0002CView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'DESCRIPTION';

   { 1 } listRecords;
   { 2 } totalRecords;
end;

procedure TFASS0002CView.listRecords;
begin
   FdQData.ParamByName('companyId').AsString := FSessionCompany;
   FdQData.Close;
   FdQData.Open();
end;

class function TFASS0002CView.New: IBaseSearchView;
begin
   Result := Self.Create(nil);
end;

function TFASS0002CView.showSearch: IBaseSearchView;
begin
   Result := Self;

   ShowModal;
end;

procedure TFASS0002CView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;

   filterRecords;
   totalRecords;
end;

end.
