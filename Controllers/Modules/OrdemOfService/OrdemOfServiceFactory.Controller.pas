unit OrdemOfServiceFactory.Controller;

interface

uses OrdemOfServiceFactory.Controller.Interf, Service.Controller.Interf;

type
  TOrdemOfServiceFactoryController = class(TInterfacedObject,
    iOrdemOfServiceFactoryController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iOrdemOfServiceFactoryController;

    function serviceController: iServiceController;
  end;

implementation

{ TOrdemOfServiceFactoryController }

uses Service.Controller;

constructor TOrdemOfServiceFactoryController.Create;
begin

end;

destructor TOrdemOfServiceFactoryController.Destroy;
begin

  inherited;
end;

class function TOrdemOfServiceFactoryController.New
  : iOrdemOfServiceFactoryController;
begin
  Result := Self.Create;
end;

function TOrdemOfServiceFactoryController.serviceController: iServiceController;
begin
  Result := TServiceController.New;
end;

end.
