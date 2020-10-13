unit BDG0002AView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseList.View, cxGraphics,
   cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
   dxSkinsCore, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
   dxSkinDevExpressStyle, cxControls,
   cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
   cxNavigator,
   cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
   FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Stan.Async,
   FireDAC.DApt, System.ImageList, Vcl.ImgList, cxImageList,
   FireDAC.Comp.Client, FireDAC.Comp.DataSet, cxClasses,
   cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
   cxGridDBTableView, cxGrid, cxTextEdit, cxLabel,
   Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
   Base.View.interf, DataMFirebird.Model, BDG0001FView, BDG0001IView;

type
   TFBDG0002AView = class(TFBaseListView, iBaseListView)
    FdQDataPROVIDERID: TIntegerField;
    FdQDataDESCRIPTION: TStringField;
    FdQDataEMISSIONDATE: TDateField;
    FdQDataTOTALITENS: TIntegerField;
    FdQDataTOTALBUDGET: TFMTBCDField;
    VwDadosPROVIDERID: TcxGridDBColumn;
    VwDadosDESCRIPTION: TcxGridDBColumn;
    VwDadosEMISSIONDATE: TcxGridDBColumn;
    VwDadosTOTALITENS: TcxGridDBColumn;
    VwDadosTOTALBUDGET: TcxGridDBColumn;
    FdQDataUSERNAME: TStringField;
    FdQDataCREATEDAT: TSQLTimeStampField;
    FdQDataUPDATEDAT: TSQLTimeStampField;
    VwDadosUSERNAME: TcxGridDBColumn;
    VwDadosCREATEDAT: TcxGridDBColumn;
    VwDadosUPDATEDAT: TcxGridDBColumn;
    FdQDataBUDGETCODE: TStringField;
    RzPanel1: TRzPanel;
    cxButton1: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure BtOptionShowClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
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
   FBDG0002AView: TFBDG0002AView;

implementation

{$R *.dfm}
{ TFBaseListView1 }

procedure TFBDG0002AView.BtOptionShowClick(Sender: TObject);
begin
  inherited;

  TFBDG0002FView.New
  .companyId(FSessionCompany)
  .budgetId(FdQDataBUDGETCODE.AsString)
  .Exibir;
end;

procedure TFBDG0002AView.cxButton1Click(Sender: TObject);
begin
  inherited;

  TFBDG0001IView.New.Exibir;
end;

procedure TFBDG0002AView.deleteRecord;
begin

end;

procedure TFBDG0002AView.duplicateRecord;
begin

end;

procedure TFBDG0002AView.&end;
begin

  Show;
end;

procedure TFBDG0002AView.FormShow(Sender: TObject);
begin
   FFieldOrder := 'DESCRIPTION';

   { 1 } listRecords;
   { 2 } totalRecords;
   { 3 } disableButtonsWhenfdQDataEmpty;
end;

procedure TFBDG0002AView.insertRecord;
begin

end;

procedure TFBDG0002AView.listRecords;
begin
   FdQData.ParamByName('companyId').AsString := FSessionCompany;
   FdQData.Close;
   FdQData.Open();
end;

class function TFBDG0002AView.New: iBaseListView;
begin
   Result := Self.Create(nil);
end;

procedure TFBDG0002AView.showRecord;
begin

end;

procedure TFBDG0002AView.updateRecord;
begin

end;

end.
