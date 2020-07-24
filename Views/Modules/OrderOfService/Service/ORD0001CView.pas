unit ORD0001CView;

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
   TFORD0001CView = class(TFBaseSearchView, IBaseSearchView)
      FdQDataCODE: TStringField;
      FdQDataSERVICEID: TIntegerField;
      FdQDataDESCRIPTION: TStringField;
      VwDadosSERVICEID: TcxGridDBColumn;
      VwDadosDESCRIPTION: TcxGridDBColumn;
      FdQDataUPDATEDAT: TSQLTimeStampField;
      VwDadosUPDATEDAT: TcxGridDBColumn;
      procedure BtConfirmarClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
   private
      { Private declarations }
   public
      class function New: IBaseSearchView;

      function showSearch: IBaseSearchView;

      procedure listRecords;

      function &end: string;
   end;

var
   FORD0001CView: TFORD0001CView;

implementation

{$R *.dfm}

function TFORD0001CView.&end: string;
begin
   Result := FSelectedRecord;
end;

procedure TFORD0001CView.FormCreate(Sender: TObject);
begin
   inherited;

   Self.Height := Screen.Height - 400;
   Self.Width := Screen.Width - 400;

   FdQData.Connection := FFdConnection;
end;

procedure TFORD0001CView.FormShow(Sender: TObject);
begin
   inherited;

   listRecords
end;

procedure TFORD0001CView.BtConfirmarClick(Sender: TObject);
begin
   FSelectedRecord := FdQDataCODE.AsString;
   inherited;
end;

procedure TFORD0001CView.listRecords;
begin
   FdQData.ParamByName('companyId').AsString := FSessionCompany;
   FdQData.Close;
   FdQData.Open();
end;

class function TFORD0001CView.New: IBaseSearchView;
begin
   Result := Self.Create(nil);
end;

function TFORD0001CView.showSearch: IBaseSearchView;
begin
   Result := Self;

   ShowModal;
end;

end.
