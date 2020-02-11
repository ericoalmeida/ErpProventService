unit Facade.Controller;

interface

uses Facade.Controller.Interf, Connection.Controller.Interf;

type
  TFacadeController = class(TInterfacedObject, iFacadeController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iFacadeController;

    function ConnectionFactoryController: iConnectionController;

  end;

implementation

{ TFacadeController }

uses Connection.Controller;

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

class function TFacadeController.New: iFacadeController;
begin
  Result := Self.Create;
end;

end.
