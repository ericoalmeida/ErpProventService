unit BudgetInsert.Controller;

interface

uses Budget.Controller.Interf, Budget.Model.Interf,
   TORDBUDGET.Entity.Model,
   System.SysUtils;

type
   TBudgetInsertController = class(TInterfacedObject, iBudgetInsertController)
   private
      FBudgetModel: IBudgetModel;

      FCompanyId: string;
      FDescription: string;
      FEmissionDate: TDateTime;
      FUserId: string;

      function getBudgetId: Integer;
      constructor Create;
      destructor Destroy; override;

   public
      class function New: iBudgetInsertController;

      function budgetModel(AValue: IBudgetModel): iBudgetInsertController;

      function companyId(AValue: string): iBudgetInsertController;
      function description(AValue: string): iBudgetInsertController;
      function emissionDate(AValue: TDateTime): iBudgetInsertController;
      function userId(AValue: string): iBudgetInsertController;

      procedure save;
   end;

implementation

{ TBudgetInsertController }

function TBudgetInsertController.companyId(AValue: string)
  : iBudgetInsertController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TBudgetInsertController.Create;
begin

end;

function TBudgetInsertController.description(AValue: string)
  : iBudgetInsertController;
begin
   Result := Self;
   FDescription := AValue;
end;

destructor TBudgetInsertController.Destroy;
begin

   inherited;
end;

function TBudgetInsertController.emissionDate(AValue: TDateTime)
  : iBudgetInsertController;
begin
   Result := Self;
   FEmissionDate := AValue;
end;

class function TBudgetInsertController.New: iBudgetInsertController;
begin
   Result := Self.Create;
end;

function TBudgetInsertController.getBudgetId: Integer;
begin
   if FBudgetModel.DAO.Find.Count <> 0 then
   begin
      Result := FBudgetModel.DAO.FindWhere('', 'BUDGETID desc')
        .Last.BUDGETID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

procedure TBudgetInsertController.save;
begin
   FBudgetModel.Entity(TTORDBUDGET.Create);

   FBudgetModel.Entity.companyId := FCompanyId;
   FBudgetModel.Entity.BUDGETID := getBudgetId;
   FBudgetModel.Entity.description := FDescription;
   FBudgetModel.Entity.emissionDate := FEmissionDate;
   FBudgetModel.Entity.userId := FUserId;
   FBudgetModel.Entity.CREATEDAT := Now;
   FBudgetModel.Entity.UPDATEDAT := Now;

   FBudgetModel.DAO.Insert(FBudgetModel.Entity);
end;

function TBudgetInsertController.userId(AValue: string)
  : iBudgetInsertController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TBudgetInsertController.budgetModel(AValue: IBudgetModel)
  : iBudgetInsertController;
begin
   Result := Self;
   FBudgetModel := AValue;
end;

end.
