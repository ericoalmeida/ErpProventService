unit StockFactory.Controller.Interf;

interface

uses Product.Controller.Interf;

type
  iStockFactoryController = interface
    ['{98AED9D0-B56D-42F3-93D0-42D9DA44A315}']
    function productController: iProductController;
  end;

implementation

end.
