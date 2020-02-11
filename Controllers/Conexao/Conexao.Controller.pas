unit Conexao.Controller;

interface

uses Conexao.Controller.interf, ormbr.Factory.Interfaces;

type
  TConexaoController = class(TInterfacedObject, IConexaoController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: IConexaoController;

    function conexaoAtual: IDBConnection;
  end;

implementation

{ TConexaoController }

uses FacadeModel, Conexao.Model.Interf;

function TConexaoController.conexaoAtual: IDBConnection;
begin
 Result := TFacadeModel.New
             .conexaoFactoryModel
             .conexaoComBancoDeDados(
               TTipoConexao(
                TFacadeModel.New
                 .configuracoesFactoryModel
                 .conexao
                 .tipoBanco
                 )
            ).Conexao;
end;

constructor TConexaoController.Create;
begin

end;

destructor TConexaoController.Destroy;
begin

  inherited;
end;

class function TConexaoController.New: IConexaoController;
begin
  Result := Self.Create;
end;

end.
