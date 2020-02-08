program saadmin;

uses
  Vcl.Forms,
  Main.View in 'Views\Main.View.pas' {FMainView},
  Base.View in 'Views\Base\Base.View.pas' {FBaseView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainView, FMainView);
  Application.Run;
end.
