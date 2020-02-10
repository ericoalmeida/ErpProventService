unit BaseList.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, Vcl.StdCtrls, RzLabel, dxGDIPlusClasses,
  Vcl.ExtCtrls, RzPanel, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxButtons, cxControls, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.Mask, RzEdit, cxContainer, cxLabel, cxTextEdit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    FdDados: TFDMemTable;
    DsDados: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBaseListView: TFBaseListView;

implementation

{$R *.dfm}

end.
