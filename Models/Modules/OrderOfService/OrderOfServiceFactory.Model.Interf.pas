unit OrderOfServiceFactory.Model.Interf;

interface

uses Service.Model.Interf, Operators.Model.Interf, ServiceProvided.Model.Interf,
   Budget.Model.Interf, BudgetProviders.Model.Interf,
  BudgetProducts.Model.Interf, BudgetAnalyzes.Model.Interf;

type
   IOrderOfServiceFactoryModel = interface
      ['{6AB8DA61-8903-4033-AC7B-D10CD4E4C940}']
      function serviceModel: IServiceModel;
      function operatorModel: IOperatorModel;
      function serviceProvidedModel: IServiceProvidedModel;
      function budgetModel: IBudgetModel;
      function budgetProvidersModel: IBudgetProvidersModel;  
      function budgetProductsModel: IBudgetProductsModel; 
      function budgetAnalyzesModel: IBudgetAnalyzesModel;                  
   end;

implementation

end.
