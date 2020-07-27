unit BudgetProvidersInsert.Controller;

interface

uses BudgetProviders.Controller.Interf, BudgetProviders.Model.Interf,
   TORDBUDGETPROVIDERS.Entity.Model,
   System.SysUtils, System.Generics.Collections;

type
   TBudgetProvidersInsertController = class(TInterfacedObject, IBudgetProvidersInsertController)
   private
      FBudgetProvidersModel: IBudgetProvidersModel;

      FCompanyId: string;
      FBudgetId: string;
      FProviderId: string;
      FUserId: string;


   public
      constructor Create;
      destructor Destroy; override;

      class function New: IBudgetProvidersInsertController;

      function budgetProvidersModel(AValue: IBudgetProvidersModel): IBudgetProvidersInsertController;

      function companyId(AValue: string): IBudgetProvidersInsertController;
      function budgetId(AValue: string): IBudgetProvidersInsertController;
      function providerId(AValue: string): IBudgetProvidersInsertController;
      function userId(AValue: string): IBudgetProvidersInsertController;
     
      procedure save;
   end;

implementation

{ TBudgetProvidersInsertController }

uses DataMFirebird.Model;

function TBudgetProvidersInsertController.companyId(AValue: string)
  : IBudgetProvidersInsertController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TBudgetProvidersInsertController.Create;
begin

end;

destructor TBudgetProvidersInsertController.Destroy;
begin

   inherited;
end;

class function TBudgetProvidersInsertController.New: IBudgetProvidersInsertController;
begin
   Result := Self.Create;
end;

function TBudgetProvidersInsertController.providerId(
  AValue: string): IBudgetProvidersInsertController;
begin
   Result := Self;
   FProviderId := AValue;
end;

procedure TBudgetProvidersInsertController.save;
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

function TBudgetProvidersInsertController.userId(AValue: string)
  : IBudgetProvidersInsertController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TBudgetProvidersInsertController.budgetId(
  AValue: string): IBudgetProvidersInsertController;
begin
   Result := Self;
   FBudgetId := AValue;
end;

function TBudgetProvidersInsertController.budgetProvidersModel(AValue: IBudgetProvidersModel)
  : IBudgetProvidersInsertController;
begin
   Result := Self;
   FBudgetProvidersModel := AValue;
end;

end.
