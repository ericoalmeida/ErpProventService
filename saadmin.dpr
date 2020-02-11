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
  Facade.Controller in 'Controllers\Facade.Controller.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainView, FMainView);
  Application.Run;
end.
