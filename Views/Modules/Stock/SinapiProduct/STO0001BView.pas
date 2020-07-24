unit STO0001BView;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseRegister.View, cxGraphics,
   cxLookAndFeels,
   cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDarkRoom,
   dxSkinDarkSide,
   dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, System.Actions,
   Vcl.ActnList, Vcl.StdCtrls,
   cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, cxControls,
   cxContainer, cxEdit,
   cxMaskEdit, cxDropDownEdit, cxLabel, cxTextEdit, cxMemo, cxCurrencyEdit,
   Base.View.interf,
   Types.Controllers, SinapiProduct.Controller.interf;

type
   TFSTO0001BView = class(TFBaseRegisterView, iBaseRegisterView)
      TxProductId: TcxTextEdit;
      LbExpenseId: TcxLabel;
      LbDescription: TcxLabel;
      TxOriginPrice: TcxTextEdit;
      CbStatus: TcxComboBox;
      LbStatus: TcxLabel;
      TxCodeSinapi: TcxTextEdit;
      cxLabel1: TcxLabel;
      TxDescription: TcxMemo;
      cxLabel2: TcxLabel;
      TxUnitMeasure: TcxTextEdit;
      cxLabel3: TcxLabel;
      cxLabel4: TcxLabel;
      TxAveragePrice: TcxCurrencyEdit;
      TxAveragePriceSinapi: TcxCurrencyEdit;
      cxLabel5: TcxLabel;
      LbUpdatedAt: TcxLabel;
      TxUpdatedDate: TcxTextEdit;
      TxCreatedDate: TcxTextEdit;
      LbCreatedAt: TcxLabel;
      procedure FormCreate(Sender: TObject);
      procedure CbStatusPropertiesChange(Sender: TObject);
      procedure TxDescriptionPropertiesChange(Sender: TObject);
      procedure TxCodeSinapiPropertiesChange(Sender: TObject);
      procedure TxUnitMeasurePropertiesChange(Sender: TObject);
      procedure TxOriginPricePropertiesChange(Sender: TObject);
      procedure TxAveragePricePropertiesChange(Sender: TObject);
      procedure TxAveragePriceSinapiPropertiesChange(Sender: TObject);
      procedure BtConfirmarClick(Sender: TObject);
   private
      FSinapiProductController: iSinapiProductController;
   public
      class function New: iBaseRegisterView;

      function operation(AValue: TTypeOperation): iBaseRegisterView;
      function selectedRecord(AValue: string): iBaseRegisterView;

      procedure insertRecord;
      procedure updateRecord;
      procedure deleteRecord;
      procedure duplicateRecord;

      procedure save;
      procedure showDataOnScreen;
      procedure disableFields;

      procedure &end;
   end;

var
   FSTO0001BView: TFSTO0001BView;

implementation

{$R *.dfm}

uses Facade.Controller;

{ TFSTO0001BView }

procedure TFSTO0001BView.BtConfirmarClick(Sender: TObject);
begin
   save;

   inherited;
end;

procedure TFSTO0001BView.CbStatusPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFSTO0001BView.deleteRecord;
begin
   FSinapiProductController.delete.save;
end;

procedure TFSTO0001BView.disableFields;
begin
   CbStatus.Enabled := not(FOperation in [toShow, toDelete]);
   TxDescription.Enabled := not(FOperation in [toShow, toDelete]);
   TxCodeSinapi.Enabled := not(FOperation in [toShow, toDelete]);
   TxUnitMeasure.Enabled := not(FOperation in [toShow, toDelete]);
   TxOriginPrice.Enabled := not(FOperation in [toShow, toDelete]);
   TxAveragePrice.Enabled := not(FOperation in [toShow, toDelete]);
   TxAveragePriceSinapi.Enabled := not(FOperation in [toShow, toDelete]);

   PnButtonConfirm.Visible := not(FOperation = toShow);
   BtConfirmar.Visible := not(FOperation = toShow);
end;

