unit StockFactory.Model;

interface

uses StockFactory.Model.Interf, Product.Model.Interf;

type
  TStockFactoryModel = class(TInterfacedObject, iStockFactoryModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStockFactoryModel;

    function productModel: IProductModel;
  end;

implementation

{ TStockFactoryModel }

uses Product.Model;

constructor TStockFactoryModel.Create;
begin

end;

destructor TStockFactoryModel.Destroy;
begin

  inherited;
end;

class function TStockFactoryModel.New: iStockFactoryModel;
begin
  Result := Self.Create;
end;

function TStockFactoryModel.productModel: IProductModel;
begin
  Result := TProductModel.New;
end;

end.
