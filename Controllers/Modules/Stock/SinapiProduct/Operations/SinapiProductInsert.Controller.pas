unit SinapiProductInsert.Controller;

interface

uses SinapiProduct.Controller.interf, SinapiProduct.Model.interf,
   System.SysUtils, TSTOSINAPIPRODUCT.Entity.Model;

type
   TSinapiProductInsertController = class(TInterfacedObject,
     iSinapiProductInsertController)
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

      class function New: iSinapiProductInsertController;

      function productModel(AValue: iSinapiProductModel)
        : iSinapiProductInsertController;

      function companyId(AValue: string): iSinapiProductInsertController;
      function codeSinapi(AValue: string): iSinapiProductInsertController;
      function description(AValue: string): iSinapiProductInsertController;
      function unitMeasure(AValue: string): iSinapiProductInsertController;
      function originPrice(AValue: string): iSinapiProductInsertController;
      function averagePrice(AValue: Currency): iSinapiProductInsertController;
      function averagePriceSinapi(AValue: Currency)
        : iSinapiProductInsertController;
      function status(AValue: Integer): iSinapiProductInsertController;
      function userId(AValue: string): iSinapiProductInsertController;

      procedure save;
   end;

implementation

{ TSinapiProductInsertController }

function TSinapiProductInsertController.averagePrice(AValue: Currency)
  : iSinapiProductInsertController;
begin
   Result := Self;
   FAveragePrice := AValue;
end;

function TSinapiProductInsertController.averagePriceSinapi(AValue: Currency)
  : iSinapiProductInsertController;
begin
   Result := Self;
   FAveragePriceSinapi := AValue;
end;

function TSinapiProductInsertController.codeSinapi(AValue: string)
  : iSinapiProductInsertController;
begin
   Result := Self;
   FCodeSinapi := AValue;
end;

function TSinapiProductInsertController.companyId(AValue: string)
  : iSinapiProductInsertController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TSinapiProductInsertController.Create;
begin

end;

function TSinapiProductInsertController.description(AValue: string)
  : iSinapiProductInsertController;
begin
   Result := Self;
   FDescription := AValue;
end;

destructor TSinapiProductInsertController.Destroy;
begin

   inherited;
end;

class function TSinapiProductInsertController.New
  : iSinapiProductInsertController;
begin
   Result := Self.Create;
end;

function TSinapiProductInsertController.originPrice(AValue: string)
  : iSinapiProductInsertController;
begin
   Result := Self;
   FOriginPrice := AValue;
end;

function TSinapiProductInsertController.getProductId: Integer;
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

procedure TSinapiProductInsertController.save;
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

function TSinapiProductInsertController.status(AValue: Integer)
  : iSinapiProductInsertController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TSinapiProductInsertController.unitMeasure(AValue: string)
  : iSinapiProductInsertController;
begin
   Result := Self;
   FUnitMeasure := AValue;
end;

function TSinapiProductInsertController.userId(AValue: string)
  : iSinapiProductInsertController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TSinapiProductInsertController.productModel
  (AValue: iSinapiProductModel): iSinapiProductInsertController;
begin
   Result := Self;
   FProductModel := AValue;
end;

end.
