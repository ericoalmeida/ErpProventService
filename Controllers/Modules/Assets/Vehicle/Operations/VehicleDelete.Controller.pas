unit VehicleDelete.Controller;

interface

uses Vehicle.Controller.Interf, TASSVEHICLE.Entity.Model,
  Vehicle.Model.Interf, Base.View.Interf;

type
  TVehicleDeleteController = class(TInterfacedObject, iVehicleDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FVehicleModel: IVehicleModel;
    FSelectedRecord: TTASSVEHICLE;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iVehicleDeleteController;

    function vehicleModel(AValue: IVehicleModel): iVehicleDeleteController;
    function selectedRecord(AValue: TTASSVEHICLE): iVehicleDeleteController;

    procedure save;
  end;

implementation

{ TVehicleDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TVehicleDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TVehicleDeleteController.Destroy;
begin

  inherited;
end;

function TVehicleDeleteController.vehicleModel(AValue: IVehicleModel)
  : iVehicleDeleteController;
begin
  Result := Self;
  FVehicleModel := AValue;
end;

class function TVehicleDeleteController.New: iVehicleDeleteController;
begin
  Result := Self.Create;
end;

procedure TVehicleDeleteController.save;
begin
  if FMessageConfirm.messages(Format('Deseja excluir o veículo %s ?',
    [FSelectedRecord.DESCRIPTION])).&end then
  begin

    try
      FVehicleModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('O veículo %s não pode ser excluído!',
          [FSelectedRecord.DESCRIPTION]));
    end;

  end;
end;

function TVehicleDeleteController.selectedRecord(AValue: TTASSVEHICLE)
  : iVehicleDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.
