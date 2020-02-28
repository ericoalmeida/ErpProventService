unit ProductDuplicate.Controller;

interface

uses Product.Controller.interf, Product.Model.interf,
  System.SysUtils, TSTOPRODUCT.Entity.Model;

type
  TProductDuplicateController = class(TInterfacedObject,
    iProductDuplicateController)
  private
    FProductModel: IProductModel;

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

    class function New: iProductDuplicateController;

    function productModel(AValue: IProductModel): iProductDuplicateController;

    function companyId(AValue: string): iProductDuplicateController;
    function codeSinapi(AValue: string): iProductDuplicateController;
    function description(AValue: string): iProductDuplicateController;
    function unitMeasure(AValue: string): iProductDuplicateController;
    function originPrice(AValue: string): iProductDuplicateController;
    function averagePrice(AValue: Currency): iProductDuplicateController;
    function averagePriceSinapi(AValue: Currency): iProductDuplicateController;
    function status(AValue: Integer): iProductDuplicateController;
    function userId(AValue: string): iProductDuplicateController;

    procedure save;
  end;

implementation

{ TProductDuplicateController }

function TProductDuplicateController.averagePrice(AValue: Currency)
  : iProductDuplicateController;
begin
  Result := Self;
  FAveragePrice := AValue;
end;

function TProductDuplicateController.averagePriceSinapi(AValue: Currency)
  : iProductDuplicateController;
begin
  Result := Self;
  FAveragePriceSinapi := AValue;
end;

function TProductDuplicateController.codeSinapi(AValue: string)
  : iProductDuplicateController;
begin
  Result := Self;
  FCodeSinapi := AValue;
end;

function TProductDuplicateController.companyId(AValue: string)
  : iProductDuplicateController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TProductDuplicateController.Create;
begin

end;

function TProductDuplicateController.description(AValue: string)
  : iProductDuplicateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TProductDuplicateController.Destroy;
begin

  inherited;
end;

class function TProductDuplicateController.New: iProductDuplicateController;
begin
  Result := Self.Create;
end;

function TProductDuplicateController.originPrice(AValue: string)
  : iProductDuplicateController;
begin
  Result := Self;
  FOriginPrice := AValue;
end;

function TProductDuplicateController.getProductId: Integer;
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

procedure TProductDuplicateController.save;
begin
  FProductModel.Entity(TTSTOPRODUCT.Create);

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

function TProductDuplicateController.status(AValue: Integer)
  : iProductDuplicateController;
begin
  Result := Self;
  FStatus := AValue;
end;

function TProductDuplicateController.unitMeasure(AValue: string)
  : iProductDuplicateController;
begin
  Result := Self;
  FUnitMeasure := AValue;
end;

function TProductDuplicateController.userId(AValue: string)
  : iProductDuplicateController;
begin
  Result := Self;
  FUserId := AValue;
end;

function TProductDuplicateController.productModel(AValue: IProductModel)
  : iProductDuplicateController;
begin
  Result := Self;
  FProductModel := AValue;
end;

end.
