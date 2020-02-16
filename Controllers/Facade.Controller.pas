unit Facade.Controller;

interface

uses Facade.Controller.Interf, Connection.Controller.Interf,
  ModulesFacade.Controller.Interf, Utils.Controller.Interf;

type
  TFacadeController = class(TInterfacedObject, iFacadeController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iFacadeController;

    function utils: iUtilsController;

    function ConnectionFactoryController: iConnectionController;

    function ModulesFacadeController: iModulesFacadeController;
  end;

implementation

{ TFacadeController }

uses Connection.Controller, ModulesFacade.Controller, Utils.Controller;

function TFacadeController.ConnectionFactoryController: iConnectionController;
begin
  Result := TConnectionController.New;
end;

constructor TFacadeController.Create;
begin

end;

destructor TFacadeController.Destroy;
begin

  inherited;
end;

function TFacadeController.ModulesFacadeController: iModulesFacadeController;
begin
  Result := TModulesFacadeController.New;
end;

class function TFacadeController.New: iFacadeController;
begin
  Result := Self.Create;
end;

function TFacadeController.utils: iUtilsController;
begin
 result := TUtilsController.New;
end;

end.
