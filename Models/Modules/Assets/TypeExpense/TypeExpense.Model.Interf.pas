unit TypeExpense.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TASSTYPEEXPENSE.Entity.Model;

type
   iTypeExpenseModel = interface
      ['{D490AB61-CAC2-44AA-9E4D-E57D726C4EB1}']
      function Entity: TTASSTYPEEXPENSE; overload;
      function Entity(AValue: TTASSTYPEEXPENSE): iTypeExpenseModel; overload;
      function DAO: IContainerObjectSet<TTASSTYPEEXPENSE>;
   end;

implementation

end.
