unit TypeExpenseDuplicate.Controller;

interface

uses TypeExpense.Controller.Interf, TypeExpense.Model.Interf,
  TASSTYPEEXPENSE.Entity.Model,
  System.SysUtils;

type
  TTypeExpenseDuplicateController = class(TInterfacedObject,
    iTypeExpenseDuplicateController)
  private
    FTypeExpenseModel: iTypeExpenseModel;

    FCompanyId: string;
    FDescription: string;
    FStatus: Integer;
    FUserId: string;

    function getTypeExpenseId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iTypeExpenseDuplicateController;

    function typeExpenseModel(AValue: iTypeExpenseModel)
      : iTypeExpenseDuplicateController;

    function companyId(AValue: string): iTypeExpenseDuplicateController;
    function description(AValue: string): iTypeExpenseDuplicateController;
    function status(AValue: Integer): iTypeExpenseDuplicateController;
    function userId(AValue: string): iTypeExpenseDuplicateController;

    procedure save;
  end;

implementation

{ TTypeExpenseDuplicateController }

function TTypeExpenseDuplicateController.companyId(AValue: string): iTypeExpenseDuplicateController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TTypeExpenseDuplicateController.Create;
begin

end;

function TTypeExpenseDuplicateController.description(AValue: string)
  : iTypeExpenseDuplicateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TTypeExpenseDuplicateController.Destroy;
begin

  inherited;
end;

class function TTypeExpenseDuplicateController.New: iTypeExpenseDuplicateController;
begin
  Result := Self.Create;
end;

function TTypeExpenseDuplicateController.getTypeExpenseId: Integer;
begin
  if FTypeExpenseModel.DAO.Find.Count <> 0 then
  begin
    Result := FTypeExpenseModel.DAO.FindWhere(Format('COMPANYID = %s',
      [QuotedStr(FCompanyId)]), 'TYPEEXPENSEID desc').Last.TYPEEXPENSEID + 1;
  end
  else
  begin
    Result := 1;
  end;
end;

procedure TTypeExpenseDuplicateController.save;
begin
  FTypeExpenseModel.Entity(TTASSTYPEEXPENSE.Create);

  FTypeExpenseModel.Entity.COMPANYID     := FCompanyId;
  FTypeExpenseModel.Entity.TYPEEXPENSEID := getTypeExpenseId;
  FTypeExpenseModel.Entity.DESCRIPTION   := FDescription;
  FTypeExpenseModel.Entity.STATUS        := FStatus;
  FTypeExpenseModel.Entity.USERID        := FUserId;
  FTypeExpenseModel.Entity.CREATEDAT     := Now;
  FTypeExpenseModel.Entity.UPDATEDAT     := Now;

  FTypeExpenseModel.DAO.Insert(FTypeExpenseModel.Entity);
end;

function TTypeExpenseDuplicateController.status(AValue: Integer): iTypeExpenseDuplicateController;
begin
  Result := Self;
  FStatus := AValue;
end;

function TTypeExpenseDuplicateController.typeExpenseModel
  (AValue: iTypeExpenseModel): iTypeExpenseDuplicateController;
begin
  Result := Self;
  FTypeExpenseModel := AValue;
end;

function TTypeExpenseDuplicateController.userId(AValue: string): iTypeExpenseDuplicateController;
begin
  Result := Self;
  FUserId := AValue;
end;

end.
