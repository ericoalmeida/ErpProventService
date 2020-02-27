unit ORD0001AView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxControls, cxContainer,
  cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, System.ImageList,
  Vcl.ImgList, cxImageList,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, cxClasses, cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit,
  cxLabel,
  Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
  Base.View.interf, cxImageComboBox;

type
  TFORD0001AView = class(TFBaseListView, iBaseListView)
    FdQDataCODE: TStringField;
    FdQDataSERVICEID: TIntegerField;
    FdQDataDESCRIPTION: TStringField;
    FdQDataMEASUREDUNIT: TStringField;
    FdQDataSTATUS: TIntegerField;
    FdQDataUSERNAME: TStringField;
    FdQDataCREATEDAT: TSQLTimeStampField;
    FdQDataUPDATEDAT: TSQLTimeStampField;
    VwDadosSERVICEID: TcxGridDBColumn;
    VwDadosDESCRIPTION: TcxGridDBColumn;
    VwDadosMEASUREDUNIT: TcxGridDBColumn;
    VwDadosSTATUS: TcxGridDBColumn;
    VwDadosUSERNAME: TcxGridDBColumn;
    VwDadosCREATEDAT: TcxGridDBColumn;
    VwDadosUPDATEDAT: TcxGridDBColumn;
    FdQDataPRICE: TBCDField;
    VwDadosPRICE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TxBuscarPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
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
  FORD0001AView: TFORD0001AView;

implementation

{$R *.dfm}
{ TFORD0001AView }

procedure TFORD0001AView.deleteRecord;
begin

end;

procedure TFORD0001AView.duplicateRecord;
begin

end;

procedure TFORD0001AView.&end;
begin
  Show;
end;

procedure TFORD0001AView.FormCreate(Sender: TObject);
begin
  inherited;
  FdQData.Connection := FFdConnection;
  FColumnStatus := VwDadosSTATUS;
end;

procedure TFORD0001AView.FormShow(Sender: TObject);
begin
  inherited;

  listRecords;
  totalRecords;
end;

procedure TFORD0001AView.insertRecord;
begin

end;

procedure TFORD0001AView.listRecords;
begin
  FdQData.ParamByName('companyId').AsString := FSessionCompany;
  FdQData.Close;
  FdQData.Open();
end;

class function TFORD0001AView.New: iBaseListView;
begin
  Result := Self.Create(nil);
end;

procedure TFORD0001AView.showRecord;
begin

end;

procedure TFORD0001AView.TxBuscarPropertiesChange(Sender: TObject);
begin
  inherited;

  filterRecords;
  totalRecords;
end;

procedure TFORD0001AView.updateRecord;
begin

end;

end.
