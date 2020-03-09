unit ModulesFacade.View;

interface

uses ModulesFacade.View.Interf, ManagmentFactory.View.Interf,
  AssetsFactory.View.Interf, OrderOfServiceFactory.View.Interf,
  StockFactory.View.Interf, PayFactory.View.Interf, ReceiveFactory.View.Interf;

type
  TModulesFacadeView = class(TInterfacedObject, iModulesFacadeView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iModulesFacadeView;

    function assetsFactoryView: iAssetsFactoryView;
    function ManagmentFactoryView: iManagmentFactoryView;
    function OrderOfServiceFactory: iOrderOfServiceFactoryView;
    function StockFactory: iStockFactoryView;
    function PayFactory: iPayFactoryView;
    function ReceiveFactory: iReceiveFactoryView;
  end;

implementation

{ TModulesFacadeView }

uses ManagmentFactory.View, AssetsFactory.View, OrderOfServiceFactory.View,
  StockFactory.View, PayFactory.View, ReceiveFactory.View;

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

function TModulesFacadeView.OrderOfServiceFactory: iOrderOfServiceFactoryView;
begin
  Result := TOrderOfServiceFactoryView.New;
end;

function TModulesFacadeView.PayFactory: iPayFactoryView;
begin
  Result := TPayFactoryView.New;
end;

function TModulesFacadeView.ReceiveFactory: iReceiveFactoryView;
begin
  Result := TReceiveFactoryView.New;
end;

function TModulesFacadeView.StockFactory: iStockFactoryView;
begin
  Result := TStockFactoryView.New
end;

end.
