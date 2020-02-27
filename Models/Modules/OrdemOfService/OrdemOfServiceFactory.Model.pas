unit OrdemOfServiceFactory.Model;

interface

uses OrdemOfServiceFactory.Model.Interf, Service.Model.Interf;

type
  TOrdemOfServiceFactoryModel = class(TInterfacedObject,
    IOrdemOfServiceFactoryModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: IOrdemOfServiceFactoryModel;

    function serviceModel: IServiceModel;
  end;

implementation

{ TOrdemOfServiceFactoryModel }

uses Service.Model;

constructor TOrdemOfServiceFactoryModel.Create;
begin

end;

destructor TOrdemOfServiceFactoryModel.Destroy;
begin

  inherited;
end;

class function TOrdemOfServiceFactoryModel.New: IOrdemOfServiceFactoryModel;
begin
  Result := Self.Create;
end;

function TOrdemOfServiceFactoryModel.serviceModel: IServiceModel;
begin
  Result := TServiceModel.New;
end;

end.
