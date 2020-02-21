unit MNG0003CView;

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
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  cxClasses,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxLabel, Vcl.StdCtrls,
  cxButtons, RzLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Base.View.interf, dxSkinDarkRoom, dxSkinDarkSide;

type
  TFMNG0003CView = class(TFBaseSearchView, IBaseSearchView)
    FdQDataCODE: TStringField;
    FdQDataSTATEID: TIntegerField;
    FdQDataNAME: TStringField;
    FdQDataCOUNTRYID: TStringField;
    FdQDataCOUNTRYNAME: TStringField;
    FdQDataCREATEDAT: TSQLTimeStampField;
    FdQDataUPDATEDAT: TSQLTimeStampField;
    VwDadosSTATEID: TcxGridDBColumn;
    VwDadosNAME: TcxGridDBColumn;
    VwDadosCOUNTRYNAME: TcxGridDBColumn;
    VwDadosCREATEDAT: TcxGridDBColumn;
    VwDadosUPDATEDAT: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  FMNG0003CView: TFMNG0003CView;

implementation

{$R *.dfm}

{ TFMNG0004CView }

procedure TFMNG0003CView.BtConfirmarClick(Sender: TObject);
begin
  FSelectedRecord := FdQDataCODE.AsString;
  inherited;
end;

procedure TFMNG0003CView.BtSairClick(Sender: TObject);
begin
  FSelectedRecord := EmptyStr;
  inherited;
end;

function TFMNG0003CView.&end: string;
begin
  Result := FSelectedRecord;
end;

procedure TFMNG0003CView.FormCreate(Sender: TObject);
begin
  inherited;
  FdQData.Connection := FFdConnection;
end;

procedure TFMNG0003CView.FormShow(Sender: TObject);
begin
  inherited;
  FFieldOrder := 'NAME';

  listRecords;
  totalRecords;
end;

procedure TFMNG0003CView.listRecords;
begin
  FdQData.Open();
end;

class function TFMNG0003CView.New: IBaseSearchView;
begin
  Result := Self.Create(nil);
end;

function TFMNG0003CView.showSearch: IBaseSearchView;
begin
  Result := Self;

  ShowModal;
end;

procedure TFMNG0003CView.TxBuscarPropertiesChange(Sender: TObject);
begin
  inherited;

  filterRecords;
  totalRecords;
end;

end.
