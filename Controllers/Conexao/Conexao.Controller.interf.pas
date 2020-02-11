unit Conexao.Controller.interf;

interface

uses
  ormbr.Factory.Interfaces;

type
  iConnectionController = interface
    ['{C5DAFD0D-74A4-45C0-A0A8-887A5754A25E}']
    function currentConnection: IDBConnection;
  end;

implementation

end.
