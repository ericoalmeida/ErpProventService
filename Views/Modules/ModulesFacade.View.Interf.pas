unit ModulesFacade.View.Interf;

interface

uses Types.Views, ManagmentFactory.View.Interf, AssetsFactory.View.Interf,
  OrdemOfServiceFactory.View.Interf;

type
  iModulesFacadeView = interface
    ['{2FF997A2-3030-421B-883B-A335339D823D}']
    function assetsFactoryView: iAssetsFactoryView;
    function ManagmentFactoryView: iManagmentFactoryView;
    function ordemOfService: iOrdemOfServiceFactoryView;
  end;

implementation

end.
