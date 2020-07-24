unit SinapiProductDuplicate.Controller;

interface

uses SinapiProduct.Controller.interf, SinapiProduct.Model.interf,
   System.SysUtils, TSTOSINAPIPRODUCT.Entity.Model;

type
   TSinapiProductDuplicateController = class(TInterfacedObject,
     iSinapiProductDuplicateController)
   private
      FProductModel: iSinapiProductModel;

      FCompanyId: string;
      FCodeSinapi: string;
      FDescription: string;
      FUnitMeasure: string;
      FOriginPrice: string;
      FAveragePrice: Currency;
      FAveragePriceSinapi: Currency;
      FStatus: Integer;
      FUserId: string;

      function getProductId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iSinapiProductDuplicateController;

      function productModel(AValue: iSinapiProductModel)
        : iSinapiProductDuplicateController;

      function companyId(AValue: string): iSinapiProductDuplicateController;
      function codeSinapi(AValue: string): iSinapiProductDuplicateController;
      function description(AValue: string): iSinapiProductDuplicateController;
      function unitMeasure(AValue: string): iSinapiProductDuplicateController;
      function originPrice(AValue: string): iSinapiProductDuplicateController;
      function averagePrice(AValue: Currency)
        : iSinapiProductDuplicateController;
      function averagePriceSinapi(AValue: Currency)
        : iSinapiProductDuplicateController;
      function status(AValue: Integer): iSinapiProductDuplicateController;
      function userId(AValue: string): iSinapiProductDuplicateController;

      procedure save;
   end;

implementation

{ TSinapiProductDuplicateController }

function TSinapiProductDuplicateController.averagePrice(AValue: Currency)
  : iSinapiProductDuplicateController;
begin
   Result := Self;
   FAveragePrice := AValue;
end;

function TSinapiProductDuplicateController.averagePriceSinapi(AValue: Currency)
  : iSinapiProductDuplicateController;
begin
   Result := Self;
   FAveragePriceSinapi := AValue;
end;

function TSinapiProductDuplicateController.codeSinapi(AValue: string)
  : iSinapiProductDuplicateController;
begin
   Result := Self;
   FCodeSinapi := AValue;
end;

function TSinapiProductDuplicateController.companyId(AValue: string)
  : iSinapiProductDuplicateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TSinapiProductDuplicateController.Create;
begin

end;

function TSinapiProductDuplicateController.description(AValue: string)
  : iSinapiProductDuplicateController;
begin
   Result := Self;
   FDescription := AValue;
end;

destructor TSinapiProductDuplicateController.Destroy;
begin

   inherited;
end;

class function TSinapiProductDuplicateController.New
  : iSinapiProductDuplicateController;
begin
   Result := Self.Create;
end;

function TSinapiProductDuplicateController.originPrice(AValue: string)
  : iSinapiProductDuplicateController;
begin
   Result := Self;
   FOriginPrice := AValue;
end;

function TSinapiProductDuplicateController.getProductId: Integer;
begin
   if FProductModel.DAO.Find.Count <> 0 then
   begin
      Result := FProductModel.DAO.FindWhere(Format('COMPANYID = %s',
        [QuotedStr(FCompanyId)]), 'PRODUCTID desc').Last.PRODUCTID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

procedure TSinapiProductDuplicateController.save;
begin
   FProductModel.Entity(TTSTOSINAPIPRODUCT.Create);

   FProductModel.Entity.companyId := FCompanyId;
   FProductModel.Entity.PRODUCTID := getProductId;
   FProductModel.Entity.CODE_SINAPI := FCodeSinapi;
   FProductModel.Entity.description := FDescription;
   FProductModel.Entity.unitMeasure := FUnitMeasure;
   FProductModel.Entity.originPrice := FOriginPrice;
   FProductModel.Entity.averagePrice := FAveragePrice;
   FProductModel.Entity.AVERAGEPRICE_SINAPI := FAveragePriceSinapi;
   FProductModel.Entity.status := FStatus;
   FProductModel.Entity.userId := FUserId;
   FProductModel.Entity.CREATEDAT := Now;
   FProductModel.Entity.UPDATEDAT := Now;

   FProductModel.DAO.Insert(FProductModel.Entity);
end;

function TSinapiProductDuplicateController.status(AValue: Integer)
  : iSinapiProductDuplicateController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TSinapiProductDuplicateController.unitMeasure(AValue: string)
  : iSinapiProductDuplicateController;
begin
   Result := Self;
   FUnitMeasure := AValue;
end;

function TSinapiProductDuplicateController.userId(AValue: string)
  : iSinapiProductDuplicateController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TSinapiProductDuplicateController.productModel
  (AValue: iSinapiProductModel): iSinapiProductDuplicateController;
begin
   Result := Self;
   FProductModel := AValue;
end;

end.
