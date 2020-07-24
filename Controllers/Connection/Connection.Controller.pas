unit Connection.Controller;

interface

uses Connection.Controller.interf, ormbr.Factory.Interfaces, FireDAC.Stan.Intf,
   FireDAC.Stan.Option,
   FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
   FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
   FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
   Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
   FireDAC.DApt.Intf, FireDAC.DApt,
   FireDAC.Comp.DataSet;

type
   TConnectionController = class(TInterfacedObject, iConnectionController)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iConnectionController;

      function currentConnection: IDBConnection;
      function currentFdConnection: TFDConnection;
   end;

implementation

{ TConnectionController }

uses Facade.Model, Types.Models;

function TConnectionController.currentConnection: IDBConnection;
begin
   Result := TFacadeModel.New.ConnectionFactoryModel.connectionWithDatabase
     (TTypesConnection(TFacadeModel.New.SettingsFactoryModel.Connection.
     typeDatabase)).dbConnection;
end;

function TConnectionController.currentFdConnection: TFDConnection;
begin
   Result := TFacadeModel.New.ConnectionFactoryModel.connectionWithDatabase
     (TTypesConnection(TFacadeModel.New.SettingsFactoryModel.Connection.
     typeDatabase)).fdConnection;
end;

constructor TConnectionController.Create;
begin

end;

destructor TConnectionController.Destroy;
begin

   inherited;
end;

class function TConnectionController.New: iConnectionController;
begin
   Result := Self.Create;
end;

end.
