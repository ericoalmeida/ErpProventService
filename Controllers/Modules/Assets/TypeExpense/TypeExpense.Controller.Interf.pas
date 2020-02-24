unit TypeExpense.Controller.Interf;

interface

uses TypeExpense.Model.Interf, TASSTYPEEXPENSE.Entity.Model;

type
  iTypeExpenseInsertController = interface;
  iTypeExpenseUpdateController = interface;
  iTypeExpenseDeleteController = interface;
  iTypeExpenseDuplicateController = interface;

  iTypeExpenseController = interface
    function find(AValue: string): iTypeExpenseController;

    function insert: iTypeExpenseInsertController;
    function update: iTypeExpenseUpdateController;
    function delete: iTypeExpenseDeleteController;
    function duplicate: iTypeExpenseDuplicateController;

    function code: string;
    function typeExpenseId: string;
    function description: string;

    function createdAt: string;
    function updatedAt: string;
  end;

  iTypeExpenseInsertController = interface
    function typeExpenseModel(AValue: iTypeExpenseModel): iTypeExpenseInsertController;
    function description(AValue: string): iTypeExpenseInsertController;

    procedure save;
  end;

  iTypeExpenseUpdateController = interface
    function typeExpenseModel(AValue: iTypeExpenseModel): iTypeExpenseUpdateController;
    function selectedRecord(AValue: TTASSTYPEEXPENSE): iTypeExpenseUpdateController;

    function description(AValue: string): iTypeExpenseUpdateController;

    procedure save;
  end;

  iTypeExpenseDeleteController = interface
    function typeExpenseModel(AValue: iTypeExpenseModel): iTypeExpenseDeleteController;
    function selectedRecord(AValue: TTASSTYPEEXPENSE): iTypeExpenseDeleteController;

    procedure save;
  end;

  iTypeExpenseDuplicateController = interface
    function typeExpenseModel(AValue: iTypeExpenseModel): iTypeExpenseDuplicateController;

    function description(AValue: string): iTypeExpenseDuplicateController;

    procedure save;
  end;

implementation

end.
