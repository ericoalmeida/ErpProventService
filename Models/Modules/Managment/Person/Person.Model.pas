unit Person.Model;

interface

uses Person.Model.Interf, ormbr.container.objectset.interfaces,
   ormbr.Factory.interfaces, TMNGPERSON.Entity.Model;

type
   TPersonModel = class(TInterfacedObject, IPersonModel)
   private
      FConnection: IDBConnection;
      FEntity: TTMNGPERSON;
      FDAO: IContainerObjectSet<TTMNGPERSON>;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: IPersonModel;

      function Entity: TTMNGPERSON; overload;
      function Entity(AValue: TTMNGPERSON): IPersonModel; overload;

      function DAO: IContainerObjectSet<TTMNGPERSON>;
   end;

implementation

{ TPersonModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TPersonModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.
     currentConnection;
   FDAO := TContainerObjectSet<TTMNGPERSON>.Create(FConnection, 1);
end;

function TPersonModel.DAO: IContainerObjectSet<TTMNGPERSON>;
begin
   result := FDAO;
end;

destructor TPersonModel.Destroy;
begin

   inherited;
end;

function TPersonModel.Entity: TTMNGPERSON;
begin
   result := FEntity;
end;

function TPersonModel.Entity(AValue: TTMNGPERSON): IPersonModel;
begin
   result := Self;
   FEntity := AValue;
end;

class function TPersonModel.New: IPersonModel;
begin
   result := Self.Create;
end;

end.
