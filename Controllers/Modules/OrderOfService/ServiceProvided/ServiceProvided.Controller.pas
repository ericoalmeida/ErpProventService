unit ServiceProvided.Controller;

interface

uses ServiceProvided.Controller.Interf, ServiceProvided.Model.Interf,
  System.SysUtils, TORDSERVICESPROVIDED.Entity.Model, System.Generics.Collections;

type
  TServiceProvidedController = class(TInterfacedObject,
    iServiceProvidedController)
  private
    FServiceProvidedModel: IServiceProvidedModel;
    FRecordFound: TTORDSERVICESPROVIDED;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iServiceProvidedController;

    function find(AValue: string): iServiceProvidedController;

    function insert: iServiceProvidedInsertController;
    function update: iServiceProvidedUpdateController;
    function delete: iServiceProvidedDeleteController;
    function duplicate: iServiceProvidedDuplicateController;

    function code: string;
    function serviceProvidedId: string;

    function providedAt: TDate;
    function clientId: string;
    function operatorId: string;
    function machineId: string;
    function serviceId: string;
    function totalHours: Integer;
    function totalKm: Double;
    function total: Currency;
    function status: Integer;

    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TServiceProvidedController }

uses Facade.Model, ServiceProvidedInsert.Controller,
  ServiceProvidedUpdate.Controller,
  ServiceProvidedDelete.Controller, ServiceProvidedDuplicate.Controller;

function TServiceProvidedController.clientId: string;
begin
  Result := FRecordFound.TMNGPERSON.PERSONID.ToString;
end;

function TServiceProvidedController.code: string;
begin
  Result := FRecordFound.code;
end;

function TServiceProvidedController.serviceId: string;
begin
  Result := FRecordFound.TORDSERVICE.SERVICEID.ToString;
end;

function TServiceProvidedController.serviceProvidedId: string;
begin
  Result := FRecordFound.serviceProvidedId.ToString;
end;

function TServiceProvidedController.status: Integer;
begin
  Result := FRecordFound.STATUS;
end;

function TServiceProvidedController.total: Currency;
begin
  Result := FRecordFound.TOTAL;
end;

function TServiceProvidedController.totalHours: Integer;
begin
  Result := FRecordFound.TOTALHOURS.Value;
end;

function TServiceProvidedController.totalKm: Double;
begin
  Result := FRecordFound.TOTALKM;
end;

constructor TServiceProvidedController.Create;
begin
  FServiceProvidedModel := TFacadeModel.New.moduleFacade.orderOfServiceFactoryModel.
    serviceProvidedModel;
end;

function TServiceProvidedController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TServiceProvidedController.delete: iServiceProvidedDeleteController;
begin
  Result := TServiceProvidedDeleteController.New.serviceProvidedModel
    (FServiceProvidedModel).selectedRecord(FRecordFound);
end;

destructor TServiceProvidedController.Destroy;
begin

  inherited;
end;

function TServiceProvidedController.duplicate
  : iServiceProvidedDuplicateController;
begin
  Result := TServiceProvidedDuplicateController.New.serviceProvidedModel
    (FServiceProvidedModel);
end;

function TServiceProvidedController.insert: iServiceProvidedInsertController;
begin
  Result := TServiceProvidedInsertController.New.serviceProvidedModel
    (FServiceProvidedModel);
end;

function TServiceProvidedController.machineId: string;
begin
  Result := EmptyStr;

  if FRecordFound.MACHINEID.HasValue then
  Result := FRecordFound.TASSVEHICLE.VEHICLEID.ToString;
end;

class function TServiceProvidedController.New: iServiceProvidedController;
begin
  Result := Self.Create;
end;

function TServiceProvidedController.operatorId: string;
begin
  Result := EmptyStr;

  if FRecordFound.OPERATORID.HasValue then
  Result := FRecordFound.TORDOPERATOR.OPERATORID.ToString;
end;

function TServiceProvidedController.providedAt: TDate;
begin
  Result := FRecordFound.PROVIDEDAT;
end;

function TServiceProvidedController.find(AValue: string)
  : iServiceProvidedController;
begin
  Result := Self;

  FRecordFound := FServiceProvidedModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TServiceProvidedController.update: iServiceProvidedUpdateController;
begin
  Result := TServiceProvidedUpdateController.New.serviceProvidedModel
    (FServiceProvidedModel).selectedRecord(FRecordFound);
end;

function TServiceProvidedController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.updatedAt);
end;

end.
