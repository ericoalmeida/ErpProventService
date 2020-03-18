unit Operators.Controller;

interface

uses Operators.Controller.Interf, Operators.Model.Interf,
  TORDOPERATOR.Entity.Model, System.SysUtils;

type
  TOperatorController = class(TInterfacedObject, iOperatorController)
  private
    FOperatorModel: IOperatorModel;
    FRecordFound: TTORDOPERATOR;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iOperatorController;

    function find(AValue: string): iOperatorController;
    function findById(AValue: string): iOperatorController;

    function insert: iOperatorInsertController;
    function update: iOperatorUpdateController;
    function delete: iOperatorDeleteController;
    function duplicate: iOperatorDuplicateController;

    function code: string;
    function operatorId: string;
    function name: string;
    function status: Integer;
    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TOperatorController }

uses Facade.Model, OperatorsInsert.Controller, OperatorsUpdate.Controller,
  OperatorsDelete.Controller, OperatorsDuplicate.Controller;

function TOperatorController.code: string;
begin
  Result := FRecordFound.code;
end;

function TOperatorController.operatorId: string;
begin
  Result := FRecordFound.operatorId.ToString;
end;

function TOperatorController.status: Integer;
begin
  Result := FRecordFound.STATUS
end;

constructor TOperatorController.Create;
begin
  FOperatorModel := TFacadeModel.New.moduleFacade.orderOfServiceFactoryModel.
    operatorModel;
end;

function TOperatorController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TOperatorController.delete: iOperatorDeleteController;
begin
  Result := TOperatorDeleteController.New.operatorModel(FOperatorModel)
    .selectedRecord(FRecordFound);
end;

destructor TOperatorController.Destroy;
begin

  inherited;
end;

function TOperatorController.duplicate: iOperatorDuplicateController;
begin
  Result := TOperatorDuplicateController.New.operatorModel(FOperatorModel);
end;

function TOperatorController.insert: iOperatorInsertController;
begin
  Result := TOperatorInsertController.New.operatorModel(FOperatorModel);
end;

function TOperatorController.name: string;
begin
  Result := FRecordFound.NAME;
end;

class function TOperatorController.New: iOperatorController;
begin
  Result := Self.Create;
end;

function TOperatorController.find(AValue: string): iOperatorController;
begin
  Result := Self;

  FRecordFound := FOperatorModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TOperatorController.findById(AValue: string): iOperatorController;
begin
  Result := Self;

  FRecordFound := FOperatorModel.DAO.FindWhere
    (Format('OPERATORID = %s', [QuotedStr(AValue)])).Items[0];
end;

function TOperatorController.update: iOperatorUpdateController;
begin
  Result := TOperatorUpdateController.New.operatorModel(FOperatorModel)
    .selectedRecord(FRecordFound);
end;

function TOperatorController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.updatedAt);
end;

end.
