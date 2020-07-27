unit BudgetProducts.Controller.Interf;

interface

uses BudgetProducts.Model.Interf, TORDBUDGETPRODUCTS.Entity.Model;

type
   IBudgetProductsInsertController = interface;

   IBudgetProductsController = interface
      function find(AValue: string): IBudgetProductsController;
      function findById(AValue: string): IBudgetProductsController;

      function insert: IBudgetProductsInsertController;
      function cleanOldRecords(ACompanyId: string; ABudGetId: string): IBudgetProductsController;

      function sequenceProducts: Integer;
      function budgetId: string;
      function productId: string;
      function createdAt: string;
      function updatedAt: string;
   end;

   IBudgetProductsInsertController = interface
      function budgetProductsModel(AValue: IBudgetProductsModel): IBudgetProductsInsertController;

      function companyId(AValue: string): IBudgetProductsInsertController;
      function budgetId(AValue: string): IBudgetProductsInsertController;
      function productId(AValue: string): IBudgetProductsInsertController;
      function qtde(AValue: Double): IBudgetProductsInsertController;
      function userId(AValue: string): IBudgetProductsInsertController;
    
      procedure save;
   end;

implementation

end.
