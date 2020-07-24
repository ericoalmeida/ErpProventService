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
   FireDAC.Comp.DataSet, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
   dxSkinOffice2007Black,
   dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Silver,
   Utils.Controller.Interf,
   dxSkinDarkRoom, dxSkinDarkSide;

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
      PnButtonCancel: TRzPanel;
      procedure FormCreate(Sender: TObject);
      procedure BtSairClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
      { Private declarations }
   protected
      FConnection: IDBConnection;
      FFdConnection: TFDConnection;
      FFieldOrder: string;
      FRecordShow: Integer;
      FTotalRecords: Integer;
      FUtils: iUtilsController;
      FSessionCompany: string;
      FSessionUser: string;

      function prepareStringOrderField(AValue: string): string;
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

   FUtils := TFacadeController.New.Utils;

   // temporariamente
   FSessionCompany := '{4FC5A103-F75F-43E9-AA50-E454DA804E20}';
   FSessionUser := '{177524BA-A3DA-4ECC-BFA4-388A3A06DF9F}';
end;

function TFBaseView.prepareStringOrderField(AValue: string): string;
begin
   AValue := StringReplace(AValue, 'VwDados', '', [rfReplaceAll, rfIgnoreCase]);

   Result := AValue;
end;

end.
