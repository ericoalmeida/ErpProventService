unit ModulesFacade.Controller;

interface

uses ModulesFacade.Controller.interf, ManagmentFactory.Controller.interf,
  AssetsFactory.Controller.interf;

type
  TModulesFacadeController = class(TInterfacedObject, iModulesFacadeController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iModulesFacadeController;

    function ManagmentFactoryController: iManagmentFactoryController;
    function AssetsFactoryController: iAssetsFactoryController;
  end;

implementation

{ TModulesFacadeController }

uses ManagmentFactory.Controller, AssetsFactory.Controller;

function TModulesFacadeController.AssetsFactoryController
  : iAssetsFactoryController;
begin
  Result := TAssetsFactoryController.New
end;

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
