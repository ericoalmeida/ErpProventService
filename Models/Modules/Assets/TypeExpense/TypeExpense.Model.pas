unit TypeExpense.Model;

interface

uses TypeExpense.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TASSTYPEEXPENSE.Entity.Model;

type
  TTypeExpenseModel = class(TInterfacedObject, iTypeExpenseModel)
  private
    FConnection: IDBConnection;
    FEntity: TTASSTYPEEXPENSE;
    FDAO: IContainerObjectSet<TTASSTYPEEXPENSE>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: iTypeExpenseModel;

    function Entity: TTASSTYPEEXPENSE; overload;
    function Entity(AValue: TTASSTYPEEXPENSE): iTypeExpenseModel; overload;

    function DAO: IContainerObjectSet<TTASSTYPEEXPENSE>;
  end;

implementation

{ TTypeExpenseModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TTypeExpenseModel.Create;
begin
  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;
  FDAO := TContainerObjectSet<TTASSTYPEEXPENSE>.Create(FConnection, 1);
end;

function TTypeExpenseModel.DAO: IContainerObjectSet<TTASSTYPEEXPENSE>;
begin
  result := FDAO;
end;

destructor TTypeExpenseModel.Destroy;
begin

  inherited;
end;

function TTypeExpenseModel.Entity: TTASSTYPEEXPENSE;
begin
  result := FEntity;
end;

function TTypeExpenseModel.Entity(AValue: TTASSTYPEEXPENSE): iTypeExpenseModel;
begin
  result := Self;
  FEntity := AValue;
end;

class function TTypeExpenseModel.New: iTypeExpenseModel;
begin
  result := Self.Create;
end;

end.
