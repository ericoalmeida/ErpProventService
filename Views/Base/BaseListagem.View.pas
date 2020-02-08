unit BaseListagem.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, Vcl.StdCtrls, RzLabel, dxGDIPlusClasses,
  Vcl.ExtCtrls, RzPanel, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, cxButtons, cxControls, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.Mask, RzEdit, cxContainer, cxLabel, cxTextEdit;

type
  TFBaseListagemView = class(TFBaseView)
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
    TxBuscar: TcxTextEdit;
    StGridStyles: TcxStyleRepository;
    StHeader: TcxStyle;
    RzOptionShow: TRzPanel;
    BtOptionShow: TcxButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBaseListagemView: TFBaseListagemView;

implementation

{$R *.dfm}

end.
