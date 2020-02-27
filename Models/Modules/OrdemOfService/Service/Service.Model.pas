unit Service.Model;

interface

uses Service.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TORDSERVICE.Entity.Model;

type
  TServiceModel = class(TInterfacedObject, iServiceModel)
  private
    FConnection: IDBConnection;
    FEntity: TTORDSERVICE;
    FDAO: IContainerObjectSet<TTORDSERVICE>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: iServiceModel;

    function Entity: TTORDSERVICE; overload;
    function Entity(AValue: TTORDSERVICE): iServiceModel; overload;

    function DAO: IContainerObjectSet<TTORDSERVICE>;
  end;

implementation

{ TServiceModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TServiceModel.Create;
begin
  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;
  FDAO := TContainerObjectSet<TTORDSERVICE>.Create(FConnection, 1);
end;

function TServiceModel.DAO: IContainerObjectSet<TTORDSERVICE>;
begin
  result := FDAO;
end;

destructor TServiceModel.Destroy;
begin

  inherited;
end;

function TServiceModel.Entity: TTORDSERVICE;
begin
  result := FEntity;
end;

function TServiceModel.Entity(AValue: TTORDSERVICE): iServiceModel;
begin
  result := Self;
  FEntity := AValue;
end;

class function TServiceModel.New: iServiceModel;
begin
  result := Self.Create;
end;

end.
