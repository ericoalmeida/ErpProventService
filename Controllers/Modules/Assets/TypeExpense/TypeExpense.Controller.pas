unit TypeExpense.Controller;

interface

uses TypeExpense.Controller.Interf, TypeExpense.Model.Interf,
  TASSTYPEEXPENSE.Entity.Model,
  System.SysUtils;

type
  TTypeExpenseController = class(TInterfacedObject, iTypeExpenseController)
  private
    FTypeExpenseModel: iTypeExpenseModel;
    FRecordFound: TTASSTYPEEXPENSE;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iTypeExpenseController;

    function find(AValue: string): iTypeExpenseController;

    function insert: iTypeExpenseInsertController;
    function update: iTypeExpenseUpdateController;
    function delete: iTypeExpenseDeleteController;
    function duplicate: iTypeExpenseDuplicateController;

    function code: string;
    function typeExpenseId: string;
    function description: string;
    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TTypeExpenseController }

uses Facade.Model, TypeExpenseInsert.Controller, TypeExpenseUpdate.Controller,
  TypeExpenseDelete.Controller, TypeExpenseDuplicate.Controller;

function TTypeExpenseController.code: string;
begin
  Result := FRecordFound.code;
end;

function TTypeExpenseController.typeExpenseId: string;
begin
  Result := FRecordFound.typeExpenseId.ToString;
end;

constructor TTypeExpenseController.Create;
begin
  FTypeExpenseModel := TFacadeModel.New.moduleFacade.assetsFactoryModel.
    TypeExpense;
end;

function TTypeExpenseController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TTypeExpenseController.delete: iTypeExpenseDeleteController;
begin
  Result := TTypeExpenseDeleteController.New.typeExpenseModel(FTypeExpenseModel)
    .selectedRecord(FRecordFound);
end;

function TTypeExpenseController.description: string;
begin
  Result := FRecordFound.description;
end;

destructor TTypeExpenseController.Destroy;
begin

  inherited;
end;

function TTypeExpenseController.duplicate: iTypeExpenseDuplicateController;
begin
  Result := TTypeExpenseDuplicateController.New.typeExpenseModel
    (FTypeExpenseModel);
end;

function TTypeExpenseController.insert: iTypeExpenseInsertController;
begin
  Result := TTypeExpenseInsertController.New.typeExpenseModel
    (FTypeExpenseModel);
end;

class function TTypeExpenseController.New: iTypeExpenseController;
begin
  Result := Self.Create;
end;

function TTypeExpenseController.find(AValue: string): iTypeExpenseController;
begin
  Result := Self;

  FRecordFound := FTypeExpenseModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TTypeExpenseController.update: iTypeExpenseUpdateController;
begin
  Result := TTypeExpenseUpdateController.New.typeExpenseModel(FTypeExpenseModel)
    .selectedRecord(FRecordFound);
end;

function TTypeExpenseController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.updatedAt);
end;

end.
