unit ModulesFacade.View;

interface

uses ModulesFacade.View.Interf, ManagmentFactory.View.Interf;

type
  TModulesFacadeView = class(TInterfacedObject, iModulesFacadeView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iModulesFacadeView;

    function ManagmentFactoryView: iManagmentFactoryView;
  end;

implementation

{ TModulesFacadeView }

uses ManagmentFactory.View;

constructor TModulesFacadeView.Create;
begin

end;

destructor TModulesFacadeView.Destroy;
begin

  inherited;
end;

function TModulesFacadeView.ManagmentFactoryView: iManagmentFactoryView;
begin
 Result := TManagmentFactoryView.New;
end;

class function TModulesFacadeView.New: iModulesFacadeView;
begin
  Result := Self.Create;
end;

end.
