unit ProductInsert.Controller;

interface

uses Product.Controller.interf, Product.Model.interf,
  System.SysUtils, TSTOPRODUCT.Entity.Model;

type
  TProductInsertController = class(TInterfacedObject, iProductInsertController)
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

    class function New: iProductInsertController;

    function productModel(AValue: IProductModel): iProductInsertController;

    function companyId(AValue: string): iProductInsertController;
    function codeSinapi(AValue: string): iProductInsertController;
    function description(AValue: string): iProductInsertController;
    function unitMeasure(AValue: string): iProductInsertController;
    function originPrice(AValue: string): iProductInsertController;
    function averagePrice(AValue: Currency): iProductInsertController;
    function averagePriceSinapi(AValue: Currency): iProductInsertController;
    function status(AValue: Integer): iProductInsertController;
    function userId(AValue: string): iProductInsertController;

    procedure save;
  end;

implementation

{ TProductInsertController }

function TProductInsertController.averagePrice(AValue: Currency): iProductInsertController;
begin
  Result := Self;
  FAveragePrice := AValue;
end;

function TProductInsertController.averagePriceSinapi(AValue: Currency): iProductInsertController;
begin
  Result := Self;
  FAveragePriceSinapi := AValue;
end;

function TProductInsertController.codeSinapi(AValue: string): iProductInsertController;
begin
  Result := Self;
  FCodeSinapi := AValue;
end;

function TProductInsertController.companyId(AValue: string): iProductInsertController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TProductInsertController.Create;
begin

end;

function TProductInsertController.description(AValue: string): iProductInsertController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TProductInsertController.Destroy;
begin

  inherited;
end;

class function TProductInsertController.New: iProductInsertController;
begin
  Result := Self.Create;
end;

function TProductInsertController.originPrice(AValue: string): iProductInsertController;
begin
  Result := Self;
  FOriginPrice := AValue;
end;

function TProductInsertController.getProductId: Integer;
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

procedure TProductInsertController.save;
begin
  FProductModel.Entity(TTSTOPRODUCT.Create);

  FProductModel.Entity.COMPANYID           := FCompanyId;
  FProductModel.Entity.PRODUCTID           := getProductId;
  FProductModel.Entity.CODE_SINAPI         := FCodeSinapi;
  FProductModel.Entity.DESCRIPTION         := FDescription;
  FProductModel.Entity.UNITMEASURE         := FUnitMeasure;
  FProductModel.Entity.ORIGINPRICE         := FOriginPrice;
  FProductModel.Entity.AVERAGEPRICE        := FAveragePrice;
  FProductModel.Entity.AVERAGEPRICE_SINAPI := FAveragePriceSinapi;
  FProductModel.Entity.STATUS              := FStatus;
  FProductModel.Entity.USERID              := FUserId;
  FProductModel.Entity.CREATEDAT           := Now;
  FProductModel.Entity.UPDATEDAT           := Now;

  FProductModel.DAO.Insert(FProductModel.Entity);
end;

function TProductInsertController.status(AValue: Integer): iProductInsertController;
begin
  Result := Self;
  FStatus := AValue;
end;

function TProductInsertController.unitMeasure(AValue: string): iProductInsertController;
begin
  Result := Self;
  FUnitMeasure := AValue;
end;

function TProductInsertController.userId(AValue: string): iProductInsertController;
begin
  Result := Self;
  FUserId := AValue;
end;

function TProductInsertController.productModel(AValue: IProductModel)
  : iProductInsertController;
begin
  Result := Self;
  FProductModel := AValue;
end;

end.
