unit BudgetProducts.Model;

interface

uses BudgetProducts.Model.Interf, ormbr.container.objectset.interfaces,
   ormbr.Factory.interfaces, TORDBUDGETPRODUCTS.Entity.Model;

type
   TBudgetProductsModel = class(TInterfacedObject, IBudgetProductsModel)
   private
      FConnection: IDBConnection;
      FEntity: TTORDBUDGETPRODUCTS;
      FDAO: IContainerObjectSet<TTORDBUDGETPRODUCTS>;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: IBudgetProductsModel;

      function Entity: TTORDBUDGETPRODUCTS; overload;
      function Entity(AValue: TTORDBUDGETPRODUCTS)
        : IBudgetProductsModel; overload;

      function DAO: IContainerObjectSet<TTORDBUDGETPRODUCTS>;
   end;

implementation

{ TBudgetProductsModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TBudgetProductsModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.
     currentConnection;
   FDAO := TContainerObjectSet<TTORDBUDGETPRODUCTS>.Create(FConnection, 1);
end;

function TBudgetProductsModel.DAO: IContainerObjectSet<TTORDBUDGETPRODUCTS>;
begin
   result := FDAO;
end;

destructor TBudgetProductsModel.Destroy;
begin

   inherited;
end;

function TBudgetProductsModel.Entity: TTORDBUDGETPRODUCTS;
begin
   result := FEntity;
end;

function TBudgetProductsModel.Entity(AValue: TTORDBUDGETPRODUCTS)
  : IBudgetProductsModel;
begin
   result := Self;
   FEntity := AValue;
end;

class function TBudgetProductsModel.New: IBudgetProductsModel;
begin
   result := Self.Create;
end;

end.
