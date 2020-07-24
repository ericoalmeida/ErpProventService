unit VehicleDuplicate.Controller;

interface

uses Vehicle.Controller.Interf, Vehicle.Model.Interf,
   TASSVEHICLE.Entity.Model,
   System.SysUtils;

type
   TVehicleDuplicateController = class(TInterfacedObject,
     iVehicleDuplicateController)
   private
      FVehicleModel: IVehicleModel;

      FCompanyId: string;
      FDescription: string;
      FModel: string;
      FBrand: string;
      FCategory: string;
      FBoard: string;
      FStatus: Integer;
      FUserId: string;

      function getVehicleId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iVehicleDuplicateController;

      function vehicleModel(AValue: IVehicleModel): iVehicleDuplicateController;

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

{ TVehicleDuplicateController }

function TVehicleDuplicateController.board(AValue: string)
  : iVehicleDuplicateController;
begin
   Result := Self;
   FBoard := AValue;
end;

function TVehicleDuplicateController.brand(AValue: string)
  : iVehicleDuplicateController;
begin
   Result := Self;
   FBrand := AValue;
end;

function TVehicleDuplicateController.category(AValue: string)
  : iVehicleDuplicateController;
begin
   Result := Self;
   FCategory := AValue;
end;

function TVehicleDuplicateController.companyId(AValue: string)
  : iVehicleDuplicateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TVehicleDuplicateController.Create;
begin

end;

function TVehicleDuplicateController.description(AValue: string)
  : iVehicleDuplicateController;
begin
   Result := Self;
   FDescription := AValue;
end;

destructor TVehicleDuplicateController.Destroy;
begin

   inherited;
end;

class function TVehicleDuplicateController.New: iVehicleDuplicateController;
begin
   Result := Self.Create;
end;

function TVehicleDuplicateController.getVehicleId: Integer;
begin
   if FVehicleModel.DAO.Find.Count <> 0 then
   begin
      Result := FVehicleModel.DAO.FindWhere(Format('COMPANYID = %s',
        [QuotedStr(FCompanyId)]), 'VEHICLEID desc').Last.VEHICLEID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

function TVehicleDuplicateController.Model(AValue: string)
  : iVehicleDuplicateController;
begin
   Result := Self;
   FModel := AValue;
end;

procedure TVehicleDuplicateController.save;
begin
   FVehicleModel.Entity(TTASSVEHICLE.Create);

   FVehicleModel.Entity.companyId := FCompanyId;
   FVehicleModel.Entity.VEHICLEID := getVehicleId;
   FVehicleModel.Entity.description := FDescription;
   FVehicleModel.Entity.Model := FModel;
   FVehicleModel.Entity.brand := FBrand;
   FVehicleModel.Entity.category := FCategory;
   FVehicleModel.Entity.board := FBoard;
   FVehicleModel.Entity.status := FStatus;
   FVehicleModel.Entity.userId := FUserId;
   FVehicleModel.Entity.CREATEDAT := Now;
   FVehicleModel.Entity.UPDATEDAT := Now;

   FVehicleModel.DAO.Insert(FVehicleModel.Entity);
end;

function TVehicleDuplicateController.status(AValue: Integer)
  : iVehicleDuplicateController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TVehicleDuplicateController.userId(AValue: string)
  : iVehicleDuplicateController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TVehicleDuplicateController.vehicleModel(AValue: IVehicleModel)
  : iVehicleDuplicateController;
begin
   Result := Self;
   FVehicleModel := AValue;
end;

end.
