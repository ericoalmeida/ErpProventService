unit StockFactory.Controller.Interf;

interface

uses SinapiProduct.Controller.Interf, ImportSinapiProduct.Controller.interf;

type
  iStockFactoryController = interface
    ['{98AED9D0-B56D-42F3-93D0-42D9DA44A315}']
    function sinapiProductController: iSinapiProductController;
    function importSinapiProductController: iImportSinapiProductController;
  end;

implementation

end.
