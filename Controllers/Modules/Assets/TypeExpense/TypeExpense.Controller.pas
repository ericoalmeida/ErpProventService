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

      function companyId: string;
      function code: string;
      function typeExpenseId: string;
      function description: string;
      function status: Integer;
      function userId: string;
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

function TTypeExpenseController.companyId: string;
begin
   Result := FRecordFound.companyId;
end;

constructor TTypeExpenseController.Create;
begin
   FTypeExpenseModel := TFacadeModel.New.moduleFacade.assetsFactoryModel.
     TypeExpenseModel;
end;

function TTypeExpenseController.createdAt: string;
begin
   Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TTypeExpenseController.delete: iTypeExpenseDeleteController;
begin
   Result := TTypeExpenseDeleteController.New.TypeExpenseModel
     (FTypeExpenseModel).selectedRecord(FRecordFound);
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
   Result := TTypeExpenseDuplicateController.New.TypeExpenseModel
     (FTypeExpenseModel);
end;

function TTypeExpenseController.insert: iTypeExpenseInsertController;
begin
   Result := TTypeExpenseInsertController.New.TypeExpenseModel
     (FTypeExpenseModel);
end;

class function TTypeExpenseController.New: iTypeExpenseController;
begin
   Result := Self.Create;
end;

function TTypeExpenseController.status: Integer;
begin
   Result := FRecordFound.status;
end;

function TTypeExpenseController.find(AValue: string): iTypeExpenseController;
begin
   Result := Self;

   FRecordFound := FTypeExpenseModel.DAO.FindWhere
     (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TTypeExpenseController.update: iTypeExpenseUpdateController;
begin
   Result := TTypeExpenseUpdateController.New.TypeExpenseModel
     (FTypeExpenseModel).selectedRecord(FRecordFound);
end;

function TTypeExpenseController.updatedAt: string;
begin
   Result := DateTimeToStr(FRecordFound.updatedAt);
end;

function TTypeExpenseController.userId: string;
begin
   Result := FRecordFound.TMNGUSER.userId.ToString;
end;

end.
