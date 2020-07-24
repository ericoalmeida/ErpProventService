unit SinapiProductUpdate.Controller;

interface

uses SinapiProduct.Controller.interf, SinapiProduct.Model.interf,
   System.SysUtils,
   TSTOSINAPIPRODUCT.Entity.Model;

type
   TSinapiProductUpdateController = class(TInterfacedObject,
     iSinapiProductUpdateController)
   private
      FProductModel: iSinapiProductModel;
      FSelectedRecord: TTSTOSINAPIPRODUCT;

      FCompanyId: string;
      FCodeSinapi: string;
      FDescription: string;
      FUnitMeasure: string;
      FOriginPrice: string;
      FAveragePrice: Currency;
      FAveragePriceSinapi: Currency;
      FStatus: Integer;
      FUserId: string;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iSinapiProductUpdateController;

      function productModel(AValue: iSinapiProductModel)
        : iSinapiProductUpdateController;
      function selectedRecord(AValue: TTSTOSINAPIPRODUCT)
        : iSinapiProductUpdateController;

      function companyId(AValue: string): iSinapiProductUpdateController;
      function codeSinapi(AValue: string): iSinapiProductUpdateController;
      function description(AValue: string): iSinapiProductUpdateController;
      function unitMeasure(AValue: string): iSinapiProductUpdateController;
      function originPrice(AValue: string): iSinapiProductUpdateController;
      function averagePrice(AValue: Currency): iSinapiProductUpdateController;
      function averagePriceSinapi(AValue: Currency)
        : iSinapiProductUpdateController;
      function status(AValue: Integer): iSinapiProductUpdateController;
      function userId(AValue: string): iSinapiProductUpdateController;

      procedure save;
   end;

implementation

{ TSinapiProductUpdateController }

function TSinapiProductUpdateController.productModel
  (AValue: iSinapiProductModel): iSinapiProductUpdateController;
begin
   Result := Self;
   FProductModel := AValue;
end;

function TSinapiProductUpdateController.averagePrice(AValue: Currency)
  : iSinapiProductUpdateController;
begin
   Result := Self;
   FAveragePrice := AValue;
end;

function TSinapiProductUpdateController.averagePriceSinapi(AValue: Currency)
  : iSinapiProductUpdateController;
begin
   Result := Self;
   FAveragePriceSinapi := AValue;
end;

function TSinapiProductUpdateController.codeSinapi(AValue: string)
  : iSinapiProductUpdateController;
begin
   Result := Self;
   FCodeSinapi := AValue;
end;

function TSinapiProductUpdateController.companyId(AValue: string)
  : iSinapiProductUpdateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TSinapiProductUpdateController.Create;
begin

end;

function TSinapiProductUpdateController.description(AValue: string)
  : iSinapiProductUpdateController;
begin
   Result := Self;
   FDescription := AValue;
end;

destructor TSinapiProductUpdateController.Destroy;
begin

   inherited;
end;

class function TSinapiProductUpdateController.New
  : iSinapiProductUpdateController;
begin
   Result := Self.Create;
end;

function TSinapiProductUpdateController.originPrice(AValue: string)
  : iSinapiProductUpdateController;
begin
   Result := Self;
   FOriginPrice := AValue;
end;

procedure TSinapiProductUpdateController.save;
begin
   FProductModel.DAO.Modify(FSelectedRecord);

   FSelectedRecord.companyId := FCompanyId;
   FSelectedRecord.CODE_SINAPI := FCodeSinapi;
   FSelectedRecord.description := FDescription;
   FSelectedRecord.unitMeasure := FUnitMeasure;
   FSelectedRecord.originPrice := FOriginPrice;
   FSelectedRecord.averagePrice := FAveragePrice;
   FSelectedRecord.AVERAGEPRICE_SINAPI := FAveragePriceSinapi;
   FSelectedRecord.status := FStatus;
   FSelectedRecord.userId := FUserId;
   FSelectedRecord.UPDATEDAT := Now;

   FProductModel.DAO.Update(FSelectedRecord);
end;

function TSinapiProductUpdateController.selectedRecord
  (AValue: TTSTOSINAPIPRODUCT): iSinapiProductUpdateController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

function TSinapiProductUpdateController.status(AValue: Integer)
  : iSinapiProductUpdateController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TSinapiProductUpdateController.unitMeasure(AValue: string)
  : iSinapiProductUpdateController;
begin
   Result := Self;
   FUnitMeasure := AValue;
end;

function TSinapiProductUpdateController.userId(AValue: string)
  : iSinapiProductUpdateController;
begin
   Result := Self;
   FUserId := AValue;
end;

end.
