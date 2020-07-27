unit BudgetProducts.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TORDBUDGETPRODUCTS.Entity.Model;

type
   IBudgetProductsModel = interface
      function Entity: TTORDBUDGETPRODUCTS; overload;
      function Entity(AValue: TTORDBUDGETPRODUCTS)
        : IBudgetProductsModel; overload;
      function DAO: IContainerObjectSet<TTORDBUDGETPRODUCTS>;
   end;

implementation

end.
