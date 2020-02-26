unit Vehicle.Model;

interface

uses Vehicle.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TASSVEHICLE.Entity.Model;

type
  TVehicleModel = class(TInterfacedObject, IVehicleModel)
  private
    FConnection: IDBConnection;
    FEntity: TTASSVEHICLE;
    FDAO: IContainerObjectSet<TTASSVEHICLE>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: IVehicleModel;

    function Entity: TTASSVEHICLE; overload;
    function Entity(AValue: TTASSVEHICLE): IVehicleModel; overload;

    function DAO: IContainerObjectSet<TTASSVEHICLE>;
  end;

implementation

{ TVehicleModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TVehicleModel.Create;
begin
  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;
  FDAO := TContainerObjectSet<TTASSVEHICLE>.Create(FConnection, 1);
end;

function TVehicleModel.DAO: IContainerObjectSet<TTASSVEHICLE>;
begin
  result := FDAO;
end;

destructor TVehicleModel.Destroy;
begin

  inherited;
end;

function TVehicleModel.Entity: TTASSVEHICLE;
begin
  result := FEntity;
end;

function TVehicleModel.Entity(AValue: TTASSVEHICLE): IVehicleModel;
begin
  result := Self;
  FEntity := AValue;
end;

class function TVehicleModel.New: IVehicleModel;
begin
  result := Self.Create;
end;

end.
