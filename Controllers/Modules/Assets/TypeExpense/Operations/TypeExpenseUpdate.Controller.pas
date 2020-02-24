unit TypeExpenseUpdate.Controller;

interface

uses TypeExpense.Controller.Interf, TypeExpense.Model.Interf,
  TASSTYPEEXPENSE.Entity.Model, System.SysUtils;

type
  TTypeExpenseUpdateController = class(TInterfacedObject, iTypeExpenseUpdateController)
  private
   FTypeExpenseModel: ITypeExpenseModel;
   FSelectedRecord: TTASSTYPEEXPENSE;

   FDescription: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iTypeExpenseUpdateController;

    function typeExpenseModel(AValue: ITypeExpenseModel): iTypeExpenseUpdateController;
    function selectedRecord(AValue: TTASSTYPEEXPENSE): iTypeExpenseUpdateController;

    function description(AValue: string): iTypeExpenseUpdateController;

    procedure save;
  end;

implementation

{ TTypeExpenseUpdateController }

function TTypeExpenseUpdateController.typeExpenseModel(AValue: ITypeExpenseModel): iTypeExpenseUpdateController;
begin
  Result := Self;
  FTypeExpenseModel := AValue;
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

  FSelectedRecord.DESCRIPTION := FDescription;
  FSelectedRecord.UPDATEDAT   := Now;

  FTypeExpenseModel.DAO.Update(FSelectedRecord);
end;

function TTypeExpenseUpdateController.selectedRecord(AValue: TTASSTYPEEXPENSE): iTypeExpenseUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.
