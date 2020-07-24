unit Budget.Controller;

interface

uses Budget.Controller.Interf, Budget.Model.Interf,
   System.SysUtils, TORDBUDGET.Entity.Model;

type
   TBudgetController = class(TInterfacedObject, iBudgetController)
   private
      FBudgetModel: IBudgetModel;
      FRecordFound: TTORDBUDGET;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iBudgetController;

      function find(AValue: string): iBudgetController;
      function findById(AValue: string): iBudgetController;

      function insert: iBudgetInsertController;
      function update: iBudgetUpdateController;
      function delete: iBudgetDeleteController;
      function duplicate: iBudgetDuplicateController;

      function code: string;
      function budgetId: string;
      function description: string;
      function emissionDate: TDateTime;
      function createdAt: string;
      function updatedAt: string;
   end;

implementation

{ TBudgetController }

uses Facade.Model, OperatorsInsert.Controller, OperatorsUpdate.Controller,
   OperatorsDelete.Controller, OperatorsDuplicate.Controller,
   BudgetInsert.Controller, BudgetUpdate.Controller, BudgetDelete.Controller,
   BudgetDuplicate.Controller;

function TBudgetController.budgetId: string;
begin
   Result := FRecordFound.budgetId.ToString;
end;

function TBudgetController.code: string;
begin
   Result := FRecordFound.code;
end;

constructor TBudgetController.Create;
begin
   FBudgetModel := TFacadeModel.New.moduleFacade.orderOfServiceFactoryModel.
     budgetModel;
end;

function TBudgetController.createdAt: string;
begin
   Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TBudgetController.delete: iBudgetDeleteController;
begin
   Result := TBudgetDeleteController.New.budgetModel(FBudgetModel)
     .selectedRecord(FRecordFound);
end;

function TBudgetController.description: string;
begin
   Result := FRecordFound.description;
end;

destructor TBudgetController.Destroy;
begin

   inherited;
end;

function TBudgetController.duplicate: iBudgetDuplicateController;
begin
   Result := TBudgetDuplicateController.New.budgetModel(FBudgetModel);
end;

function TBudgetController.emissionDate: TDateTime;
begin
   Result := FRecordFound.emissionDate;
end;

function TBudgetController.insert: iBudgetInsertController;
begin
   Result := TBudgetInsertController.New.budgetModel(FBudgetModel);
end;

class function TBudgetController.New: iBudgetController;
begin
   Result := Self.Create;
end;

function TBudgetController.find(AValue: string): iBudgetController;
begin
   Result := Self;

   FRecordFound := FBudgetModel.DAO.FindWhere
     (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TBudgetController.findById(AValue: string): iBudgetController;
begin
   Result := Self;

   if AValue = EmptyStr then
      Exit;

   FRecordFound := FBudgetModel.DAO.FindWhere(Format('OPERATORID = %s',
     [QuotedStr(AValue)])).Items[0];
end;

function TBudgetController.update: iBudgetUpdateController;
begin
   Result := TBudgetUpdateController.New.budgetModel(FBudgetModel)
     .selectedRecord(FRecordFound);
end;

function TBudgetController.updatedAt: string;
begin
   Result := DateTimeToStr(FRecordFound.updatedAt);
end;

end.
