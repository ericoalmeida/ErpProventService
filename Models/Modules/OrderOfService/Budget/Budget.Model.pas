unit Budget.Model;

interface

uses Budget.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TORDBUDGET.Entity.Model;

type
  TBudgetModel = class(TInterfacedObject, IBudgetModel)
  private
    FConnection: IDBConnection;
    FEntity: TTORDBUDGET;
    FDAO: IContainerObjectSet<TTORDBUDGET>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: IBudgetModel;

    function Entity: TTORDBUDGET; overload;
    function Entity(AValue: TTORDBUDGET): IBudgetModel; overload;

    function DAO: IContainerObjectSet<TTORDBUDGET>;
  end;

implementation

{ TBudgetModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TBudgetModel.Create;
begin
  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;
  FDAO := TContainerObjectSet<TTORDBUDGET>.Create(FConnection, 1);
end;

function TBudgetModel.DAO: IContainerObjectSet<TTORDBUDGET>;
begin
  result := FDAO;
end;

destructor TBudgetModel.Destroy;
begin

  inherited;
end;

function TBudgetModel.Entity: TTORDBUDGET;
begin
  result := FEntity;
end;

function TBudgetModel.Entity(AValue: TTORDBUDGET): IBudgetModel;
begin
  result := Self;
  FEntity := AValue;
end;

class function TBudgetModel.New: IBudgetModel;
begin
  result := Self.Create;
end;

end.
