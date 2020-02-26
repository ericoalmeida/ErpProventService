unit VehicleInsert.Controller;

interface

uses Vehicle.Controller.Interf, Vehicle.Model.Interf,
  TASSVEHICLE.Entity.Model,
  System.SysUtils;

type
  TVehicleInsertController = class(TInterfacedObject, iVehicleInsertController)
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

    class function New: iVehicleInsertController;

    function vehicleModel(AValue: IVehicleModel): iVehicleInsertController;

    function companyId(AValue: string): iVehicleInsertController;
    function description(AValue: string): iVehicleInsertController;
    function model(AValue: string): iVehicleInsertController;
    function brand(AValue: string): iVehicleInsertController;
    function category(AValue: string): iVehicleInsertController;
    function board(AValue: string): iVehicleInsertController;
    function status(AValue: Integer): iVehicleInsertController;
    function userId(AValue: string): iVehicleInsertController;

    procedure save;
  end;

implementation

{ TVehicleInsertController }

function TVehicleInsertController.board(AValue: string)
  : iVehicleInsertController;
begin
  Result := Self;
  FBoard := AValue;
end;

function TVehicleInsertController.brand(AValue: string): iVehicleInsertController;
begin
 Result := Self;
 FBrand := AValue;
end;

function TVehicleInsertController.category(AValue: string): iVehicleInsertController;
begin
 Result := Self;
 FCategory := AValue;
end;

function TVehicleInsertController.companyId(AValue: string): iVehicleInsertController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TVehicleInsertController.Create;
begin

end;

function TVehicleInsertController.description(AValue: string)
  : iVehicleInsertController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TVehicleInsertController.Destroy;
begin

  inherited;
end;

class function TVehicleInsertController.New: iVehicleInsertController;
begin
  Result := Self.Create;
end;

function TVehicleInsertController.getVehicleId: Integer;
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

function TVehicleInsertController.model(AValue: string): iVehicleInsertController;
begin
 Result := Self;
 FModel := AValue;
end;

procedure TVehicleInsertController.save;
begin
  FVehicleModel.Entity(TTASSVEHICLE.Create);

  FVehicleModel.Entity.COMPANYID       := FCompanyId;
  FVehicleModel.Entity.VEHICLEID       := getVehicleId;
  FVehicleModel.Entity.DESCRIPTION     := FDescription;
  FVehicleModel.Entity.MODEL           := FModel;
  FVehicleModel.Entity.BRAND           := FBrand;
  FVehicleModel.Entity.CATEGORY        := FCategory;
  FVehicleModel.Entity.BOARD           := FBoard;
  FVehicleModel.Entity.STATUS          := FStatus;
  FVehicleModel.Entity.USERID          := FUserId;
  FVehicleModel.Entity.CREATEDAT       := Now;
  FVehicleModel.Entity.UPDATEDAT       := Now;

  FVehicleModel.DAO.Insert(FVehicleModel.Entity);
end;

function TVehicleInsertController.status(AValue: Integer): iVehicleInsertController;
begin
 Result := Self;
 FStatus := AValue;
end;

function TVehicleInsertController.userId(AValue: string): iVehicleInsertController;
begin
  Result := Self;
  FUserId := AValue;
end;

function TVehicleInsertController.vehicleModel(AValue: IVehicleModel)
  : iVehicleInsertController;
begin
  Result := Self;
  FVehicleModel := AValue;
end;

end.
