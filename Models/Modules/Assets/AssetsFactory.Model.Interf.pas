unit AssetsFactory.Model.Interf;

interface

uses TypeExpense.Model.Interf, Vehicle.Model.Interf;

type
   iAssetsFactoryModel = interface
      ['{A2090FAD-CFF3-4148-A6EC-CE230FA7B9B7}']
      function TypeExpenseModel: iTypeExpenseModel;
      function vehicleModel: IVehicleModel;
   end;

implementation

end.
