unit MNG0002CView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseSearch.View, cxGraphics,
   cxLookAndFeels,
   cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
   dxSkinDevExpressStyle,
   dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
   dxSkinOffice2007Silver,
   cxControls, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData,
   cxDataStorage,
   cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
   Data.DB,
   cxDBData,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, cxClasses, FireDAC.Comp.DataSet,
   FireDAC.Comp.Client,
   cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
   cxGridDBTableView, cxGrid,
   cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses,
   Vcl.ExtCtrls, RzPanel,
   Base.View.interf, FireDAC.Stan.Async, FireDAC.DApt,
   ormbr.container.DataSet.interfaces,
   ormbr.container.fdmemtable, TMNGCOUNTRY.Entity.Model, dxSkinDarkRoom,
   dxSkinDarkSide;

type
   TFMNG0002CView = class(TFBaseSearchView, IBaseSearchView)
      FdQDataCODE: TStringField;
      FdQDataNAME: TStringField;
      FdQDataCREATEDAT: TSQLTimeStampField;
      FdQDataUPDATEDAT: TStringField;
      FdQDataCOUNTRYID: TIntegerField;
      FdDataCODE: TStringField;
      FdDataCOUNTRYID: TIntegerField;
      FdDataNAME: TStringField;
      FdDataCREATEDAT: TSQLTimeStampField;
      VwDadosCOUNTRYID: TcxGridDBColumn;
      VwDadosNAME: TcxGridDBColumn;
      VwDadosCREATEDAT: TcxGridDBColumn;
      FdDataUPDATEDAT: TSQLTimeStampField;
      VwDadosUPDATEDAT: TcxGridDBColumn;
      procedure BtSairClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure TxBuscarPropertiesChange(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
   private
      FContainer: IContainerDataSet<TTMNGCOUNTRY>;

   public
      class function New: IBaseSearchView;

      function showSearch: IBaseSearchView;

      procedure listRecords;

      function &end: string;
   end;

var
   FMNG0002CView: TFMNG0002CView;

implementation

{$R *.dfm}
{ TFMNG0002CView }

procedure TFMNG0002CView.BtConfirmarClick(Sender: TObject);
begin
   FSelectedRecord := FdDataCODE.AsString;
   inherited;
end;

procedure TFMNG0002CView.BtSairClick(Sender: TObject);
begin
   FSelectedRecord := EmptyStr;
   inherited;
end;

function TFMNG0002CView.&end: string;
begin
   Result := FSelectedRecord;
end;

procedure TFMNG0002CView.FormCreate(Sender: TObject);
begin
   inherited;

   Self.Height := Screen.Height - 400;
   Self.Width := Screen.Width - 400;

   FContainer := TContainerFDMemTable<TTMNGCOUNTRY>.Create(FConnection, FdData);
end;

procedure TFMNG0002CView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'NAME';

   { 1 } listRecords;
   { 2 } totalRecords;
end;

procedure TFMNG0002CView.listRecords;
begin
   FContainer.OpenWhere('', FFieldOrder);
end;

class function TFMNG0002CView.New: IBaseSearchView;
begin
   Result := Self.Create(nil);
end;

function TFMNG0002CView.showSearch: IBaseSearchView;
begin
   Result := Self;

   ShowModal;
end;

procedure TFMNG0002CView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;

   { 1 } filterRecords;
   { 2 } totalRecords;
end;

end.
