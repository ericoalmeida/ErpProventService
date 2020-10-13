unit BudgetAnalyzes.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TORDBUDGETANALYZES.Entity.Model;

type
   IBudgetAnalyzesModel = interface
      function Entity: TTORDBUDGETANALYZES; overload;
      function Entity(AValue: TTORDBUDGETANALYZES)
        : IBudgetAnalyzesModel; overload;
      function DAO: IContainerObjectSet<TTORDBUDGETANALYZES>;
   end;

implementation

end.
