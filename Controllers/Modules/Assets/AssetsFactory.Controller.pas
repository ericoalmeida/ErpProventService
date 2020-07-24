unit AssetsFactory.Controller;

interface

uses AssetsFactory.Controller.interf, TypeExpense.Controller.interf,
   Vehicle.Controller.interf;

type
   TAssetsFactoryController = class(TInterfacedObject, iAssetsFactoryController)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iAssetsFactoryController;

      function TypeExpenseController: iTypeExpenseController;
      function vehicleController: iVehicleController;
   end;

implementation

{ TAssetsFactoryController }

uses TypeExpense.Controller, Vehicle.Controller;

constructor TAssetsFactoryController.Create;
begin

end;

destructor TAssetsFactoryController.Destroy;
begin

   inherited;
end;

class function TAssetsFactoryController.New: iAssetsFactoryController;
begin
   Result := Self.Create;
end;

function TAssetsFactoryController.TypeExpenseController: iTypeExpenseController;
begin
   Result := TTypeExpenseController.New;
end;

function TAssetsFactoryController.vehicleController: iVehicleController;
begin
   Result := TVehicleController.New;
end;

end.
