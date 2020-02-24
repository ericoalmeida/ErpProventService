unit TypeExpenseDuplicate.Controller;

interface

uses TypeExpense.Controller.Interf, TypeExpense.Model.Interf,
  TASSTYPEEXPENSE.Entity.Model, System.SysUtils;

type
  TTypeExpenseDuplicateController = class(TInterfacedObject,
    iTypeExpenseDuplicateController)
  private
    FTypeExpenseModel: iTypeExpenseModel;

    FDescription: string;

    function getTypeExpenseId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iTypeExpenseDuplicateController;

    function typeExpenseModel(AValue: iTypeExpenseModel)
      : iTypeExpenseDuplicateController;

    function description(AValue: string): iTypeExpenseDuplicateController;

    procedure save;
  end;

implementation

{ TTypeExpenseDuplicateController }

constructor TTypeExpenseDuplicateController.Create;
begin

end;

function TTypeExpenseDuplicateController.description(
  AValue: string): iTypeExpenseDuplicateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TTypeExpenseDuplicateController.Destroy;
begin

  inherited;
end;

function TTypeExpenseDuplicateController.typeExpenseModel
  (AValue: iTypeExpenseModel): iTypeExpenseDuplicateController;
begin
  Result := Self;
  FTypeExpenseModel := AValue;
end;

class function TTypeExpenseDuplicateController.New
  : iTypeExpenseDuplicateController;
begin
  Result := Self.Create;
end;

function TTypeExpenseDuplicateController.getTypeExpenseId: Integer;
begin
  if FTypeExpenseModel.DAO.Find.Count <> 0 then
  begin
    Result := FTypeExpenseModel.DAO.FindWhere('', 'TYPEEXPENSEID desc')
      .Last.TYPEEXPENSEID + 1;
  end
  else
  begin
    Result := 1;
  end;
end;

procedure TTypeExpenseDuplicateController.save;
begin
  FTypeExpenseModel.Entity(TTASSTYPEEXPENSE.Create);

  FTypeExpenseModel.Entity.TYPEEXPENSEID := getTypeExpenseId;

  FTypeExpenseModel.Entity.DESCRIPTION  := FDescription;
  FTypeExpenseModel.Entity.CREATEDAT    := Now;
  FTypeExpenseModel.Entity.UPDATEDAT    := Now;

  FTypeExpenseModel.DAO.Insert(FTypeExpenseModel.Entity);
end;

end.
