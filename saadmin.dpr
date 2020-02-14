program saadmin;

uses
  Vcl.Forms,
  Main.View in 'Views\Main.View.pas' {FMainView},
  Base.View in 'Views\Base\Base.View.pas' {FBaseView},
  BaseList.View in 'Views\Base\BaseList.View.pas' {FBaseListView},
  BaseRegister.View in 'Views\Base\BaseRegister.View.pas' {FBaseRegisterView},
  BaseMessage.View in 'Views\Base\BaseMessage.View.pas' {FBaseMessageView},
  BaseSearch.View in 'Views\Base\BaseSearch.View.pas' {FBaseSearchView},
  BaseReport.View in 'Views\Base\BaseReport.View.pas' {FBaseReportView},
  MSG0001.View in 'Views\Messages\MSG0001.View.pas' {FMSG0001View},
  MSG0002.View in 'Views\Messages\MSG0002.View.pas' {FMSG0002View},
  MSG0003.View in 'Views\Messages\MSG0003.View.pas' {FMSG0003View},
  MSG0004.View in 'Views\Messages\MSG0004.View.pas' {FMSG0004View},
  Types.Controllers in 'Controllers\Types\Types.Controllers.pas',
  Base.View.interf in 'Views\Base\Base.View.interf.pas',
  MessagesFactory.View.Interf in 'Views\Messages\MessagesFactory.View.Interf.pas',
  Types.Views in 'Views\Types\Types.Views.pas',
  MessagesFactory.View in 'Views\Messages\MessagesFactory.View.pas',
  Facade.View.interf in 'Views\Facade.View.interf.pas',
  Facade.View in 'Views\Facade.View.pas',
  Connection.Model.Interf in 'Models\Connection\Connection.Model.Interf.pas',
  DataMFirebird.Model in 'Models\Connection\Firebird\DataMFirebird.Model.pas' {FDataMFirebird: TDataModule},
  ConnectionFactory.Model.Interf in 'Models\Connection\ConnectionFactory.Model.Interf.pas',
  ConnectionFactory.Model in 'Models\Connection\ConnectionFactory.Model.pas',
  ConnectionSettings.Model.interf in 'Models\Settings\Connection\ConnectionSettings.Model.interf.pas',
  ConnectionSettings.Model in 'Models\Settings\Connection\ConnectionSettings.Model.pas',
  SettingsFactory.Model.interf in 'Models\Settings\SettingsFactory.Model.interf.pas',
  SettingsFactory.Model in 'Models\Settings\SettingsFactory.Model.pas',
  Facade.Model.Interf in 'Models\Facade.Model.Interf.pas',
  Facade.Model in 'Models\Facade.Model.pas',
  Types.Models in 'Models\Types\Types.Models.pas',
  Connection.Controller.interf in 'Controllers\Connection\Connection.Controller.interf.pas',
  Connection.Controller in 'Controllers\Connection\Connection.Controller.pas',
  Facade.Controller.Interf in 'Controllers\Facade.Controller.Interf.pas',
  Facade.Controller in 'Controllers\Facade.Controller.pas',
  TGEREMPRESA.Entity.Model in 'Models\Modules\Managment\Company\Entity\TGEREMPRESA.Entity.Model.pas',
  TGERBAIRRO.Entity.Model in 'Models\Modules\Managment\Districts\Entity\TGERBAIRRO.Entity.Model.pas',
  Districts.Model.Interf in 'Models\Modules\Managment\Districts\Districts.Model.Interf.pas',
  Districts.Model in 'Models\Modules\Managment\Districts\Districts.Model.pas',
  ManagmentFactory.Model.Interf in 'Models\Modules\Managment\ManagmentFactory.Model.Interf.pas',
  ManagmentFactory.Model in 'Models\Modules\Managment\ManagmentFactory.Model.pas',
  ModulesFacade.Model.Interf in 'Models\Modules\ModulesFacade.Model.Interf.pas',
  ModulesFacade.Model in 'Models\Modules\ModulesFacade.Model.pas',
  District.Controller.Interf in 'Controllers\Modules\Managment\District\District.Controller.Interf.pas',
  District.Controller in 'Controllers\Modules\Managment\District\District.Controller.pas',
  DistrictInsert.Controller in 'Controllers\Modules\Managment\District\Operations\DistrictInsert.Controller.pas',
  ManagmentFactory.Controller.interf in 'Controllers\Modules\Managment\ManagmentFactory.Controller.interf.pas',
  ManagmentFactory.Controller in 'Controllers\Modules\Managment\ManagmentFactory.Controller.pas',
  ModulesFacade.Controller.interf in 'Controllers\Modules\ModulesFacade.Controller.interf.pas',
  ModulesFacade.Controller in 'Controllers\Modules\ModulesFacade.Controller.pas',
  MNG0001AView in 'Views\Modules\Managment\District\MNG0001AView.pas' {FMNG0001AView},
  ManagmentFactory.View.Interf in 'Views\Modules\Managment\ManagmentFactory.View.Interf.pas',
  ManagmentFactory.View in 'Views\Modules\Managment\ManagmentFactory.View.pas',
  ModulesFacade.View.Interf in 'Views\Modules\ModulesFacade.View.Interf.pas',
  ModulesFacade.View in 'Views\Modules\ModulesFacade.View.pas',
  MNG0001BView in 'Views\Modules\Managment\District\MNG0001BView.pas' {FMNG0001BView},
  DistrictUpdate.Controller in 'Controllers\Modules\Managment\District\Operations\DistrictUpdate.Controller.pas',
  DistrictDelete.Controller in 'Controllers\Modules\Managment\District\Operations\DistrictDelete.Controller.pas',
  DistrictDuplicate.Controller in 'Controllers\Modules\Managment\District\Operations\DistrictDuplicate.Controller.pas',
  TGERPAIS.Entity.Model in 'Models\Modules\Managment\Country\Entity\TGERPAIS.Entity.Model.pas',
  Country.Model.Interf in 'Models\Modules\Managment\Country\Country.Model.Interf.pas',
  Country.Model in 'Models\Modules\Managment\Country\Country.Model.pas',
  Country.Controller.Interf in 'Controllers\Modules\Managment\Country\Country.Controller.Interf.pas',
  Country.Controller in 'Controllers\Modules\Managment\Country\Country.Controller.pas',
  CountryInsert.Controller in 'Controllers\Modules\Managment\Country\Operations\CountryInsert.Controller.pas',
  MNG0002AView in 'Views\Modules\Managment\Country\MNG0002AView.pas' {FMNG0002AView},
  MNG0002BView in 'Views\Modules\Managment\Country\MNG0002BView.pas' {FMNG0002BView},
  MNG0003AView in 'Views\Modules\Managment\State\MNG0003AView.pas' {FMNG0003AView},
  CountryUpdate.Controller in 'Controllers\Modules\Managment\Country\Operations\CountryUpdate.Controller.pas',
  CountryDelete.Controller in 'Controllers\Modules\Managment\Country\Operations\CountryDelete.Controller.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainView, FMainView);
  Application.Run;
end.
