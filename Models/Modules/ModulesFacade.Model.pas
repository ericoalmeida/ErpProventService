unit ModulesFacade.Model;

interface

uses ModulesFacade.Model.Interf, ManagmentFactory.Model.Interf,
  AssetsFactory.Model.Interf;

type
  TModulesFacadeModel = class(TInterfacedObject, iModulesFacadeModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iModulesFacadeModel;

    function managmentFactoryModel: iManagmentFactoryModel;
    function assetsFactoryModel: iAssetsFactoryModel;
  end;

implementation

{ TModulesFacadeModel }

uses ManagmentFactory.Model, AssetsFactory.Model;

function TModulesFacadeModel.assetsFactoryModel: iAssetsFactoryModel;
begin
  Result := TAssetsFactoryModel.New;
end;

constructor TModulesFacadeModel.Create;
begin

end;

destructor TModulesFacadeModel.Destroy;
begin

  inherited;
end;

function TModulesFacadeModel.managmentFactoryModel: iManagmentFactoryModel;
begin
  Result := TManagmentFactoryModel.New;
end;

class function TModulesFacadeModel.New: iModulesFacadeModel;
begin
  Result := Self.Create;
end;

end.
