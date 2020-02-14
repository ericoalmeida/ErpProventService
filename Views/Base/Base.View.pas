unit Base.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, RzPanel, cxGraphics,
  cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses,
  ormbr.Factory.Interfaces, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Silver;

type
  TFBaseView = class(TForm)
    PnContainer: TRzPanel;
    PnHeader: TRzPanel;
    PnProgram: TRzPanel;
    LbProgram: TRzLabel;
    ImTitle: TImage;
    LbTitle: TRzLabel;
    PnContainerBody: TRzPanel;
    PnFooterBody: TRzPanel;
    BtSair: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    FConnection: IDBConnection;
    FFdConnection: TFDConnection;

    function iff(AExpression: boolean; AWhenBeTrue: Integer;  AWhenBeFalse: Integer): Integer;

  public
    { Public declarations }
  end;

var
  FBaseView: TFBaseView;

implementation

{$R *.dfm}

uses Facade.Controller;

procedure TFBaseView.BtSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFBaseView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFBaseView.FormCreate(Sender: TObject);
begin
  LbProgram.Caption := Self.Name;

  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;

  FFdConnection := TFacadeController.New.ConnectionFactoryController.
    currentFdConnection;
end;

function TFBaseView.iff(AExpression: boolean; AWhenBeTrue, AWhenBeFalse: Integer): Integer;
begin
 if AExpression then
  Result := AWhenBeTrue
 else
  Result := AWhenBeFalse;
end;

end.
