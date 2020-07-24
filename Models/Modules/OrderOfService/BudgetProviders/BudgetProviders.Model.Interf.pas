unit BudgetProviders.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TORDBUDGETPROVIDERS.Entity.Model;

type
   IBudgetProvidersModel = interface
      function Entity: TTORDBUDGETPROVIDERS; overload;
      function Entity(AValue: TTORDBUDGETPROVIDERS)
        : IBudgetProvidersModel; overload;
      function DAO: IContainerObjectSet<TTORDBUDGETPROVIDERS>;
   end;

implementation

end.
