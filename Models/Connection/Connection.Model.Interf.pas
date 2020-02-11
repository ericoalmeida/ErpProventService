unit Connection.Model.Interf;

interface

uses
  ormbr.Factory.Interfaces, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  Data.DB, FireDAC.Comp.Client;

type
  iConnectionModel = interface
    ['{CAB5648D-6CE0-4A92-B767-1F54F6626399}']
    function dbConnection: IDBConnection;
    function fdConnection: TFDConnection;
  end;

implementation

end.
