unit BudgetProviders.Model;

interface

uses BudgetProviders.Model.Interf, ormbr.container.objectset.interfaces,
   ormbr.Factory.interfaces, TORDBUDGETPROVIDERS.Entity.Model;

type
   TBudgetProvidersModel = class(TInterfacedObject, IBudgetProvidersModel)
   private
      FConnection: IDBConnection;
      FEntity: TTORDBUDGETPROVIDERS;
      FDAO: IContainerObjectSet<TTORDBUDGETPROVIDERS>;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: IBudgetProvidersModel;

      function Entity: TTORDBUDGETPROVIDERS; overload;
      function Entity(AValue: TTORDBUDGETPROVIDERS)
        : IBudgetProvidersModel; overload;

      function DAO: IContainerObjectSet<TTORDBUDGETPROVIDERS>;
   end;

implementation

{ TBudgetProvidersModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TBudgetProvidersModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.
     currentConnection;
   FDAO := TContainerObjectSet<TTORDBUDGETPROVIDERS>.Create(FConnection, 1);
end;

function TBudgetProvidersModel.DAO: IContainerObjectSet<TTORDBUDGETPROVIDERS>;
begin
   result := FDAO;
end;

destructor TBudgetProvidersModel.Destroy;
begin

   inherited;
end;

function TBudgetProvidersModel.Entity: TTORDBUDGETPROVIDERS;
begin
   result := FEntity;
end;

function TBudgetProvidersModel.Entity(AValue: TTORDBUDGETPROVIDERS)
  : IBudgetProvidersModel;
begin
   result := Self;
   FEntity := AValue;
end;

class function TBudgetProvidersModel.New: IBudgetProvidersModel;
begin
   result := Self.Create;
end;

end.
