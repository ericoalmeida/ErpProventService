unit State.Model;

interface

uses State.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TGERESTADO.Entity.Model;

type
  TStateModel = class(TInterfacedObject, IStateModel)
  private
    FConnection: IDBConnection;
    FEntity: TTGERESTADO;
    FDAO: IContainerObjectSet<TTGERESTADO>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: IStateModel;

    function Entity: TTGERESTADO; overload;
    function Entity(AValue: TTGERESTADO): IStateModel; overload;

    function DAO: IContainerObjectSet<TTGERESTADO>;
  end;

implementation

{ TStateModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TStateModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.currentConnection;
   FDao :=  TContainerObjectSet<TTGERESTADO>.Create(FConnection, 1);
end;

function TStateModel.DAO: IContainerObjectSet<TTGERESTADO>;
begin
  result := FDAO;
end;

destructor TStateModel.Destroy;
begin

  inherited;
end;

function TStateModel.Entity: TTGERESTADO;
begin
  Result := FEntity;
end;

function TStateModel.Entity(AValue: TTGERESTADO): IStateModel;
begin
  Result := Self;
  FEntity := AValue;
end;

class function TStateModel.New: IStateModel;
begin
  Result := Self.Create;
end;

end.
