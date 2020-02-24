unit TypeExpenseInsert.Controller;

interface

uses TypeExpense.Controller.Interf, TypeExpense.Model.Interf,
  TASSTYPEEXPENSE.Entity.Model,
  System.SysUtils;

type
  TTypeExpenseInsertController = class(TInterfacedObject,
    iTypeExpenseInsertController)
  private
    FTypeExpenseModel: iTypeExpenseModel;
    FDescription: string;

    function getTypeExpenseId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iTypeExpenseInsertController;

    function typeExpenseModel(AValue: iTypeExpenseModel)
      : iTypeExpenseInsertController;

    function description(AValue: string): iTypeExpenseInsertController;

    procedure save;
  end;

implementation

{ TTypeExpenseInsertController }

constructor TTypeExpenseInsertController.Create;
begin

end;

function TTypeExpenseInsertController.description(AValue: string)
  : iTypeExpenseInsertController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TTypeExpenseInsertController.Destroy;
begin

  inherited;
end;

class function TTypeExpenseInsertController.New: iTypeExpenseInsertController;
begin
  Result := Self.Create;
end;

function TTypeExpenseInsertController.getTypeExpenseId: Integer;
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

procedure TTypeExpenseInsertController.save;
begin
  FTypeExpenseModel.Entity(TTASSTYPEEXPENSE.Create);

  FTypeExpenseModel.Entity.TYPEEXPENSEID := getTypeExpenseId;
  FTypeExpenseModel.Entity.DESCRIPTION   := FDescription;
  FTypeExpenseModel.Entity.CREATEDAT     := Now;
  FTypeExpenseModel.Entity.UPDATEDAT     := Now;

  FTypeExpenseModel.DAO.Insert(FTypeExpenseModel.Entity);
end;

function TTypeExpenseInsertController.typeExpenseModel
  (AValue: iTypeExpenseModel): iTypeExpenseInsertController;
begin
  Result := Self;
  FTypeExpenseModel := AValue;
end;

end.
