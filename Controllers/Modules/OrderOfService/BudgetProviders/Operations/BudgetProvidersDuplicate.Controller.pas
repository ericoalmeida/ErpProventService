unit BudgetProvidersDuplicate.Controller;

interface

uses BudgetProviders.Controller.Interf, BudgetProviders.Model.Interf,
   TORDBUDGETPROVIDERS.Entity.Model,
   System.SysUtils, System.Generics.Collections;

type
   TBudgetProvidersDuplicateController = class(TInterfacedObject, IBudgetProvidersDuplicateController)
   private
      FBudgetProvidersModel: IBudgetProvidersModel;

      FCompanyId: string;
      FBudgetId: string;
      FProviderId: string;
      FUserId: string;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: IBudgetProvidersDuplicateController;

      function budgetProvidersModel(AValue: IBudgetProvidersModel): IBudgetProvidersDuplicateController;

      function companyId(AValue: string): IBudgetProvidersDuplicateController;
      function budgetId(AValue: string): IBudgetProvidersDuplicateController;
      function providerId(AValue: string): IBudgetProvidersDuplicateController;
      function userId(AValue: string): IBudgetProvidersDuplicateController;

      procedure save;
   end;

implementation

{ TBudgetProvidersDuplicateController }

function TBudgetProvidersDuplicateController.companyId(AValue: string)
  : IBudgetProvidersDuplicateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TBudgetProvidersDuplicateController.Create;
begin

end;

destructor TBudgetProvidersDuplicateController.Destroy;
begin

   inherited;
end;

class function TBudgetProvidersDuplicateController.New: IBudgetProvidersDuplicateController;
begin
   Result := Self.Create;
end;

function TBudgetProvidersDuplicateController.providerId(
  AValue: string): IBudgetProvidersDuplicateController;
begin
   Result := Self;
   FProviderId := AValue;
end;

procedure TBudgetProvidersDuplicateController.save;
begin
   FBudgetProvidersModel.Entity(TTORDBUDGETPROVIDERS.Create);

   FBudgetProvidersModel.Entity.companyId        := FCompanyId;
   FBudgetProvidersModel.Entity.BUDGETID         := FBudgetId;
   FBudgetProvidersModel.Entity.PROVIDERID       := FProviderId;
   FBudgetProvidersModel.Entity.userId           := FUserId;
   FBudgetProvidersModel.Entity.CREATEDAT        := Now;
   FBudgetProvidersModel.Entity.UPDATEDAT        := Now;

   FBudgetProvidersModel.DAO.Insert(FBudgetProvidersModel.Entity);
end;

function TBudgetProvidersDuplicateController.userId(AValue: string)
  : IBudgetProvidersDuplicateController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TBudgetProvidersDuplicateController.budgetId(
  AValue: string): IBudgetProvidersDuplicateController;
begin
   Result := Self;
   FBudgetId := AValue;
end;

function TBudgetProvidersDuplicateController.budgetProvidersModel(AValue: IBudgetProvidersModel)
  : IBudgetProvidersDuplicateController;
begin
   Result := Self;
   FBudgetProvidersModel := AValue;
end;

end.
