unit TypeExpenseUpdate.Controller;

interface

uses TypeExpense.Controller.Interf, TypeExpense.Model.Interf,
  TASSTYPEEXPENSE.Entity.Model, System.SysUtils;

type
  TTypeExpenseUpdateController = class(TInterfacedObject, iTypeExpenseUpdateController)
  private
   FTypeExpenseModel: ITypeExpenseModel;
   FSelectedRecord: TTASSTYPEEXPENSE;

   FCompanyId: string;
   FDescription: string;
   FStatus: Integer;
   FUserId: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iTypeExpenseUpdateController;

    function typeExpenseModel(AValue: ITypeExpenseModel): iTypeExpenseUpdateController;
    function selectedRecord(AValue: TTASSTYPEEXPENSE): iTypeExpenseUpdateController;

    function companyId(AValue: string): iTypeExpenseUpdateController;
    function description(AValue: string): iTypeExpenseUpdateController;
    function status(AValue: Integer): iTypeExpenseUpdateController;
    function userId(AValue: string): iTypeExpenseUpdateController;

    procedure save;
  end;

implementation

{ TTypeExpenseUpdateController }

function TTypeExpenseUpdateController.typeExpenseModel(AValue: ITypeExpenseModel): iTypeExpenseUpdateController;
begin
  Result := Self;
  FTypeExpenseModel := AValue;
end;

function TTypeExpenseUpdateController.companyId(AValue: string): iTypeExpenseUpdateController;
begin
 Result := Self;
 FCompanyId := AValue;
end;

function TTypeExpenseUpdateController.userId(AValue: string): iTypeExpenseUpdateController;
begin
 Result := Self;
 FUserId := AValue;
end;

constructor TTypeExpenseUpdateController.Create;
begin

end;

function TTypeExpenseUpdateController.description(AValue: string): iTypeExpenseUpdateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TTypeExpenseUpdateController.Destroy;
begin

  inherited;
end;

class function TTypeExpenseUpdateController.New: iTypeExpenseUpdateController;
begin
  Result := Self.Create;
end;

procedure TTypeExpenseUpdateController.save;
begin
  FTypeExpenseModel.DAO.Modify(FSelectedRecord);

  FSelectedRecord.COMPANYID   := FCompanyId;
  FSelectedRecord.DESCRIPTION := FDescription;
  FSelectedRecord.STATUS      := FStatus;
  FSelectedRecord.USERID      := FUserId;
  FSelectedRecord.UPDATEDAT   := Now;

  FTypeExpenseModel.DAO.Update(FSelectedRecord);
end;

function TTypeExpenseUpdateController.selectedRecord(AValue: TTASSTYPEEXPENSE): iTypeExpenseUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

function TTypeExpenseUpdateController.status(AValue: Integer): iTypeExpenseUpdateController;
begin
 Result := Self;
 FStatus := AValue;
end;

end.
