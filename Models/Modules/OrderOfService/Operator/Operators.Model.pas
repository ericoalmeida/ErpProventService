unit Operators.Model;

interface

uses Operators.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TORDOPERATOR.Entity.Model;

type
  TOperatorModel = class(TInterfacedObject, IOperatorModel)
  private
    FConnection: IDBConnection;
    FEntity: TTORDOPERATOR;
    FDAO: IContainerObjectSet<TTORDOPERATOR>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: IOperatorModel;

    function Entity: TTORDOPERATOR; overload;
    function Entity(AValue: TTORDOPERATOR): IOperatorModel; overload;

    function DAO: IContainerObjectSet<TTORDOPERATOR>;
  end;

implementation

{ TOperatorModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TOperatorModel.Create;
begin
  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;
  FDAO := TContainerObjectSet<TTORDOPERATOR>.Create(FConnection, 1);
end;

function TOperatorModel.DAO: IContainerObjectSet<TTORDOPERATOR>;
begin
  result := FDAO;
end;

destructor TOperatorModel.Destroy;
begin

  inherited;
end;

function TOperatorModel.Entity: TTORDOPERATOR;
begin
  result := FEntity;
end;

function TOperatorModel.Entity(AValue: TTORDOPERATOR): IOperatorModel;
begin
  result := Self;
  FEntity := AValue;
end;

class function TOperatorModel.New: IOperatorModel;
begin
  result := Self.Create;
end;

end.
