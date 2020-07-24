unit ORD0002CView;

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
   TFORD0002CView = class(TFBaseSearchView, IBaseSearchView)
      FdQDataCODE: TStringField;
      FdQDataOPERATORID: TIntegerField;
      FdQDataNAME: TStringField;
      FdQDataSTATUS: TIntegerField;
      FdQDataUSERNAME: TStringField;
      FdQDataCREATEDAT: TSQLTimeStampField;
      FdQDataUPDATEDAT: TSQLTimeStampField;
      VwDadosOPERATORID: TcxGridDBColumn;
      VwDadosNAME: TcxGridDBColumn;
      VwDadosUPDATEDAT: TcxGridDBColumn;
      procedure FormShow(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
      procedure TxBuscarPropertiesChange(Sender: TObject);
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
   FORD0002CView: TFORD0002CView;

implementation

{$R *.dfm}
{ TFORD0002CView }

procedure TFORD0002CView.BtConfirmarClick(Sender: TObject);
begin
   FSelectedRecord := FdQDataCODE.AsString;
   inherited;
end;

function TFORD0002CView.&end: string;
begin
   Result := FSelectedRecord;
end;

procedure TFORD0002CView.FormCreate(Sender: TObject);
begin
   inherited;
   Self.Height := Screen.Height - 400;
   Self.Width := Screen.Width - 400;

   FdQData.Connection := FFdConnection;
end;

procedure TFORD0002CView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'NAME';

   listRecords;
   totalRecords;
end;

procedure TFORD0002CView.listRecords;
begin
   FdQData.ParamByName('companyId').AsString := FSessionCompany;
   FdQData.Close;
   FdQData.Open();
end;

class function TFORD0002CView.New: IBaseSearchView;
begin
   Result := Self.Create(nil);
end;

function TFORD0002CView.showSearch: IBaseSearchView;
begin
   Result := Self;

   ShowModal;
end;

procedure TFORD0002CView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;

   filterRecords;
   totalRecords;
end;

end.
