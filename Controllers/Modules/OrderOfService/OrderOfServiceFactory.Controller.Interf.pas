unit OrderOfServiceFactory.Controller.Interf;

interface

uses Service.Controller.Interf, Operators.Controller.Interf,
  ServiceProvided.Controller.Interf, Budget.Controller.Interf;

type
  iOrderOfServiceFactoryController = interface
    ['{81D77627-307D-4E5D-8CF8-3ECD10FB9DF7}']
    function serviceController: iServiceController;
    function oepratorController: iOperatorController;
    function serviceProvidedController: iServiceProvidedController;
    function budgetController: iBudgetController;
  end;

implementation

end.
