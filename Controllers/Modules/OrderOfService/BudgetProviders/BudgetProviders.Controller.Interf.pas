unit BudgetProviders.Controller.Interf;

interface

uses BudgetProviders.Model.Interf, TORDBUDGETPROVIDERS.Entity.Model;

type
   IBudgetProvidersInsertController = interface;

   IBudgetProvidersController = interface
      function find(AValue: string): IBudgetProvidersController;
      function findById(AValue: string): IBudgetProvidersController;

      function insert: IBudgetProvidersInsertController;
      function cleanOldRecords(ACompanyId: string; ABudGetId: string): IBudgetProvidersController;

      function sequenceProvider: Integer;
      function budgetId: string;
      function providerId: string;
      function createdAt: string;
      function updatedAt: string;
   end;

   IBudgetProvidersInsertController = interface
      function budgetProvidersModel(AValue: IBudgetProvidersModel): IBudgetProvidersInsertController;

      function companyId(AValue: string): IBudgetProvidersInsertController;
      function budgetId(AValue: string): IBudgetProvidersInsertController;
      function providerId(AValue: string): IBudgetProvidersInsertController;
      function userId(AValue: string): IBudgetProvidersInsertController;
    
      procedure save;
   end;

implementation

end.
