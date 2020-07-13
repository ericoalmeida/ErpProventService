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
    function operatorId: string;
    function name: string;
    function status: Integer;
    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TBudgetController }

uses Facade.Model, OperatorsInsert.Controller, OperatorsUpdate.Controller,
  OperatorsDelete.Controller, OperatorsDuplicate.Controller;

function TBudgetController.code: string;
begin
  Result := FRecordFound.code;
end;

function TBudgetController.operatorId: string;
begin
  Result := FRecordFound.operatorId.ToString;
end;

function TBudgetController.status: Integer;
begin
  Result := FRecordFound.STATUS
end;

constructor TBudgetController.Create;
begin
  FBudgetModel := TFacadeModel.New.moduleFacade.orderOfServiceFactoryModel.
    operatorModel;
end;

function TBudgetController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TBudgetController.delete: iBudgetDeleteController;
begin
  Result := TOperatorDeleteController.New.operatorModel(FBudgetModel)
    .selectedRecord(FRecordFound);
end;

destructor TBudgetController.Destroy;
begin

  inherited;
end;

function TBudgetController.duplicate: iBudgetDuplicateController;
begin
  Result := TOperatorDuplicateController.New.operatorModel(FBudgetModel);
end;

function TBudgetController.insert: iBudgetInsertController;
begin
  Result := TOperatorInsertController.New.operatorModel(FBudgetModel);
end;

function TBudgetController.name: string;
begin
  Result := FRecordFound.NAME;
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

  if AValue = EmptyStr then Exit;
  

  FRecordFound := FBudgetModel.DAO.FindWhere
    (Format('OPERATORID = %s', [QuotedStr(AValue)])).Items[0];
end;

function TBudgetController.update: iBudgetUpdateController;
begin
  Result := TOperatorUpdateController.New.operatorModel(FBudgetModel)
    .selectedRecord(FRecordFound);
end;

function TBudgetController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.updatedAt);
end;

end.
