unit OrderOfServiceFactory.Controller;

interface

uses OrderOfServiceFactory.Controller.Interf, Service.Controller.Interf,
   Operators.Controller.Interf, ServiceProvided.Controller.Interf,
   Budget.Controller.Interf, BudgetProviders.Controller.Interf,
  BudgetProducts.Controller.Interf;

type
   TOrderOfServiceFactoryController = class(TInterfacedObject,
     iOrderOfServiceFactoryController)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iOrderOfServiceFactoryController;

      function serviceController: iServiceController;
      function oepratorController: iOperatorController;
      function serviceProvidedController: iServiceProvidedController;
      function budgetController: iBudgetController;
      function budgetProvidersController: IBudgetProvidersController;
      function budgetProductsController: IBudgetProductsController;                        
   end;

implementation

{ TOrdemOfServiceFactoryController }

uses Service.Controller, Operators.Controller, ServiceProvided.Controller,
   Budget.Controller, BudgetProviders.Controller, BudgetProducts.Controller;

function TOrderOfServiceFactoryController.budgetController: iBudgetController;
begin
   Result := TBudgetController.New;
end;

function TOrderOfServiceFactoryController.budgetProductsController: IBudgetProductsController;
begin
   Result := TBudgetProductsController.New;
end;

function TOrderOfServiceFactoryController.budgetProvidersController: IBudgetProvidersController;
begin
  Result := TBudgetProvidersController.New;
end;

constructor TOrderOfServiceFactoryController.Create;
begin

end;

destructor TOrderOfServiceFactoryController.Destroy;
begin

   inherited;
end;

class function TOrderOfServiceFactoryController.New
  : iOrderOfServiceFactoryController;
begin
   Result := Self.Create;
end;

function TOrderOfServiceFactoryController.oepratorController
  : iOperatorController;
begin
   Result := TOperatorController.New;
end;

function TOrderOfServiceFactoryController.serviceController: iServiceController;
begin
   Result := TServiceController.New;
end;

function TOrderOfServiceFactoryController.serviceProvidedController
  : iServiceProvidedController;
begin
   Result := TServiceProvidedController.New;
end;

end.
