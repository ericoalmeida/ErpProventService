unit User.Model;

interface

uses User.Model.Interf, ormbr.container.objectset.interfaces,
   ormbr.Factory.interfaces, TMNGUSER.Entity.Model;

type
   TUserModel = class(TInterfacedObject, IUserModel)
   private
      FConnection: IDBConnection;
      FEntity: TTMNGUSER;
      FDAO: IContainerObjectSet<TTMNGUSER>;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: IUserModel;

      function Entity: TTMNGUSER; overload;
      function Entity(AValue: TTMNGUSER): IUserModel; overload;

      function DAO: IContainerObjectSet<TTMNGUSER>;
   end;

implementation

{ TUserModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TUserModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.
     currentConnection;
   FDAO := TContainerObjectSet<TTMNGUSER>.Create(FConnection, 1);
end;

function TUserModel.DAO: IContainerObjectSet<TTMNGUSER>;
begin
   result := FDAO;
end;

destructor TUserModel.Destroy;
begin

   inherited;
end;

function TUserModel.Entity: TTMNGUSER;
begin
   result := FEntity;
end;

function TUserModel.Entity(AValue: TTMNGUSER): IUserModel;
begin
   result := Self;
   FEntity := AValue;
end;

class function TUserModel.New: IUserModel;
begin
   result := Self.Create;
end;

end.
