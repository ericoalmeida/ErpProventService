unit ModulesFacade.Controller;

interface

uses ModulesFacade.Controller.interf, ManagmentFactory.Controller.interf;

type
  TModulesFacadeController = class(TInterfacedObject, iModulesFacadeController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iModulesFacadeController;

    function ManagmentFactoryController: iManagmentFactoryController;
  end;

implementation

{ TModulesFacadeController }

uses ManagmentFactory.Controller;

constructor TModulesFacadeController.Create;
begin

end;

destructor TModulesFacadeController.Destroy;
begin

  inherited;
end;

function TModulesFacadeController.ManagmentFactoryController
  : iManagmentFactoryController;
begin
  Result := TManagmentFactoryController.New;
end;

class function TModulesFacadeController.New: iModulesFacadeController;
begin
  Result := Self.Create;
end;

end.
