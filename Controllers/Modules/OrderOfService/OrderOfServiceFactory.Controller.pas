unit OrderOfServiceFactory.Controller;

interface

uses OrderOfServiceFactory.Controller.Interf, Service.Controller.Interf;

type
  TOrderOfServiceFactoryController = class(TInterfacedObject,
    iOrderOfServiceFactoryController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iOrderOfServiceFactoryController;

    function serviceController: iServiceController;
  end;

implementation

{ TOrdemOfServiceFactoryController }

uses Service.Controller;

constructor TOrderOfServiceFactoryController.Create;
begin

end;

destructor TOrderOfServiceFactoryController.Destroy;
begin

  inherited;
end;

class function TOrderOfServiceFactoryController.New
  : iOrderOfServiceFactoryController;
begin
  Result := Self.Create;
end;

function TOrderOfServiceFactoryController.serviceController: iServiceController;
begin
  Result := TServiceController.New;
end;

end.
