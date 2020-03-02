unit ImportSinapiProductOperation.Controller;

interface

uses ImportSinapiProduct.Controller.interf, SinapiProduct.Model.interf,
  TSTOSINAPIPRODUCT.Entity.Model, System.SysUtils;

type
  TImportSinapiProductOperationController = class(TInterfacedObject,
    iImportSinapiProductOperationController)
  private
    FImportSinapiProductController: iImportSinapiProductController;
    FSinapiProductModel: iSinapiProductModel;
    FCurrentProduct: TTSTOSINAPIPRODUCT;
    FProductFound: Boolean;

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

    class function New: iImportSinapiProductOperationController;

    function importSinapiProductController
      (AValue: iImportSinapiProductController)
      : iImportSinapiProductOperationController;

    function sinapiProductModel(AValue: iSinapiProductModel)
      : iImportSinapiProductOperationController;

    function currentProduct(AValue: TTSTOSINAPIPRODUCT)
      : iImportSinapiProductOperationController;

    function companyId(AValue: string): iImportSinapiProductOperationController;
    function codeSinapi(AValue: string)
      : iImportSinapiProductOperationController;
    function description(AValue: string)
      : iImportSinapiProductOperationController;
    function unitMeasure(AValue: string)
      : iImportSinapiProductOperationController;
    function originPrice(AValue: string)
      : iImportSinapiProductOperationController;
    function averagePrice(AValue: Currency)
      : iImportSinapiProductOperationController;
    function averagePriceSinapi(AValue: Currency)
      : iImportSinapiProductOperationController;
    function status(AValue: Integer): iImportSinapiProductOperationController;
    function userId(AValue: string): iImportSinapiProductOperationController;

    procedure createSiapiProduct;
    procedure updateSiapiProduct;

    procedure save;
  end;

implementation

{ TImportSinapiProductOperationController }

function TImportSinapiProductOperationController.averagePrice(AValue: Currency)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FAveragePrice := AValue;
end;

function TImportSinapiProductOperationController.averagePriceSinapi
  (AValue: Currency): iImportSinapiProductOperationController;
begin
  Result := Self;
  FAveragePriceSinapi := AValue;
end;

function TImportSinapiProductOperationController.codeSinapi(AValue: string)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FCodeSinapi := AValue;
end;

function TImportSinapiProductOperationController.companyId(AValue: string)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TImportSinapiProductOperationController.Create;
begin

end;

procedure TImportSinapiProductOperationController.createSiapiProduct;
begin
  FSinapiProductModel.Entity(TTSTOSINAPIPRODUCT.Create);

  FSinapiProductModel.Entity.COMPANYID           := FCompanyId;
  FSinapiProductModel.Entity.PRODUCTID           := getProductId;
  FSinapiProductModel.Entity.CODE_SINAPI         := FCodeSinapi;
  FSinapiProductModel.Entity.DESCRIPTION         := FDescription;
  FSinapiProductModel.Entity.UNITMEASURE         := FUnitMeasure;
  FSinapiProductModel.Entity.ORIGINPRICE         := FOriginPrice;
  FSinapiProductModel.Entity.AVERAGEPRICE        := FAveragePrice;
  FSinapiProductModel.Entity.AVERAGEPRICE_SINAPI := FAveragePriceSinapi;
  FSinapiProductModel.Entity.STATUS              := FStatus;
  FSinapiProductModel.Entity.USERID              := FUserId;
  FSinapiProductModel.Entity.CREATEDAT           := Now;
  FSinapiProductModel.Entity.UPDATEDAT           := Now;

  FSinapiProductModel.DAO.Insert(FSinapiProductModel.Entity);
end;

function TImportSinapiProductOperationController.currentProduct(
  AValue: TTSTOSINAPIPRODUCT): iImportSinapiProductOperationController;
begin
  Result := Self;

  FCurrentProduct := AValue;
  FProductFound := not(AValue = nil);
end;

function TImportSinapiProductOperationController.description(AValue: string)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TImportSinapiProductOperationController.Destroy;
begin

  inherited;
end;

function TImportSinapiProductOperationController.getProductId: Integer;
begin
  if FSinapiProductModel.DAO.Find.Count <> 0 then
  begin
    Result := FSinapiProductModel.DAO.FindWhere(Format('COMPANYID = %s',
      [QuotedStr(FCompanyId)]), 'PRODUCTID desc').Last.PRODUCTID + 1;
  end
  else
  begin
    Result := 1;
  end;
end;

function TImportSinapiProductOperationController.importSinapiProductController
  (AValue: iImportSinapiProductController)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FImportSinapiProductController := AValue;
end;

class function TImportSinapiProductOperationController.New
  : iImportSinapiProductOperationController;
begin
  Result := Self.Create;
end;

function TImportSinapiProductOperationController.originPrice(AValue: string)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FOriginPrice := AValue;
end;

procedure TImportSinapiProductOperationController.save;
begin
 if FProductFound then
  updateSiapiProduct
  else
  createSiapiProduct;
end;

function TImportSinapiProductOperationController.sinapiProductModel
  (AValue: iSinapiProductModel): iImportSinapiProductOperationController;
begin
  Result := Self;
  FSinapiProductModel := AValue;
end;

function TImportSinapiProductOperationController.status(AValue: Integer)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FStatus := AValue;
end;

function TImportSinapiProductOperationController.unitMeasure(AValue: string)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FUnitMeasure := AValue;
end;

procedure TImportSinapiProductOperationController.updateSiapiProduct;
begin
  FSinapiProductModel.DAO.Modify(FCurrentProduct);

  FCurrentProduct.companyId := FCompanyId;
  FCurrentProduct.CODE_SINAPI := FCodeSinapi;
  FCurrentProduct.description := FDescription;
  FCurrentProduct.unitMeasure := FUnitMeasure;
  FCurrentProduct.originPrice := FOriginPrice;
  FCurrentProduct.averagePrice := FAveragePrice;
  FCurrentProduct.AVERAGEPRICE_SINAPI := FAveragePriceSinapi;
  FCurrentProduct.status := FStatus;
  FCurrentProduct.userId := FUserId;
  FCurrentProduct.UPDATEDAT := Now;

  FSinapiProductModel.DAO.Update(FCurrentProduct);
end;

function TImportSinapiProductOperationController.userId(AValue: string)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FUserId := AValue;
end;

end.
