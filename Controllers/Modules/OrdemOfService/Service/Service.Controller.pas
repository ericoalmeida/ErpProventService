unit Service.Controller;

interface

uses Service.Controller.Interf, Service.Model.Interf,
  TORDSERVICE.Entity.Model,
  System.SysUtils;

type
  TServiceController = class(TInterfacedObject, iServiceController)
  private
    FServiceModel: IServiceModel;
    FRecordFound: TTORDSERVICE;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iServiceController;

    function find(AValue: string): iServiceController;

    function insert: iServiceInsertController;
    function update: iServiceUpdateController;
    function delete: iServiceDeleteController;
    function duplicate: iServiceDuplicateController;

    function code: string;
    function serviceId: string;
    function description: string;
    function measuredUnit: string;
    function price: string;
    function status: Integer;
    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TServiceController }

uses Facade.Model, ServiceInsert.Controller, ServiceUpdate.Controller,
  ServiceDelete.Controller, ServiceDuplicate.Controller;

function TServiceController.code: string;
begin
  Result := FRecordFound.code;
end;

function TServiceController.serviceId: string;
begin
  Result := FRecordFound.serviceId.ToString;
end;

function TServiceController.status: Integer;
begin
  Result := FRecordFound.STATUS;
end;

constructor TServiceController.Create;
begin
  FServiceModel := TFacadeModel.New.moduleFacade.ordemOfService.serviceModel;
end;

function TServiceController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TServiceController.delete: iServiceDeleteController;
begin
  Result := TServiceDeleteController.New.serviceModel(FServiceModel)
    .selectedRecord(FRecordFound);
end;

function TServiceController.description: string;
begin
  Result := FRecordFound.description;
end;

destructor TServiceController.Destroy;
begin

  inherited;
end;

function TServiceController.duplicate: iServiceDuplicateController;
begin
  Result := TServiceDuplicateController.New.serviceModel(FServiceModel);
end;

function TServiceController.insert: iServiceInsertController;
begin
  Result := TServiceInsertController.New.serviceModel(FServiceModel);
end;

function TServiceController.measuredUnit: string;
begin
  Result := FRecordFound.measuredUnit;
end;

class function TServiceController.New: iServiceController;
begin
  Result := Self.Create;
end;

function TServiceController.price: string;
begin
  Result := FRecordFound.price.ToString;
end;

function TServiceController.find(AValue: string): iServiceController;
begin
  Result := Self;

  FRecordFound := FServiceModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TServiceController.update: iServiceUpdateController;
begin
  Result := TServiceUpdateController.New.serviceModel(FServiceModel)
    .selectedRecord(FRecordFound);
end;

function TServiceController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.updatedAt);
end;

end.
