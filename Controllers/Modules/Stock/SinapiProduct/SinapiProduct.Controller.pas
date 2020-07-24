unit SinapiProduct.Controller;

interface

uses SinapiProduct.Controller.Interf, SinapiProduct.Model.Interf,
   System.SysUtils, TSTOSINAPIPRODUCT.Entity.Model;

type
   TSinapiProductController = class(TInterfacedObject, iSinapiProductController)
   private
      FProductModel: iSinapiProductModel;
      FRecordFound: TTSTOSINAPIPRODUCT;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iSinapiProductController;

      function find(AValue: string): iSinapiProductController;

      function insert: iSinapiProductInsertController;
      function update: iSinapiProductUpdateController;
      function delete: iSinapiProductDeleteController;
      function duplicate: iSinapiProductDuplicateController;

      function code: string;
      function productId: string;
      function codeSinapi: string;
      function description: string;
      function unitMeasure: string;
      function originPrice: string;
      function averagePrice: Currency;
      function averagePriceSinapi: Currency;
      function status: Integer;
      function userId: string;
      function createdAt: string;
      function updatedAt: string;
   end;

implementation

{ TSinapiProductController }

uses Facade.Model, SinapiProductInsert.Controller,
   SinapiProductUpdate.Controller,
   SinapiProductDelete.Controller, SinapiProductDuplicate.Controller;

function TSinapiProductController.averagePrice: Currency;
begin
   Result := FRecordFound.averagePrice;
end;

function TSinapiProductController.averagePriceSinapi: Currency;
begin
   Result := FRecordFound.AVERAGEPRICE_SINAPI;
end;

function TSinapiProductController.code: string;
begin
   Result := FRecordFound.code;
end;

function TSinapiProductController.productId: string;
begin
   Result := FRecordFound.productId.ToString;
end;

function TSinapiProductController.codeSinapi: string;
begin
   Result := FRecordFound.CODE_SINAPI;
end;

function TSinapiProductController.status: Integer;
begin
   Result := FRecordFound.status;
end;

constructor TSinapiProductController.Create;
begin
   FProductModel := TFacadeModel.New.moduleFacade.stockFactoryModel.
     sinapiProductModel;
end;

function TSinapiProductController.createdAt: string;
begin
   Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TSinapiProductController.delete: iSinapiProductDeleteController;
begin
   Result := TSinapiProductDeleteController.New.productModel(FProductModel)
     .selectedRecord(FRecordFound);
end;

function TSinapiProductController.description: string;
begin
   Result := FRecordFound.description;
end;

destructor TSinapiProductController.Destroy;
begin

   inherited;
end;

function TSinapiProductController.duplicate: iSinapiProductDuplicateController;
begin
   Result := TSinapiProductDuplicateController.New.productModel(FProductModel);
end;

function TSinapiProductController.insert: iSinapiProductInsertController;
begin
   Result := TSinapiProductInsertController.New.productModel(FProductModel);
end;

class function TSinapiProductController.New: iSinapiProductController;
begin
   Result := Self.Create;
end;

function TSinapiProductController.originPrice: string;
begin
   Result := FRecordFound.originPrice;
end;

function TSinapiProductController.find(AValue: string)
  : iSinapiProductController;
begin
   Result := Self;

   FRecordFound := FProductModel.DAO.FindWhere
     (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TSinapiProductController.unitMeasure: string;
begin
   Result := FRecordFound.unitMeasure;
end;

function TSinapiProductController.update: iSinapiProductUpdateController;
begin
   Result := TSinapiProductUpdateController.New.productModel(FProductModel)
     .selectedRecord(FRecordFound);
end;

function TSinapiProductController.updatedAt: string;
begin
   Result := DateTimeToStr(FRecordFound.updatedAt);
end;

function TSinapiProductController.userId: string;
begin
   Result := FRecordFound.userId;
end;

end.
