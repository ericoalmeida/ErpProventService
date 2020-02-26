unit Vehicle.Controller;

interface

uses Vehicle.Controller.Interf, Vehicle.Model.Interf,
  TASSVEHICLE.Entity.Model,
  System.SysUtils;

type
  TVehicleController = class(TInterfacedObject, iVehicleController)
  private
    FVehicleModel: IVehicleModel;
    FRecordFound: TTASSVEHICLE;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iVehicleController;

    function find(AValue: string): iVehicleController;

    function insert: iVehicleInsertController;
    function update: iVehicleUpdateController;
    function delete: iVehicleDeleteController;
    function duplicate: iVehicleDuplicateController;

    function code: string;
    function vehicleId: string;

    function description: string;
    function model: string;
    function brand: string;
    function category: string;
    function board: string;
    function status: Integer;
    function userId: string;

    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TVehicleController }

uses Facade.Model, VehicleInsert.Controller, VehicleUpdate.Controller,
  VehicleDelete.Controller, VehicleDuplicate.Controller;

function TVehicleController.board: string;
begin
  Result := FRecordFound.BOARD;
end;

function TVehicleController.brand: string;
begin
  Result := FRecordFound.BRAND;
end;

function TVehicleController.category: string;
begin
  Result := FRecordFound.CATEGORY;
end;

function TVehicleController.code: string;
begin
  Result := FRecordFound.code;
end;

function TVehicleController.vehicleId: string;
begin
  Result := FRecordFound.vehicleId.ToString;
end;

constructor TVehicleController.Create;
begin
  FVehicleModel := TFacadeModel.New.moduleFacade.assetsFactoryModel.
    vehicleModel;
end;

function TVehicleController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TVehicleController.delete: iVehicleDeleteController;
begin
  Result := TVehicleDeleteController.New.vehicleModel(FVehicleModel)
    .selectedRecord(FRecordFound);
end;

function TVehicleController.description: string;
begin
  Result := FRecordFound.DESCRIPTION;
end;

destructor TVehicleController.Destroy;
begin

  inherited;
end;

function TVehicleController.duplicate: iVehicleDuplicateController;
begin
  Result := TVehicleDuplicateController.New.vehicleModel(FVehicleModel);
end;

function TVehicleController.insert: iVehicleInsertController;
begin
  Result := TVehicleInsertController.New.vehicleModel(FVehicleModel);
end;

function TVehicleController.model: string;
begin
  Result := FRecordFound.MODEL;
end;

class function TVehicleController.New: iVehicleController;
begin
  Result := Self.Create;
end;

function TVehicleController.status: Integer;
begin
  Result := FRecordFound.STATUS;
end;

function TVehicleController.find(AValue: string): iVehicleController;
begin
  Result := Self;

  FRecordFound := FVehicleModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TVehicleController.update: iVehicleUpdateController;
begin
  Result := TVehicleUpdateController.New.vehicleModel(FVehicleModel)
    .selectedRecord(FRecordFound);
end;

function TVehicleController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.updatedAt);
end;

function TVehicleController.userId: string;
begin
  Result := FRecordFound.TMNGUSER.USERID.ToString;
end;

end.
