unit ModulesFacade.Controller;

interface

uses ModulesFacade.Controller.interf, ManagmentFactory.Controller.interf,
  AssetsFactory.Controller.interf, OrderOfServiceFactory.Controller.interf,
  StockFactory.Controller.interf;

type
  TModulesFacadeController = class(TInterfacedObject, iModulesFacadeController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iModulesFacadeController;

    function ManagmentFactoryController: iManagmentFactoryController;
    function AssetsFactoryController: iAssetsFactoryController;
    function OrderOfServiceFactoryController: iOrderOfServiceFactoryController;
    function StockFactoryController: iStockFactoryController;
  end;

implementation

{ TModulesFacadeController }

uses ManagmentFactory.Controller, AssetsFactory.Controller,
  OrderOfServiceFactory.Controller, StockFactory.Controller;

function TModulesFacadeController.AssetsFactoryController
  : iAssetsFactoryController;
begin
  Result := TAssetsFactoryController.New
end;

constructor TModulesFacadeController.Create;
begin

end;

destructor TModulesFacadeController.Destroy;
begin

  inherited;
end;

function TModulesFacadeController.ManagmentFactoryController
  : iManagmentFactoryController;
begin
  Result := TManagmentFactoryController.New;
end;

class function TModulesFacadeController.New: iModulesFacadeController;
begin
  Result := Self.Create;
end;

function TModulesFacadeController.OrderOfServiceFactoryController
  : iOrderOfServiceFactoryController;
begin
  Result := TOrderOfServiceFactoryController.New;
end;

function TModulesFacadeController.StockFactoryController
  : iStockFactoryController;
begin
  Result := TStockFactoryController.New;
end;

end.
