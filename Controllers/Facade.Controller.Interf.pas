unit Facade.Controller.Interf;

interface

uses Connection.Controller.Interf, ModulesFacade.Controller.interf, Utils.Controller.Interf;

type
  iFacadeController = interface
    ['{3C659773-C3AF-4DB4-854D-BB2859CFCB87}']
    function utils: iUtilsController;

    function ConnectionFactoryController: iConnectionController;

    function ModulesFacadeController: iModulesFacadeController;
  end;

implementation

end.
