unit ModulesFacade.Model.Interf;

interface

uses ManagmentFactory.Model.Interf, AssetsFactory.Model.Interf,
   OrderOfServiceFactory.Model.Interf, StockFactory.Model.Interf;

type
   iModulesFacadeModel = interface
      ['{B8A6EF5A-47FC-45B6-9402-4041AEC59555}']
      function managmentFactoryModel: iManagmentFactoryModel;
      function assetsFactoryModel: iAssetsFactoryModel;
      function orderOfServiceFactoryModel: IOrderOfServiceFactoryModel;
      function stockFactoryModel: iStockFactoryModel;
   end;

implementation

end.
