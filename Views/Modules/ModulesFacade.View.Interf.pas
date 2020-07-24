unit ModulesFacade.View.Interf;

interface

uses Types.Views, ManagmentFactory.View.Interf, AssetsFactory.View.Interf,
   OrderOfServiceFactory.View.Interf, StockFactory.View.Interf,
   PayFactory.View.Interf,
   ReceiveFactory.View.Interf;

type
   iModulesFacadeView = interface
      ['{2FF997A2-3030-421B-883B-A335339D823D}']
      function assetsFactoryView: iAssetsFactoryView;
      function ManagmentFactoryView: iManagmentFactoryView;
      function OrderOfServiceFactory: iOrderOfServiceFactoryView;
      function StockFactory: iStockFactoryView;
      function PayFactory: iPayFactoryView;
      function ReceiveFactory: iReceiveFactoryView;
   end;

implementation

end.
