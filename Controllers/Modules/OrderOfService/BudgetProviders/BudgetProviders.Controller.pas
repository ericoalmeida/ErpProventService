unit BudgetProviders.Controller;

interface

uses BudgetProviders.Controller.Interf, BudgetProviders.Model.Interf,
   System.SysUtils, TORDBUDGETPROVIDERS.Entity.Model, TMNGPERSON.Entity.Model,
  Person.Model.Interf, FireDAC.Stan.Intf,
   FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
   FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataMFirebird.Model;

type
   TBudgetProvidersController = class(TInterfacedObject, IBudgetProvidersController)
   private
      FQuery: TFDQuery;
      FBudgetProvidersModel: IBudgetProvidersModel;
      FProvidersModel: IPersonModel;
      FRecordFound: TTORDBUDGETPROVIDERS;
      FRecordProvider:  TTMNGPERSON;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: IBudgetProvidersController;

      function find(AValue: string): IBudgetProvidersController;
      function findById(AValue: string): IBudgetProvidersController;

      function insert: IBudgetProvidersInsertController;
      function cleanOldRecords(ACompanyId: string; ABudGetId: string): IBudgetProvidersController;

      function budgetId: string;
      function sequenceProvider: Integer;
      function providerOwnId: Integer;
      function providerId: string;
      function providerName: string;
      function createdAt: string;
      function updatedAt: string;
   end;

implementation

{ TBudgetProvidersController }

uses Facade.Model, BudgetProvidersInsert.Controller, Types.Models;

function TBudgetProvidersController.budgetId: string;
begin
   Result := FRecordFound.BUDGETID;
end;

function TBudgetProvidersController.cleanOldRecords(ACompanyId: string; ABudGetId: string): IBudgetProvidersController;
begin
  Result := Self;

  FQuery.ExecSQL(
   'delete from tordbudgetproviders a            '+
   'where                                        '+
   Format('a.companyid = %s and a.budgetid = %s  ', 
   [QuotedStr(ACompanyId), QuotedStr(ABudGetId)])
  ); 
end;

constructor TBudgetProvidersController.Create;
begin
   FQuery := TFDQuery.Create(nil);

   FQuery.Connection := TFacadeModel.New.ConnectionFactoryModel.
     connectionWithDatabase(dbFirebird).fdConnection;

   FBudgetProvidersModel := TFacadeModel.New.moduleFacade.orderOfServiceFactoryModel.
     budgetProvidersModel;
   FProvidersModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.personModel;
end;

function TBudgetProvidersController.createdAt: string;
begin
   Result := DateTimeToStr(FRecordFound.createdAt);
end;

destructor TBudgetProvidersController.Destroy;
begin

   inherited;
end;

function TBudgetProvidersController.insert: IBudgetProvidersInsertController;
begin
   Result := TBudgetProvidersInsertController.New.budgetProvidersModel(FBudgetProvidersModel);
end;

class function TBudgetProvidersController.New: IBudgetProvidersController;
begin
   Result := Self.Create;
end;

function TBudgetProvidersController.providerId: string;
begin
 Result := FRecordFound.PROVIDERID;
end;

function TBudgetProvidersController.providerName: string;
begin
   Result := FRecordProvider.NAME;
end;

function TBudgetProvidersController.providerOwnId: Integer;
begin
   Result := FRecordProvider.PERSONID;
end;

function TBudgetProvidersController.sequenceProvider: Integer;
begin
  Result := FRecordFound.SEQUENCEPROVIDER;
end;

function TBudgetProvidersController.find(AValue: string): IBudgetProvidersController;
begin
   Result := Self;

   FRecordFound := FBudgetProvidersModel.DAO.FindWhere
     (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];

   FRecordProvider := FProvidersModel.DAO.FindWhere
     (Format('CODE = %s', [QuotedStr(FRecordFound.PROVIDERID)])).Items[0];     
end;

function TBudgetProvidersController.findById(AValue: string): IBudgetProvidersController;
begin
   Result := Self;

   if AValue = EmptyStr then
      Exit;

   FRecordFound := FBudgetProvidersModel.DAO.FindWhere(Format('OPERATORID = %s',
     [QuotedStr(AValue)])).Items[0];
end;

function TBudgetProvidersController.updatedAt: string;
begin
   Result := DateTimeToStr(FRecordFound.updatedAt);
end;

end.
