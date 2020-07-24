unit Company.Model;

interface

uses Company.Model.Interf, ormbr.container.objectset.interfaces,
   ormbr.Factory.interfaces, TMNGCOMPANY.Entity.Model;

type
   TCompanyModel = class(TInterfacedObject, iCompanyModel)
   private
      FConnection: IDBConnection;
      FEntity: TTMNGCOMPANY;
      FDAO: IContainerObjectSet<TTMNGCOMPANY>;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: iCompanyModel;

      function Entity: TTMNGCOMPANY; overload;
      function Entity(AValue: TTMNGCOMPANY): iCompanyModel; overload;

      function DAO: IContainerObjectSet<TTMNGCOMPANY>;
   end;

implementation

{ TCompanyModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TCompanyModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.
     currentConnection;
   FDAO := TContainerObjectSet<TTMNGCOMPANY>.Create(FConnection, 1);
end;

function TCompanyModel.DAO: IContainerObjectSet<TTMNGCOMPANY>;
begin
   result := FDAO;
end;

destructor TCompanyModel.Destroy;
begin

   inherited;
end;

function TCompanyModel.Entity: TTMNGCOMPANY;
begin
   result := FEntity;
end;

function TCompanyModel.Entity(AValue: TTMNGCOMPANY): iCompanyModel;
begin
   result := Self;
   FEntity := AValue;
end;

class function TCompanyModel.New: iCompanyModel;
begin
   result := Self.Create;
end;

end.
