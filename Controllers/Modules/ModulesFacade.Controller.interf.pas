unit ModulesFacade.Controller.interf;

interface

uses ManagmentFactory.Controller.interf, AssetsFactory.Controller.interf;

type
  iModulesFacadeController = interface
    ['{F622764B-C10D-4FE9-A8DC-BB136C8011FE}']
    function ManagmentFactoryController: iManagmentFactoryController;
    function AssetsFactoryController: iAssetsFactoryController;
  end;

implementation

end.
