unit StockFactory.Controller;

interface

uses StockFactory.Controller.Interf, SinapiProduct.Controller.Interf,
   ImportSinapiProduct.Controller.Interf;

type
   TStockFactoryController = class(TInterfacedObject, iStockFactoryController)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iStockFactoryController;

      function sinapiProductController: iSinapiProductController;
      function importSinapiProductController: iImportSinapiProductController;
   end;

implementation

{ TStockFactoryController }

uses SinapiProduct.Controller, ImportSinapiProduct.Controller;

constructor TStockFactoryController.Create;
begin

end;

destructor TStockFactoryController.Destroy;
begin

   inherited;
end;

function TStockFactoryController.importSinapiProductController
  : iImportSinapiProductController;
begin
   Result := TImportSinapiProductController.New;
end;

class function TStockFactoryController.New: iStockFactoryController;
begin
   Result := Self.Create;
end;

function TStockFactoryController.sinapiProductController
  : iSinapiProductController;
begin
   Result := TSinapiProductController.New;
end;

end.
