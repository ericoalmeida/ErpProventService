unit BudgetAnalyzes.Model;

interface

uses BudgetAnalyzes.Model.Interf, ormbr.container.objectset.interfaces,
   ormbr.Factory.interfaces, TORDBUDGETANALYZES.Entity.Model;

type
   TBudgetAnalyzesModel = class(TInterfacedObject, IBudgetAnalyzesModel)
   private
      FConnection: IDBConnection;
      FEntity: TTORDBUDGETANALYZES;
      FDAO: IContainerObjectSet<TTORDBUDGETANALYZES>;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: IBudgetAnalyzesModel;

      function Entity: TTORDBUDGETANALYZES; overload;
      function Entity(AValue: TTORDBUDGETANALYZES)
        : IBudgetAnalyzesModel; overload;

      function DAO: IContainerObjectSet<TTORDBUDGETANALYZES>;
   end;

implementation

{ TBudgetAnalyzesModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TBudgetAnalyzesModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.
     currentConnection;
   FDAO := TContainerObjectSet<TTORDBUDGETANALYZES>.Create(FConnection, 1);
end;

function TBudgetAnalyzesModel.DAO: IContainerObjectSet<TTORDBUDGETANALYZES>;
begin
   result := FDAO;
end;

destructor TBudgetAnalyzesModel.Destroy;
begin

   inherited;
end;

function TBudgetAnalyzesModel.Entity: TTORDBUDGETANALYZES;
begin
   result := FEntity;
end;

function TBudgetAnalyzesModel.Entity(AValue: TTORDBUDGETANALYZES)
  : IBudgetAnalyzesModel;
begin
   result := Self;
   FEntity := AValue;
end;

class function TBudgetAnalyzesModel.New: IBudgetAnalyzesModel;
begin
   result := Self.Create;
end;

end.
