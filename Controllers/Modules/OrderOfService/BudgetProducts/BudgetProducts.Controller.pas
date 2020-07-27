unit BudgetProducts.Controller;

interface

uses BudgetProducts.Controller.Interf, BudgetProducts.Model.Interf,
   System.SysUtils, TORDBUDGETPRODUCTS.Entity.Model, TMNGPERSON.Entity.Model,
   Person.Model.Interf, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataMFirebird.Model;

type
   TBudgetProductsController = class(TInterfacedObject, IBudgetProductsController)
   private
      FQuery: TFDQuery;
      FBudgetProductsModel: IBudgetProductsModel;
      FRecordFound: TTORDBUDGETPRODUCTS;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: IBudgetProductsController;

      function find(AValue: string): IBudgetProductsController;
      function findById(AValue: string): IBudgetProductsController;

      function insert: IBudgetProductsInsertController;
      function cleanOldRecords(ACompanyId: string; ABudGetId: string): IBudgetProductsController;

      function sequenceProducts: Integer;
      function budgetId: string;
      function productId: string;
      function createdAt: string;
      function updatedAt: string;
   end;

implementation

{ TBudgetProductsController }

uses Facade.Model, BudgetProvidersInsert.Controller, Types.Models,
  BudgetProductsInsert.Controller;

function TBudgetProductsController.budgetId: string;
begin
   Result := FRecordFound.BUDGETID;
end;

function TBudgetProductsController.cleanOldRecords(ACompanyId: string; ABudGetId: string): IBudgetProductsController;
begin
  Result := Self;

  FQuery.ExecSQL(
   'delete from tordbudgetproducts  a            '+
   'where                                        '+
   Format('a.companyid = %s and a.budgetid = %s  ', 
   [QuotedStr(ACompanyId), QuotedStr(ABudGetId)])
  ); 
end;

constructor TBudgetProductsController.Create;
begin
   FQuery := TFDQuery.Create(nil);

   FQuery.Connection := TFacadeModel.New.ConnectionFactoryModel.
     connectionWithDatabase(dbFirebird).fdConnection;

   FBudgetProductsModel := TFacadeModel.New.moduleFacade.orderOfServiceFactoryModel.
     budgetProductsModel;
end;

function TBudgetProductsController.createdAt: string;
begin
   Result := DateTimeToStr(FRecordFound.createdAt);
end;

destructor TBudgetProductsController.Destroy;
begin

   inherited;
end;

function TBudgetProductsController.insert: IBudgetProductsInsertController;
begin
   Result := TBudgetProductsInsertController.New.budgetProductsModel(FBudgetProductsModel);
end;

class function TBudgetProductsController.New: IBudgetProductsController;
begin
   Result := Self.Create;
end;

function TBudgetProductsController.productId: string;
begin
  Result := FRecordFound.PRODUCTID;
end;

function TBudgetProductsController.sequenceProducts: Integer;
begin
  Result := FRecordFound.SEQUENCEPROD;
end;

function TBudgetProductsController.find(AValue: string): IBudgetProductsController;
begin
   Result := Self;

   FRecordFound := FBudgetProductsModel.DAO.FindWhere
     (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TBudgetProductsController.findById(AValue: string): IBudgetProductsController;
begin
   Result := Self;

   if AValue = EmptyStr then
      Exit;

   FRecordFound := FBudgetProductsModel.DAO.FindWhere(Format('OPERATORID = %s',
     [QuotedStr(AValue)])).Items[0];
end;

function TBudgetProductsController.updatedAt: string;
begin
   Result := DateTimeToStr(FRecordFound.updatedAt);
end;

end.
