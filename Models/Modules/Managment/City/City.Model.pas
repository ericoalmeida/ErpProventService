unit City.Model;

interface

uses City.Model.Interf, ormbr.container.objectset.interfaces,
   ormbr.Factory.interfaces, TMNGCITY.Entity.Model;

type
   TCityModel = class(TInterfacedObject, iCityModel)
   private
      FConnection: IDBConnection;
      FEntity: TTMNGCITY;
      FDAO: IContainerObjectSet<TTMNGCITY>;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: iCityModel;

      function Entity: TTMNGCITY; overload;
      function Entity(AValue: TTMNGCITY): iCityModel; overload;

      function DAO: IContainerObjectSet<TTMNGCITY>;
   end;

implementation

{ TCityModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TCityModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.
     currentConnection;
   FDAO := TContainerObjectSet<TTMNGCITY>.Create(FConnection, 1);
end;

function TCityModel.DAO: IContainerObjectSet<TTMNGCITY>;
begin
   result := FDAO;
end;

destructor TCityModel.Destroy;
begin

   inherited;
end;

function TCityModel.Entity: TTMNGCITY;
begin
   result := FEntity;
end;

function TCityModel.Entity(AValue: TTMNGCITY): iCityModel;
begin
   result := Self;
   FEntity := AValue;
end;

class function TCityModel.New: iCityModel;
begin
   result := Self.Create;
end;

end.
