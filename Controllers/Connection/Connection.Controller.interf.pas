unit Connection.Controller.interf;

interface

uses
   ormbr.Factory.Interfaces, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
   FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
   FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
   Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
   FireDAC.DApt.Intf, FireDAC.DApt,
   FireDAC.Comp.DataSet;

type
   iConnectionController = interface
      ['{C5DAFD0D-74A4-45C0-A0A8-887A5754A25E}']
      function currentConnection: IDBConnection;
      function currentFdConnection: TFDConnection;
   end;

implementation

end.
