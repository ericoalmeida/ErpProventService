unit Product.Controller;

interface

uses Product.Controller.Interf, Product.Model.Interf,
  System.SysUtils, TSTOPRODUCT.Entity.Model;

type
  TProductController = class(TInterfacedObject, iProductController)
  private
    FProductModel: IProductModel;
    FRecordFound: TTSTOPRODUCT;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iProductController;

    function find(AValue: string): iProductController;

    function insert: iProductInsertController;
    function update: iProductUpdateController;
    function delete: iProductDeleteController;
    function duplicate: iProductDuplicateController;

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

{ TProductController }

uses Facade.Model, ProductInsert.Controller, ProductUpdate.Controller,
  ProductDelete.Controller, ProductDuplicate.Controller;

function TProductController.averagePrice: Currency;
begin
  Result := FRecordFound.AVERAGEPRICE;
end;

function TProductController.averagePriceSinapi: Currency;
begin
  Result := FRecordFound.AVERAGEPRICE_SINAPI;
end;

function TProductController.code: string;
begin
  Result := FRecordFound.CODE;
end;

function TProductController.productId: string;
begin
  Result := FRecordFound.PRODUCTID.ToString;
end;

function TProductController.codeSinapi: string;
begin
  Result := FRecordFound.CODE_SINAPI;
end;

function TProductController.status: Integer;
begin
  Result := FRecordFound.STATUS;
end;

constructor TProductController.Create;
begin
  FProductModel := TFacadeModel.New.moduleFacade.stockFactoryModel.productModel;
end;

function TProductController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.CREATEDAT);
end;

function TProductController.delete: iProductDeleteController;
begin
  Result := TProductDeleteController.New.productModel(FProductModel)
    .selectedRecord(FRecordFound);
end;

function TProductController.description: string;
begin
  Result := FRecordFound.DESCRIPTION;
end;

destructor TProductController.Destroy;
begin

  inherited;
end;

function TProductController.duplicate: iProductDuplicateController;
begin
  Result := TProductDuplicateController.New.productModel(FProductModel);
end;

function TProductController.insert: iProductInsertController;
begin
  Result := TProductInsertController.New.productModel(FProductModel);
end;

class function TProductController.New: iProductController;
begin
  Result := Self.Create;
end;

function TProductController.originPrice: string;
begin
  Result := FRecordFound.ORIGINPRICE;
end;

function TProductController.find(AValue: string): iProductController;
begin
  Result := Self;

  FRecordFound := FProductModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TProductController.unitMeasure: string;
begin
  Result := FRecordFound.UNITMEASURE;
end;

function TProductController.update: iProductUpdateController;
begin
  Result := TProductUpdateController.New.productModel(FProductModel)
    .selectedRecord(FRecordFound);
end;

function TProductController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.UPDATEDAT);
end;

function TProductController.userId: string;
begin
  Result := FRecordFound.USERID;
end;

end.
