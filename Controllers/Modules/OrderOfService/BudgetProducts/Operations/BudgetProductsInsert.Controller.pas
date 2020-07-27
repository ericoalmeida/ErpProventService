unit BudgetProductsInsert.Controller;

interface

uses BudgetProducts.Controller.Interf, BudgetProducts.Model.Interf,
   TORDBUDGETPRODUCTS.Entity.Model,
   System.SysUtils, System.Generics.Collections;

type
   TBudgetProductsInsertController = class(TInterfacedObject, IBudgetProductsInsertController)
   private
      FBudgetProductsModel: IBudgetProductsModel;

      FCompanyId: string;
      FBudgetId: string;
      FProductId: string;
      FQtde: Double;
      FUserId: string;


   public
      constructor Create;
      destructor Destroy; override;

      class function New: IBudgetProductsInsertController;

      function budgetProductsModel(AValue: IBudgetProductsModel): IBudgetProductsInsertController;

      function companyId(AValue: string): IBudgetProductsInsertController;
      function budgetId(AValue: string): IBudgetProductsInsertController;
      function productId(AValue: string): IBudgetProductsInsertController;
      function qtde(AValue: Double): IBudgetProductsInsertController;      
      function userId(AValue: string): IBudgetProductsInsertController;
     
      procedure save;
   end;

implementation

{ TBudgetProductsInsertController }

uses DataMFirebird.Model;

function TBudgetProductsInsertController.companyId(AValue: string)
  : IBudgetProductsInsertController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TBudgetProductsInsertController.Create;
begin

end;

destructor TBudgetProductsInsertController.Destroy;
begin

   inherited;
end;

class function TBudgetProductsInsertController.New: IBudgetProductsInsertController;
begin
   Result := Self.Create;
end;

function TBudgetProductsInsertController.productId(
  AValue: string): IBudgetProductsInsertController;
begin
   Result := Self;
   FProductId := AValue;
end;

function TBudgetProductsInsertController.qtde(
  AValue: Double): IBudgetProductsInsertController;
begin
  Result := self;
  FQtde  := AValue;
end;

procedure TBudgetProductsInsertController.save;
begin
   FBudgetProductsModel.Entity(TTORDBUDGETPRODUCTS.Create);

   FBudgetProductsModel.Entity.companyId        := FCompanyId;
   FBudgetProductsModel.Entity.BUDGETID         := FBudgetId;
   FBudgetProductsModel.Entity.productId        := FProductId;
   FBudgetProductsModel.Entity.QTDE             := FQtde;
   FBudgetProductsModel.Entity.userId           := FUserId;
   FBudgetProductsModel.Entity.CREATEDAT        := Now;
   FBudgetProductsModel.Entity.UPDATEDAT        := Now;

   FBudgetProductsModel.DAO.Insert(FBudgetProductsModel.Entity);
end;

function TBudgetProductsInsertController.userId(AValue: string)
  : IBudgetProductsInsertController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TBudgetProductsInsertController.budgetId(
  AValue: string): IBudgetProductsInsertController;
begin
   Result := Self;
   FBudgetId := AValue;
end;

function TBudgetProductsInsertController.budgetProductsModel(AValue: IBudgetProductsModel)
  : IBudgetProductsInsertController;
begin
   Result := Self;
   FBudgetProductsModel := AValue;
end;

end.