procedure TFSTO0001BView.duplicateRecord;
begin
   FSinapiProductController.duplicate.companyId(FSessionCompany)
     .codeSinapi(TxCodeSinapi.Text).description(TxDescription.Text)
     .unitMeasure(TxUnitMeasure.Text).originPrice(TxOriginPrice.Text)
     .averagePrice(TxAveragePrice.Value).averagePriceSinapi
     (TxAveragePriceSinapi.Value).status(CbStatus.ItemIndex)
     .userId(FSessionUser).save;
end;

procedure TFSTO0001BView.&end;
begin
   showDataOnScreen;
   disableFields;
   showCurrentOperation;

   ShowModal;
end;

procedure TFSTO0001BView.FormCreate(Sender: TObject);
begin
   inherited;
   FSinapiProductController := TFacadeController.New.ModulesFacadeController.
     StockFactoryController.sinapiProductController;
end;

procedure TFSTO0001BView.insertRecord;
begin
   FSinapiProductController.insert.companyId(FSessionCompany)
     .codeSinapi(TxCodeSinapi.Text).description(TxDescription.Text)
     .unitMeasure(TxUnitMeasure.Text).originPrice(TxOriginPrice.Text)
     .averagePrice(TxAveragePrice.Value).averagePriceSinapi
     (TxAveragePriceSinapi.Value).status(CbStatus.ItemIndex)
     .userId(FSessionUser).save;
end;

class function TFSTO0001BView.New: iBaseRegisterView;
begin
   Result := Self.Create(nil);
end;

function TFSTO0001BView.operation(AValue: TTypeOperation): iBaseRegisterView;
begin
   Result := Self;
   FOperation := AValue;
end;

procedure TFSTO0001BView.save;
begin
   case FOperation of
      toInsert:
         insertRecord;

      toUpdate:
         updateRecord;

      toDelete:
         deleteRecord;

      toDuplicate:
         duplicateRecord;
   end;
end;

function TFSTO0001BView.selectedRecord(AValue: string): iBaseRegisterView;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

procedure TFSTO0001BView.showDataOnScreen;
begin
   if (FOperation in [toInsert]) or (FSelectedRecord = EmptyStr) then
      Exit;

   FSinapiProductController.find(FSelectedRecord);

   TxProductId.Text := FSinapiProductController.productId;
   TxDescription.Text := FSinapiProductController.description;

   if not(FOperation in [toDuplicate]) then
      TxCodeSinapi.Text := FSinapiProductController.codeSinapi;

   TxUnitMeasure.Text := FSinapiProductController.unitMeasure;
   TxOriginPrice.Text := FSinapiProductController.originPrice;
   TxAveragePrice.Value := FSinapiProductController.averagePrice;
   TxAveragePriceSinapi.Value := FSinapiProductController.averagePriceSinapi;
   CbStatus.ItemIndex := FSinapiProductController.status;

   TxCreatedDate.Text := FSinapiProductController.createdAt;
   TxUpdatedDate.Text := FSinapiProductController.updatedAt;

   if not(FOperation in [toDelete]) then
      BtConfirmar.Enabled := False;
end;

procedure TFSTO0001BView.TxAveragePricePropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFSTO0001BView.TxAveragePriceSinapiPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFSTO0001BView.TxCodeSinapiPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFSTO0001BView.TxDescriptionPropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFSTO0001BView.TxOriginPricePropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFSTO0001BView.TxUnitMeasurePropertiesChange(Sender: TObject);
begin
   inherited;
   changeDataAnyFields;
end;

procedure TFSTO0001BView.updateRecord;
begin
   FSinapiProductController.update.companyId(FSessionCompany)
     .codeSinapi(TxCodeSinapi.Text).description(TxDescription.Text)
     .unitMeasure(TxUnitMeasure.Text).originPrice(TxOriginPrice.Text)
     .averagePrice(TxAveragePrice.Value).averagePriceSinapi
     (TxAveragePriceSinapi.Value).status(CbStatus.ItemIndex)
     .userId(FSessionUser).save;
end;

end.
