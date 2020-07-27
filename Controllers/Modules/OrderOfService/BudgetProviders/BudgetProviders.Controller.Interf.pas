unit BudgetProviders.Controller.Interf;

interface

uses BudgetProviders.Model.Interf, TORDBUDGETPROVIDERS.Entity.Model;

type
   IBudgetProvidersInsertController = interface;
   IBudgetProvidersDuplicateController = interface;

   IBudgetProvidersController = interface
      function find(AValue: string): IBudgetProvidersController;
      function findById(AValue: string): IBudgetProvidersController;

      function insert: IBudgetProvidersInsertController;
      function cleanOldRecords(ACompanyId: string; ABudGetId: string): IBudgetProvidersController;

      function sequenceProvider: Integer;
      function budgetId: string;
      function providerOwnId: Integer;
      function providerId: string;
      function providerName: string;
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

   IBudgetProvidersDuplicateController = interface
      function budgetProvidersModel(AValue: IBudgetProvidersModel): IBudgetProvidersDuplicateController;

      function companyId(AValue: string): IBudgetProvidersDuplicateController;
      function budgetId(AValue: string): IBudgetProvidersDuplicateController;
      function providerId(AValue: string): IBudgetProvidersDuplicateController;
      function userId(AValue: string): IBudgetProvidersDuplicateController;

      procedure save;
   end;

implementation

end.
