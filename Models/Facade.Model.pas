unit Facade.Model;

interface

uses Facade.Model.interf, SettingsFactory.Model.interf,
  ConnectionFactory.Model.interf, ModulesFacade.Model.interf;

type
  TFacadeModel = class(TInterfacedObject, iFacadeModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iFacadeModel;

    function ConnectionFactoryModel: iConnectionFactoryModel;
    function SettingsFactoryModel: iSettingsFactoryModel;

    function moduleFacade: iModulesFacadeModel;
  end;

implementation

{ TFacadeModel }

uses SettingsFactory.Model, ConnectionFactory.Model, ModulesFacade.Model;

function TFacadeModel.ConnectionFactoryModel: iConnectionFactoryModel;
begin
  Result := TConnectionFactoryModel.New;
end;

constructor TFacadeModel.Create;
begin

end;

destructor TFacadeModel.Destroy;
begin

  inherited;
end;

function TFacadeModel.moduleFacade: iModulesFacadeModel;
begin
  Result := TModulesFacadeModel.New;
end;

class function TFacadeModel.New: iFacadeModel;
begin
  Result := Self.Create;
end;

function TFacadeModel.SettingsFactoryModel: iSettingsFactoryModel;
begin
  Result := TSettingsFactoryModel.New;
end;

end.
