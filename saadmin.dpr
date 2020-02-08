program saadmin;

uses
  Vcl.Forms,
  Main.View in 'Views\Main.View.pas' {FMainView},
  Base.View in 'Views\Base\Base.View.pas' {FBaseView},
  BaseListagem.View in 'Views\Base\BaseListagem.View.pas' {FBaseListagemView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainView, FMainView);
  Application.CreateForm(TFBaseListagemView, FBaseListagemView);
  Application.Run;
end.
