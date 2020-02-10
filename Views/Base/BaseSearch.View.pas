unit BaseSearch.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  cxControls, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxTextEdit, cxLabel, Vcl.StdCtrls, cxButtons, RzLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFBaseSearchView = class(TFBaseView)
    PnContent: TRzPanel;
    PnGridHeader: TRzPanel;
    LbBuscar: TcxLabel;
    PnBuscar: TRzPanel;
    TxBuscar: TcxTextEdit;
    PnGridFooter: TRzPanel;
    LbTotalRegistros: TRzLabel;
    PnGrid: TRzPanel;
    DbDados: TcxGrid;
    VwDados: TcxGridDBTableView;
    LvDados: TcxGridLevel;
    FdDados: TFDMemTable;
    DsDados: TDataSource;
    StGridStyles: TcxStyleRepository;
    StHeader: TcxStyle;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBaseSearchView: TFBaseSearchView;

implementation

{$R *.dfm}

procedure TFBaseSearchView.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Height := Screen.Height - 300;
  Self.Width  := Screen.Width - 300;
end;

end.
