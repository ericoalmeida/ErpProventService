unit Budget.Controller.Interf;

interface

uses Budget.Model.Interf, TORDBUDGET.Entity.Model;

type
  iBudgetInsertController = interface;
  iBudgetUpdateController = interface;
  iBudgetDeleteController = interface;
  iBudgetDuplicateController = interface;

  iBudgetController = interface
    function find(AValue: string): iBudgetController;
    function findById(AValue: string): iBudgetController;

    function insert: iBudgetInsertController;
    function update: iBudgetUpdateController;
    function delete: iBudgetDeleteController;
    function duplicate: iBudgetDuplicateController;

    function code: string;
    function budgetId: string;

    function createdAt: string;
    function updatedAt: string;
  end;

  iBudgetInsertController = interface
    function budgetModel(AValue: IBudgetModel): iBudgetInsertController;

    function companyId(AValue: string): iBudgetInsertController;
    function name(AValue: string): iBudgetInsertController;
    function status(AValue: integer): iBudgetInsertController;
    function userId(AValue: string): iBudgetInsertController;

    procedure save;
  end;

  iBudgetUpdateController = interface
    function budgetModel(AValue: IBudgetModel): iBudgetUpdateController;
    function selectedRecord(AValue: TTORDBUDGET): iBudgetUpdateController;

    function companyId(AValue: string): iBudgetUpdateController;
    function name(AValue: string): iBudgetUpdateController;
    function status(AValue: integer): iBudgetUpdateController;
    function userId(AValue: string): iBudgetUpdateController;

    procedure save;
  end;

  iBudgetDeleteController = interface
    function budgetModel(AValue: IBudgetModel): iBudgetDeleteController;
    function selectedRecord(AValue: TTORDBUDGET): iBudgetDeleteController;

    procedure save;
  end;

  iBudgetDuplicateController = interface
    function budgetModel(AValue: IBudgetModel)
      : iBudgetDuplicateController;

    function companyId(AValue: string): iBudgetDuplicateController;
    function name(AValue: string): iBudgetDuplicateController;
    function status(AValue: integer): iBudgetDuplicateController;
    function userId(AValue: string): iBudgetDuplicateController;

    procedure save;
  end;

implementation

end.
