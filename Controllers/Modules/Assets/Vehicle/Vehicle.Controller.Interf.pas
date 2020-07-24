unit Vehicle.Controller.Interf;

interface

uses Vehicle.Model.Interf, TASSVEHICLE.Entity.Model;

type
   iVehicleInsertController = interface;
   iVehicleUpdateController = interface;
   iVehicleDeleteController = interface;
   iVehicleDuplicateController = interface;

   iVehicleController = interface
      function find(AValue: string): iVehicleController;
      function findById(AValue: string): iVehicleController;

      function insert: iVehicleInsertController;
      function update: iVehicleUpdateController;
      function delete: iVehicleDeleteController;
      function duplicate: iVehicleDuplicateController;

      function code: string;
      function vehicleId: string;

      function description: string;
      function Model: string;
      function brand: string;
      function category: string;
      function board: string;
      function status: Integer;
      function userId: string;

      function createdAt: string;
      function updatedAt: string;
   end;

   iVehicleInsertController = interface
      function vehicleModel(AValue: iVehicleModel): iVehicleInsertController;

      function companyId(AValue: string): iVehicleInsertController;
      function description(AValue: string): iVehicleInsertController;
      function Model(AValue: string): iVehicleInsertController;
      function brand(AValue: string): iVehicleInsertController;
      function category(AValue: string): iVehicleInsertController;
      function board(AValue: string): iVehicleInsertController;
      function status(AValue: Integer): iVehicleInsertController;
      function userId(AValue: string): iVehicleInsertController;

      procedure save;
   end;

   iVehicleUpdateController = interface
      function vehicleModel(AValue: iVehicleModel): iVehicleUpdateController;
      function selectedRecord(AValue: TTASSVEHICLE): iVehicleUpdateController;

      function companyId(AValue: string): iVehicleUpdateController;
      function description(AValue: string): iVehicleUpdateController;
      function Model(AValue: string): iVehicleUpdateController;
      function brand(AValue: string): iVehicleUpdateController;
      function category(AValue: string): iVehicleUpdateController;
      function board(AValue: string): iVehicleUpdateController;
      function status(AValue: Integer): iVehicleUpdateController;
      function userId(AValue: string): iVehicleUpdateController;

      procedure save;
   end;

   iVehicleDeleteController = interface
      function vehicleModel(AValue: iVehicleModel): iVehicleDeleteController;
      function selectedRecord(AValue: TTASSVEHICLE): iVehicleDeleteController;

      procedure save;
   end;

   iVehicleDuplicateController = interface
      function vehicleModel(AValue: iVehicleModel): iVehicleDuplicateController;

      function companyId(AValue: string): iVehicleDuplicateController;
      function description(AValue: string): iVehicleDuplicateController;
      function Model(AValue: string): iVehicleDuplicateController;
      function brand(AValue: string): iVehicleDuplicateController;
      function category(AValue: string): iVehicleDuplicateController;
      function board(AValue: string): iVehicleDuplicateController;
      function status(AValue: Integer): iVehicleDuplicateController;
      function userId(AValue: string): iVehicleDuplicateController;

      procedure save;
   end;

implementation

end.
