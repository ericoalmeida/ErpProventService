unit ProductUpdate.Controller;

interface

uses Product.Controller.interf, Product.Model.interf, System.SysUtils,
  TSTOPRODUCT.Entity.Model;

type
  TProductUpdateController = class(TInterfacedObject, iProductUpdateController)
  private
    FProductModel: IProductModel;
    FSelectedRecord: TTSTOPRODUCT;

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

    class function New: iProductUpdateController;

    function productModel(AValue: IProductModel): iProductUpdateController;
    function selectedRecord(AValue: TTSTOPRODUCT): iProductUpdateController;

    function companyId(AValue: string): iProductUpdateController;
    function codeSinapi(AValue: string): iProductUpdateController;
    function description(AValue: string): iProductUpdateController;
    function unitMeasure(AValue: string): iProductUpdateController;
    function originPrice(AValue: string): iProductUpdateController;
    function averagePrice(AValue: Currency): iProductUpdateController;
    function averagePriceSinapi(AValue: Currency): iProductUpdateController;
    function status(AValue: Integer): iProductUpdateController;
    function userId(AValue: string): iProductUpdateController;

    procedure save;
  end;

implementation

{ TProductUpdateController }

function TProductUpdateController.productModel(AValue: IProductModel)
  : iProductUpdateController;
begin
  Result := Self;
  FProductModel := AValue;
end;

function TProductUpdateController.averagePrice(AValue: Currency)
  : iProductUpdateController;
begin
  Result := Self;
  FAveragePrice := AValue;
end;

function TProductUpdateController.averagePriceSinapi(AValue: Currency)
  : iProductUpdateController;
begin
  Result := Self;
  FAveragePriceSinapi := AValue;
end;

function TProductUpdateController.codeSinapi(AValue: string)
  : iProductUpdateController;
begin
  Result := Self;
  FCodeSinapi := AValue;
end;

function TProductUpdateController.companyId(AValue: string)
  : iProductUpdateController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TProductUpdateController.Create;
begin

end;

function TProductUpdateController.description(AValue: string)
  : iProductUpdateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TProductUpdateController.Destroy;
begin

  inherited;
end;

class function TProductUpdateController.New: iProductUpdateController;
begin
  Result := Self.Create;
end;

function TProductUpdateController.originPrice(AValue: string)
  : iProductUpdateController;
begin
  Result := Self;
  FOriginPrice := AValue;
end;

procedure TProductUpdateController.save;
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

function TProductUpdateController.selectedRecord(AValue: TTSTOPRODUCT)
  : iProductUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

function TProductUpdateController.status(AValue: Integer)
  : iProductUpdateController;
begin
  Result := Self;
  FStatus := AValue;
end;

function TProductUpdateController.unitMeasure(AValue: string)
  : iProductUpdateController;
begin
  Result := Self;
  FUnitMeasure := AValue;
end;

function TProductUpdateController.userId(AValue: string)
  : iProductUpdateController;
begin
  Result := Self;
  FUserId := AValue;
end;

end.
