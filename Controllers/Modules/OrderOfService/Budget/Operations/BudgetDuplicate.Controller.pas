unit BudgetDuplicate.Controller;

interface

uses Budget.Controller.Interf, Budget.Model.Interf,
  TORDBUDGET.Entity.Model,
  System.SysUtils;

type
  TBudgetDuplicateController = class(TInterfacedObject,
    iBudgetDuplicateController)
  private
    FBudgetModel: IBudgetModel;

    FCompanyId: string;
    FDescription: string;
    FEmissionDate: TDateTime;
    FUserId: string;

    function getBudgetId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iBudgetDuplicateController;

    function budgetModel(AValue: IBudgetModel)
      : iBudgetDuplicateController;

    function companyId(AValue: string): iBudgetDuplicateController;
    function description(AValue: string): iBudgetDuplicateController;
    function emissionDate(AValue: TDateTime): iBudgetDuplicateController;
    function userId(AValue: string): iBudgetDuplicateController;

    procedure save;
  end;

implementation

{ TBudgetDuplicateController }

function TBudgetDuplicateController.companyId(AValue: string)
  : iBudgetDuplicateController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TBudgetDuplicateController.Create;
begin

end;

function TBudgetDuplicateController.description(
  AValue: string): iBudgetDuplicateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TBudgetDuplicateController.Destroy;
begin

  inherited;
end;

function TBudgetDuplicateController.emissionDate(
  AValue: TDateTime): iBudgetDuplicateController;
begin
  Result := Self;
  FEmissionDate := AValue;
end;

class function TBudgetDuplicateController.New: iBudgetDuplicateController;
begin
  Result := Self.Create;
end;

function TBudgetDuplicateController.getBudgetId: Integer;
begin
  if FBudgetModel.DAO.Find.Count <> 0 then
  begin
    Result := FBudgetModel.DAO.FindWhere('', 'OPERATORID desc')
      .Last.BUDGETID + 1;
  end
  else
  begin
    Result := 1;
  end;
end;

procedure TBudgetDuplicateController.save;
begin
  FBudgetModel.Entity(TTORDBUDGET.Create);

  FBudgetModel.Entity.companyId    := FCompanyId;
  FBudgetModel.Entity.BUDGETID     := getBudgetId;
  FBudgetModel.Entity.DESCRIPTION  := FDescription;
  FBudgetModel.Entity.EMISSIONDATE := FEmissionDate;
  FBudgetModel.Entity.USERID       := FUserId;
  FBudgetModel.Entity.CREATEDAT    := Now;
  FBudgetModel.Entity.UPDATEDAT    := Now;

  FBudgetModel.DAO.Insert(FBudgetModel.Entity);
end;

function TBudgetDuplicateController.userId(AValue: string)
  : iBudgetDuplicateController;
begin
  Result := Self;
  FUserId := AValue;
end;

function TBudgetDuplicateController.budgetModel(AValue: IBudgetModel)
  : iBudgetDuplicateController;
begin
  Result := Self;
  FBudgetModel := AValue;
end;

end.
