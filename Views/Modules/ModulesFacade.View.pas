unit ModulesFacade.View;

interface

uses ModulesFacade.View.Interf, ManagmentFactory.View.Interf,
  AssetsFactory.View.Interf;

type
  TModulesFacadeView = class(TInterfacedObject, iModulesFacadeView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iModulesFacadeView;

    function assetsFactoryView: iAssetsFactoryView;
    function ManagmentFactoryView: iManagmentFactoryView;
  end;

implementation

{ TModulesFacadeView }

uses ManagmentFactory.View, AssetsFactory.View;

function TModulesFacadeView.assetsFactoryView: iAssetsFactoryView;
begin
  Result := TAssetsFactoryView.New;
end;

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
