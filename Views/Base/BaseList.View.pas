unit BaseList.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, Vcl.StdCtrls, RzLabel,
  dxGDIPlusClasses,
  Vcl.ExtCtrls, RzPanel, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, dxSkinsCore,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxButtons, cxControls,
  cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid,
  Vcl.Mask, RzEdit, cxContainer, cxLabel, cxTextEdit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, ormbr.container.DataSet.interfaces, Types.Controllers;

type
  TFBaseListView = class(TFBaseView)
    PnContent: TRzPanel;
    DbDados: TcxGrid;
    VwDados: TcxGridDBTableView;
    LvDados: TcxGridLevel;
    PnHeaderButtons: TRzPanel;
    PnGridHeader: TRzPanel;
    PnGridFooter: TRzPanel;
    LbTotalRegistros: TRzLabel;
    PnDuplicate: TRzPanel;
    BtDuplicate: TcxButton;
    PnDelete: TRzPanel;
    BtDelete: TcxButton;
    PnShow: TRzPanel;
    BtShow: TcxButton;
    PnUpdate: TRzPanel;
    BtUpdate: TcxButton;
    PnInsert: TRzPanel;
    BtInsert: TcxButton;
    PnGrid: TRzPanel;
    LbBuscar: TcxLabel;
    StGridStyles: TcxStyleRepository;
    StHeader: TcxStyle;
    RzOptionShow: TRzPanel;
    BtOptionShow: TcxButton;
    PnBuscar: TRzPanel;
    TxBuscar: TcxTextEdit;
    FdData: TFDMemTable;
    DsData: TDataSource;
    stContentOdd: TcxStyle;
    stContentEven: TcxStyle;
    StInactive: TcxStyle;
    StSelection: TcxStyle;
    procedure TxBuscarPropertiesChange(Sender: TObject);
    procedure BtInsertClick(Sender: TObject);
    procedure BtUpdateClick(Sender: TObject);
    procedure BtShowClick(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure BtDuplicateClick(Sender: TObject);
  private
  protected
    FOperation: TTypeOperation;
    FFieldOrder: string;
    FTotalRecords: integer;

    procedure filterRecords;
  public
  end;

var
  FBaseListView: TFBaseListView;

implementation

{$R *.dfm}
{ TFBaseListView }

procedure TFBaseListView.BtDeleteClick(Sender: TObject);
begin
  inherited;
  FOperation := toDelete;
end;

procedure TFBaseListView.BtDuplicateClick(Sender: TObject);
begin
  inherited;
  FOperation := toDuplicate;
end;

procedure TFBaseListView.BtInsertClick(Sender: TObject);
begin
  inherited;
  FOperation := toInsert;
end;

procedure TFBaseListView.BtShowClick(Sender: TObject);
begin
  inherited;
  FOperation := toShow;
end;

procedure TFBaseListView.BtUpdateClick(Sender: TObject);
begin
  inherited;
  FOperation := toUpdate;
end;

procedure TFBaseListView.filterRecords;
begin
  FdData.Filtered := False;

  if not(TxBuscar.Text = EmptyStr) then
  begin
    FdData.Filter := UpperCase(FFieldOrder) + ' like ''%' +
      AnsiUpperCase(TxBuscar.Text) + '%''';

    FdData.Filtered := True;
  end;
end;

procedure TFBaseListView.TxBuscarPropertiesChange(Sender: TObject);
begin
  inherited;
  filterRecords;
end;

end.
