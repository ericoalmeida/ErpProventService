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
  Facade.View in 'Views\Facade.View.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainView, FMainView);
  Application.Run;
end.
