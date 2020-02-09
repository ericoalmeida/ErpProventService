program saadmin;

uses
  Vcl.Forms,
  Main.View in 'Views\Main.View.pas' {FMainView},
  Base.View in 'Views\Base\Base.View.pas' {FBaseView},
  BaseListagem.View in 'Views\Base\BaseListagem.View.pas' {FBaseListagemView},
  BaseCadastro.View in 'Views\Base\BaseCadastro.View.pas' {FBaseCadastroView},
  BaseMensagem.View in 'Views\Base\BaseMensagem.View.pas' {FBaseMensagemView},
  BasePesquisa.View in 'Views\Base\BasePesquisa.View.pas' {FBasePesquisaView},
  BaseRelatorio.View in 'Views\Base\BaseRelatorio.View.pas' {FBaseRelatorioView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainView, FMainView);
  Application.Run;
end.
