unit BDG0001FView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
   cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
   dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
   dxSkinDevExpressStyle, Vcl.StdCtrls, cxButtons, RzLabel,
   dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, cxControls, cxStyles, cxCustomData,
   cxFilter, cxData, cxDataStorage, cxEdit,
   cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
   Data.DB, cxDBData, cxGridLevel, cxClasses,
   cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
   cxGrid, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf,
   FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   DataMFirebird.Model;

type
   IFBDG0002FView = interface
      ['{2C971E17-EA85-4AB4-A364-83E7A7E261E9}']
      function companyId(AValue: string): IFBDG0002FView;
      function budgetId(AValue: string): IFBDG0002FView;

      procedure Exibir;
   end;

   TFBDG0002FView = class(TForm, IFBDG0002FView)
      PnContainer: TRzPanel;
      PnHeader: TRzPanel;
      ImTitle: TImage;
      LbTitle: TRzLabel;
      PnProgram: TRzPanel;
      LbProgram: TRzLabel;
      PnContainerBody: TRzPanel;
      PnFooterBody: TRzPanel;
      PnButtonConfirm: TRzPanel;
      BtConfirmar: TcxButton;
      PnContent: TRzPanel;
      VwDados: TcxGridDBTableView;
      LvDados: TcxGridLevel;
      DBDados: TcxGrid;
      RzPanel1: TRzPanel;
      DBDadosItens: TcxGrid;
      VwDadosItens: TcxGridDBTableView;
      LvDadosItens: TcxGridLevel;
      FdQDados: TFDQuery;
      DsDados: TDataSource;
      FdQDadosItens: TFDQuery;
      DsDadosItens: TDataSource;
      FdQDadosPROVIDERCODE: TStringField;
      FdQDadosPROVIDERID: TIntegerField;
      FdQDadosPROVIDERNAME: TStringField;
      FdQDadosTOTALITENS: TIntegerField;
      FdQDadosTOTALBUDGET: TFMTBCDField;
      VwDadosPROVIDERID: TcxGridDBColumn;
      VwDadosPROVIDERNAME: TcxGridDBColumn;
      VwDadosTOTALITENS: TcxGridDBColumn;
      VwDadosTOTALBUDGET: TcxGridDBColumn;
      StGridStyles: TcxStyleRepository;
      StHeader: TcxStyle;
      stContentOdd: TcxStyle;
      stContentEven: TcxStyle;
      StInactive: TcxStyle;
      StSelection: TcxStyle;
      StIndicator: TcxStyle;
      StDefaultColumn: TcxStyle;
      StColumnSelected: TcxStyle;
      StHeaderColumnSelected: TcxStyle;
      StDefaultHeaderColumn: TcxStyle;
      FdQDadosItensPRODUCTID: TIntegerField;
      FdQDadosItensCODE_SINAPI: TStringField;
      FdQDadosItensDESCRIPTION: TStringField;
      FdQDadosItensQTDE: TFMTBCDField;
      FdQDadosItensPRICEUNITY: TFMTBCDField;
      FdQDadosItensPRICETOTAL: TFMTBCDField;
      VwDadosItensPRODUCTID: TcxGridDBColumn;
      VwDadosItensCODE_SINAPI: TcxGridDBColumn;
      VwDadosItensDESCRIPTION: TcxGridDBColumn;
      VwDadosItensQTDE: TcxGridDBColumn;
      VwDadosItensPRICEUNITY: TcxGridDBColumn;
      VwDadosItensPRICETOTAL: TcxGridDBColumn;
      procedure FormShow(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
    procedure FdQDadosAfterScroll(DataSet: TDataSet);
   private
      FCompanyId: string;
      FBudgetId: string;

      procedure listarResultados;
      procedure listarItens;      
   public
      class function New: IFBDG0002FView;

      function companyId(AValue: string): IFBDG0002FView;
      function budgetId(AValue: string): IFBDG0002FView;

      procedure Exibir;
   end;

var
   FBDG0002FView: TFBDG0002FView;

implementation

{$R *.dfm}

procedure TFBDG0002FView.BtConfirmarClick(Sender: TObject);
begin
   Close;
end;

function TFBDG0002FView.budgetId(AValue: string): IFBDG0002FView;
begin
  Result := Self;
  FBudgetId := AValue;
end;

function TFBDG0002FView.companyId(AValue: string): IFBDG0002FView;
begin
  Result := Self;
  FCompanyId := AValue;
end;

procedure TFBDG0002FView.Exibir;
begin
   listarResultados;
   listarItens;

   ShowModal;
end;

procedure TFBDG0002FView.FdQDadosAfterScroll(DataSet: TDataSet);
begin
  listarItens;
end;

procedure TFBDG0002FView.FormCreate(Sender: TObject);
begin
   Self.Height := Screen.Height - 400;
   Self.Width := Screen.Width - 400;
end;

procedure TFBDG0002FView.FormShow(Sender: TObject);
begin
   LbProgram.Caption := Self.Name;
end;

procedure TFBDG0002FView.listarItens;
begin
   FdQDadosItens.ParamByName('companyId').AsString := FCompanyId;
   FdQDadosItens.ParamByName('budgetId').AsString := FBudgetId;   
   FdQDadosItens.ParamByName('providerId').AsString := FdQDadosPROVIDERCODE.AsString;   
   FdQDadosItens.Close;
   FdQDadosItens.Open();
end;

procedure TFBDG0002FView.listarResultados;
begin
   FdQDados.ParamByName('companyId').AsString := FCompanyId;
   FdQDados.ParamByName('budgetId').AsString := FBudgetId;   
   FdQDados.Close;
   FdQDados.Open();
end;

class function TFBDG0002FView.New: IFBDG0002FView;
begin
   Result := Self.Create(nil);
end;

end.
