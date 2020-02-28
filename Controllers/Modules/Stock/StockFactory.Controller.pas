unit StockFactory.Controller;

interface

uses StockFactory.Controller.Interf, Product.Controller.Interf;

type
  TStockFactoryController = class(TInterfacedObject, iStockFactoryController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStockFactoryController;

    function productController: iProductController;

  end;

implementation

{ TStockFactoryController }

uses Product.Controller;

constructor TStockFactoryController.Create;
begin

end;

destructor TStockFactoryController.Destroy;
begin

  inherited;
end;

class function TStockFactoryController.New: iStockFactoryController;
begin
  Result := Self.Create;
end;

function TStockFactoryController.productController: iProductController;
begin
  Result := TProductController.New;
end;

end.
