unit MNG0001CView;

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
   TFMNG0001CView = class(TFBaseSearchView, IBaseSearchView)
      FdQDataCODE: TStringField;
      FdQDataDISTRICTID: TIntegerField;
      FdQDataDESCRIPTION: TStringField;
      FdQDataCITYID: TStringField;
      FdQDataCITYNAME: TStringField;
      FdQDataCREATEDAT: TSQLTimeStampField;
      FdQDataUPDATEDAT: TSQLTimeStampField;
      VwDadosDISTRICTID: TcxGridDBColumn;
      VwDadosDESCRIPTION: TcxGridDBColumn;
      VwDadosCITYNAME: TcxGridDBColumn;
      procedure TxBuscarPropertiesChange(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure BtSairClick(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
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
   FMNG0001CView: TFMNG0001CView;

implementation

{$R *.dfm}

function TFMNG0001CView.&end: string;
begin
   Result := FSelectedRecord;
end;

procedure TFMNG0001CView.BtConfirmarClick(Sender: TObject);
begin
   FSelectedRecord := FdQDataCODE.AsString;
   inherited;
end;

procedure TFMNG0001CView.BtSairClick(Sender: TObject);
begin
   FSelectedRecord := EmptyStr;
   inherited;
end;

procedure TFMNG0001CView.FormCreate(Sender: TObject);
begin
   inherited;
   FdQData.Connection := FFdConnection;
end;

procedure TFMNG0001CView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'DESCRIPTION';

   listRecords;
   totalRecords;
end;

procedure TFMNG0001CView.listRecords;
begin
   FdQData.Close;
   FdQData.Open();
end;

class function TFMNG0001CView.New: IBaseSearchView;
begin
   Result := Self.Create(nil);
end;

function TFMNG0001CView.showSearch: IBaseSearchView;
begin
   Result := Self;

   ShowModal;
end;

procedure TFMNG0001CView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;

   filterRecords;
   totalRecords;
end;

end.
