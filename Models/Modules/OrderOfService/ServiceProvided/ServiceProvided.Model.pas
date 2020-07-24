unit ServiceProvided.Model;

interface

uses Districts.Model.Interf, ormbr.container.objectset.interfaces,
   ormbr.Factory.interfaces, ServiceProvided.Model.Interf,
   TORDSERVICESPROVIDED.Entity.Model;

type
   TServiceProvidedModel = class(TInterfacedObject, IServiceProvidedModel)
   private
      FConnection: IDBConnection;
      FEntity: TTORDSERVICESPROVIDED;
      FDAO: IContainerObjectSet<TTORDSERVICESPROVIDED>;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: IServiceProvidedModel;

      function Entity: TTORDSERVICESPROVIDED; overload;
      function Entity(AValue: TTORDSERVICESPROVIDED)
        : IServiceProvidedModel; overload;

      function DAO: IContainerObjectSet<TTORDSERVICESPROVIDED>;
   end;

implementation

{ TServiceProvidedModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TServiceProvidedModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.
     currentConnection;
   FDAO := TContainerObjectSet<TTORDSERVICESPROVIDED>.Create(FConnection, 1);
end;

function TServiceProvidedModel.DAO: IContainerObjectSet<TTORDSERVICESPROVIDED>;
begin
   result := FDAO;
end;

destructor TServiceProvidedModel.Destroy;
begin

   inherited;
end;

function TServiceProvidedModel.Entity: TTORDSERVICESPROVIDED;
begin
   result := FEntity;
end;

function TServiceProvidedModel.Entity(AValue: TTORDSERVICESPROVIDED)
  : IServiceProvidedModel;
begin
   result := Self;
   FEntity := AValue;
end;

class function TServiceProvidedModel.New: IServiceProvidedModel;
begin
   result := Self.Create;
end;

end.
