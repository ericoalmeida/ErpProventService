unit BudgetUpdate.Controller;

interface

uses Budget.Controller.Interf, Budget.Model.Interf,
   TORDBUDGET.Entity.Model,
   System.SysUtils;

type
   TBudgetUpdateController = class(TInterfacedObject, iBudgetUpdateController)
   private
      FBudgetModel: IBudgetModel;
      FSelectedRecord: TTORDBUDGET;

      FCompanyId: string;
      FDescription: string;
      FEmissionDate: TDateTime;
      FUserId: string;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iBudgetUpdateController;

      function budgetModel(AValue: IBudgetModel): iBudgetUpdateController;
      function selectedRecord(AValue: TTORDBUDGET): iBudgetUpdateController;

      function companyId(AValue: string): iBudgetUpdateController;
      function description(AValue: string): iBudgetUpdateController;
      function emissionDate(AValue: TDateTime): iBudgetUpdateController;
      function userId(AValue: string): iBudgetUpdateController;

      procedure save;
   end;

implementation

{ TBudgetUpdateController }

function TBudgetUpdateController.budgetModel(AValue: IBudgetModel)
  : iBudgetUpdateController;
begin
   Result := Self;
   FBudgetModel := AValue;
end;

function TBudgetUpdateController.companyId(AValue: string)
  : iBudgetUpdateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TBudgetUpdateController.Create;
begin

end;

function TBudgetUpdateController.description(AValue: string)
  : iBudgetUpdateController;
begin
   Result := Self;
   FDescription := AValue;
end;

destructor TBudgetUpdateController.Destroy;
begin

   inherited;
end;

function TBudgetUpdateController.emissionDate(AValue: TDateTime)
  : iBudgetUpdateController;
begin
   Result := Self;
   FEmissionDate := AValue;
end;

class function TBudgetUpdateController.New: iBudgetUpdateController;
begin
   Result := Self.Create;
end;

procedure TBudgetUpdateController.save;
begin
   FBudgetModel.DAO.Modify(FSelectedRecord);

   FSelectedRecord.companyId := FCompanyId;
   FSelectedRecord.description := FDescription;
   FSelectedRecord.emissionDate := FEmissionDate;
   FSelectedRecord.userId := FUserId;
   FSelectedRecord.UPDATEDAT := Now;

   FBudgetModel.DAO.Update(FSelectedRecord);
end;

function TBudgetUpdateController.selectedRecord(AValue: TTORDBUDGET)
  : iBudgetUpdateController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

function TBudgetUpdateController.userId(AValue: string)
  : iBudgetUpdateController;
begin
   Result := Self;
   FUserId := AValue;
end;

end.
