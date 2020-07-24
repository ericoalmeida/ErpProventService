unit MNG0004CView;

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
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
   cxClasses,
   FireDAC.Comp.Client, FireDAC.Comp.DataSet, cxGridLevel, cxGridCustomView,
   cxGridCustomTableView,
   cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxLabel,
   Vcl.StdCtrls,
   cxButtons, RzLabel,
   dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf, dxSkinDarkRoom,
   dxSkinDarkSide;

type
   TFMNG0004CView = class(TFBaseSearchView, IBaseSearchView)
      FdQDataCODE: TStringField;
      FdQDataCITYID: TIntegerField;
      FdQDataNAME: TStringField;
      FdQDataZIPCODE: TStringField;
      FdQDataIBGECODE: TIntegerField;
      FdQDataSTATEID: TStringField;
      FdQDataSTATENAME: TStringField;
      FdQDataCREATEDAT: TSQLTimeStampField;
      FdQDataUPDATEDAT: TSQLTimeStampField;
      VwDadosCITYID: TcxGridDBColumn;
      VwDadosNAME: TcxGridDBColumn;
      VwDadosZIPCODE: TcxGridDBColumn;
      VwDadosIBGECODE: TcxGridDBColumn;
      VwDadosSTATENAME: TcxGridDBColumn;
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure BtSairClick(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
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
   FMNG0004CView: TFMNG0004CView;

implementation

{$R *.dfm}

procedure TFMNG0004CView.BtConfirmarClick(Sender: TObject);
begin
   FSelectedRecord := FdQDataCODE.AsString;
   inherited;
end;

procedure TFMNG0004CView.BtSairClick(Sender: TObject);
begin
   FSelectedRecord := EmptyStr;
   inherited;
end;

function TFMNG0004CView.&end: string;
begin
   Result := FSelectedRecord;
end;

procedure TFMNG0004CView.FormCreate(Sender: TObject);
begin
   inherited;
   FdQData.Connection := FFdConnection;
end;

procedure TFMNG0004CView.FormShow(Sender: TObject);
begin
   inherited;
   FFieldOrder := 'NAME';

   listRecords;
   totalRecords;
end;

procedure TFMNG0004CView.listRecords;
begin
   FdQData.Open();
end;

class function TFMNG0004CView.New: IBaseSearchView;
begin
   Result := Self.Create(nil);
end;

function TFMNG0004CView.showSearch: IBaseSearchView;
begin
   Result := Self;

   ShowModal;
end;

procedure TFMNG0004CView.TxBuscarPropertiesChange(Sender: TObject);
begin
   inherited;

   filterRecords;
   totalRecords;
end;

end.
