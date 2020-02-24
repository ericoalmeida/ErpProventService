unit AssetsFactory.Controller.interf;

interface

uses TypeExpense.Controller.Interf;

type
  iAssetsFactoryController = interface
    ['{CEAB3658-9F6C-4B09-B4CD-506E9CB614A7}']
    function typeExpense: iTypeExpenseController;
  end;

implementation

end.
