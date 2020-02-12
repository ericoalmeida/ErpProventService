unit ModulesFacade.Model;

interface

uses ModulesFacade.Model.Interf, ManagmentFactory.Model.Interf;

type
  TModulesFacadeModel = class(TInterfacedObject, iModulesFacadeModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iModulesFacadeModel;

    function managmentFactoryModel: iManagmentFactoryModel;
  end;

implementation

{ TModulesFacadeModel }

uses ManagmentFactory.Model;

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
