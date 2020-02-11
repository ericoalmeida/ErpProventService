unit Connection.Controller;

interface

uses Connection.Controller.interf, ormbr.Factory.Interfaces;

type
  TConnectionController = class(TInterfacedObject, iConnectionController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iConnectionController;

    function currentConnection: IDBConnection;
  end;

implementation

{ TConnectionController }

uses Facade.Model, Types.Models;

function TConnectionController.currentConnection: IDBConnection;
begin
 Result := TFacadeModel.New
             .ConnectionFactoryModel
             .connectionWithDatabase(
               TTypesConnection(
                TFacadeModel.New
                 .SettingsFactoryModel
                 .connection
                 .typeDatabase
                 )
            ).dbConnection;
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
