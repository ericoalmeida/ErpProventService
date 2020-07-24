unit AssetsFactory.Model;

interface

uses AssetsFactory.Model.Interf, TypeExpense.Model.Interf, Vehicle.Model.Interf;

type
   TAssetsFactoryModel = class(TInterfacedObject, iAssetsFactoryModel)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iAssetsFactoryModel;

      function TypeExpenseModel: iTypeExpenseModel;
      function vehicleModel: IVehicleModel;
   end;

implementation

{ TAssetsFactoryModel }

uses TypeExpense.Model, Vehicle.Model;

constructor TAssetsFactoryModel.Create;
begin

end;

destructor TAssetsFactoryModel.Destroy;
begin

   inherited;
end;

class function TAssetsFactoryModel.New: iAssetsFactoryModel;
begin
   Result := Self.Create;
end;

function TAssetsFactoryModel.TypeExpenseModel: iTypeExpenseModel;
begin
   Result := TTypeExpenseModel.New;
end;

function TAssetsFactoryModel.vehicleModel: IVehicleModel;
begin
   Result := TVehicleModel.New;
end;

end.
