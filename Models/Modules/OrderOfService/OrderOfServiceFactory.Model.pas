unit OrderOfServiceFactory.Model;

interface

uses OrderOfServiceFactory.Model.Interf, Service.Model.Interf;

type
  TOrderOfServiceFactoryModel = class(TInterfacedObject,
    IOrderOfServiceFactoryModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: IOrderOfServiceFactoryModel;

    function serviceModel: IServiceModel;
  end;

implementation

{ TOrderOfServiceFactoryModel }

uses Service.Model;

constructor TOrderOfServiceFactoryModel.Create;
begin

end;

destructor TOrderOfServiceFactoryModel.Destroy;
begin

  inherited;
end;

class function TOrderOfServiceFactoryModel.New: IOrderOfServiceFactoryModel;
begin
  Result := Self.Create;
end;

function TOrderOfServiceFactoryModel.serviceModel: IServiceModel;
begin
  Result := TServiceModel.New;
end;

end.
