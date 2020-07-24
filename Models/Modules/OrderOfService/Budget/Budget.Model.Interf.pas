unit Budget.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TORDBUDGET.Entity.Model;

type
   IBudgetModel = interface
      function Entity: TTORDBUDGET; overload;
      function Entity(AValue: TTORDBUDGET): IBudgetModel; overload;
      function DAO: IContainerObjectSet<TTORDBUDGET>;
   end;

implementation

end.
