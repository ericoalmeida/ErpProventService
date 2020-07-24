unit VehicleUpdate.Controller;

interface

uses Vehicle.Controller.Interf, Vehicle.Model.Interf,
   TASSVEHICLE.Entity.Model, System.SysUtils;

type
   TVehicleUpdateController = class(TInterfacedObject, iVehicleUpdateController)
   private
      FVehicleModel: IVehicleModel;
      FSelectedRecord: TTASSVEHICLE;

      FCompanyId: string;
      FDescription: string;
      FModel: string;
      FBrand: string;
      FCategory: string;
      FBoard: string;
      FStatus: Integer;
      FUserId: string;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iVehicleUpdateController;

      function vehicleModel(AValue: IVehicleModel): iVehicleUpdateController;
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

implementation

{ TVehicleUpdateController }

function TVehicleUpdateController.vehicleModel(AValue: IVehicleModel)
  : iVehicleUpdateController;
begin
   Result := Self;
   FVehicleModel := AValue;
end;

function TVehicleUpdateController.board(AValue: string)
  : iVehicleUpdateController;
begin
   Result := Self;
   FBoard := AValue;
end;

function TVehicleUpdateController.brand(AValue: string)
  : iVehicleUpdateController;
begin
   Result := Self;
   FBrand := AValue;
end;

function TVehicleUpdateController.category(AValue: string)
  : iVehicleUpdateController;
begin
   Result := Self;
   FCategory := AValue;
end;

function TVehicleUpdateController.companyId(AValue: string)
  : iVehicleUpdateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TVehicleUpdateController.Create;
begin

end;

function TVehicleUpdateController.description(AValue: string)
  : iVehicleUpdateController;
begin
   Result := Self;
   FDescription := AValue;
end;

destructor TVehicleUpdateController.Destroy;
begin

   inherited;
end;

function TVehicleUpdateController.Model(AValue: string)
  : iVehicleUpdateController;
begin
   Result := Self;
   FModel := AValue;
end;

class function TVehicleUpdateController.New: iVehicleUpdateController;
begin
   Result := Self.Create;
end;

procedure TVehicleUpdateController.save;
begin
   FVehicleModel.DAO.Modify(FSelectedRecord);

   FSelectedRecord.companyId := FCompanyId;
   FSelectedRecord.description := FDescription;
   FSelectedRecord.Model := FModel;
   FSelectedRecord.brand := FBrand;
   FSelectedRecord.category := FCategory;
   FSelectedRecord.board := FBoard;
   FSelectedRecord.status := FStatus;
   FSelectedRecord.userId := FUserId;
   FSelectedRecord.UPDATEDAT := Now;

   FVehicleModel.DAO.Update(FSelectedRecord);
end;

function TVehicleUpdateController.selectedRecord(AValue: TTASSVEHICLE)
  : iVehicleUpdateController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

function TVehicleUpdateController.status(AValue: Integer)
  : iVehicleUpdateController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TVehicleUpdateController.userId(AValue: string)
  : iVehicleUpdateController;
begin
   Result := Self;
   FUserId := AValue;
end;

end.
