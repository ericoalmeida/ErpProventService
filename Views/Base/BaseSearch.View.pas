unit BaseSearch.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle,
  cxControls, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView, cxGrid, cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons,
  RzLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxSkinOffice2007Black,
  dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Silver, System.Actions, Vcl.ActnList,
  FireDAC.Stan.Async,
  FireDAC.DApt, dxSkinDarkRoom, dxSkinDarkSide;

type
  TFBaseSearchView = class(TFBaseView)
    PnContent: TRzPanel;
    PnGridHeader: TRzPanel;
    LbBuscar: TcxLabel;
    TxBuscar: TcxTextEdit;
    PnGridFooter: TRzPanel;
    LbTotalRegistros: TRzLabel;
    PnGrid: TRzPanel;
    DbDados: TcxGrid;
    VwDados: TcxGridDBTableView;
    LvDados: TcxGridLevel;
    FdData: TFDMemTable;
    DsData: TDataSource;
    FdQData: TFDQuery;
    StGridStyles: TcxStyleRepository;
    StHeader: TcxStyle;
    stContentOdd: TcxStyle;
    stContentEven: TcxStyle;
    StInactive: TcxStyle;
    StSelection: TcxStyle;
    StIndicator: TcxStyle;
    PnButtonConfirm: TRzPanel;
    BtConfirmar: TcxButton;
    procedure BtConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    FSelectedRecord: string;
    procedure filterRecords;
    procedure totalRecords;

  public
    { Public declarations }
  end;

var
  FBaseSearchView: TFBaseSearchView;

implementation

{$R *.dfm}

procedure TFBaseSearchView.BtConfirmarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFBaseSearchView.filterRecords;
begin
  DsData.DataSet.Filtered := False;

  if not(TxBuscar.Text = EmptyStr) then
  begin
    DsData.DataSet.Filter := UpperCase(FFieldOrder) + ' like ''%' +
      AnsiUpperCase(TxBuscar.Text) + '%''';

    DsData.DataSet.Filtered := True;
  end;
end;

procedure TFBaseSearchView.totalRecords;
begin
  FTotalRecords := DsData.DataSet.RecordCount;
  FRecordShow   := FUtils.iff(DsData.DataSet.IsEmpty, 0, 1);

  LbTotalRegistros.Caption := Format('Mostrando de %d até %d de %d registros',
    [FRecordShow, FTotalRecords, FTotalRecords]);
end;

end.
