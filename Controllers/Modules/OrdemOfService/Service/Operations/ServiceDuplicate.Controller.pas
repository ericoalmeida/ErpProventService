unit ServiceDuplicate.Controller;

interface

uses Service.Controller.Interf, Service.Model.Interf,
  TORDSERVICE.Entity.Model,
  System.SysUtils;

type
  TServiceDuplicateController = class(TInterfacedObject, iServiceDuplicateController)
  private
    FServiceModel: IServiceModel;
    FCompanyId: string;
    FDescription: string;
    FMeasuredUnit: string;
    FPrice: Double;
    FStatus: Integer;
    FUserId: string;

    function getServiceId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iServiceDuplicateController;

    function serviceModel(AValue: IServiceModel): iServiceDuplicateController;

    function companyId(AValue: string): iServiceDuplicateController;
    function description(AValue: string): iServiceDuplicateController;
    function measuredUnit(AValue: string): iServiceDuplicateController;
    function price(AValue: string): iServiceDuplicateController;
    function status(AValue: Integer): iServiceDuplicateController;
    function userId(AValue: string): iServiceDuplicateController;

    procedure save;
  end;

implementation

{ TServiceDuplicateController }

function TServiceDuplicateController.companyId(AValue: string): iServiceDuplicateController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TServiceDuplicateController.Create;
begin

end;

function TServiceDuplicateController.description(AValue: string): iServiceDuplicateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TServiceDuplicateController.Destroy;
begin

  inherited;
end;

class function TServiceDuplicateController.New: iServiceDuplicateController;
begin
  Result := Self.Create;
end;

function TServiceDuplicateController.price(AValue: string): iServiceDuplicateController;
begin
  Result := Self;
  FPrice := AValue.ToDouble;
end;

function TServiceDuplicateController.getServiceId: Integer;
begin
  if FServiceModel.DAO.Find.Count <> 0 then
  begin
    Result := FServiceModel.DAO.FindWhere(Format('COMPANYID = %s',
      [QuotedStr(FCompanyId)]), 'SERVICEID desc').Last.SERVICEID + 1;
  end
  else
  begin
    Result := 1;
  end;
end;

function TServiceDuplicateController.measuredUnit(AValue: string): iServiceDuplicateController;
begin
  Result := Self;
  FMeasuredUnit := AValue;
end;

procedure TServiceDuplicateController.save;
begin
  FServiceModel.Entity(TTORDSERVICE.Create);

  FServiceModel.Entity.COMPANYID    := FCompanyId;
  FServiceModel.Entity.SERVICEID    := getServiceId;
  FServiceModel.Entity.DESCRIPTION  := FDescription;
  FServiceModel.Entity.MEASUREDUNIT := FMeasuredUnit;
  FServiceModel.Entity.PRICE        := FPrice;
  FServiceModel.Entity.STATUS       := FStatus;
  FServiceModel.Entity.CREATEDAT    := Now;
  FServiceModel.Entity.UPDATEDAT    := Now;

  FServiceModel.DAO.Insert(FServiceModel.Entity);
end;

function TServiceDuplicateController.serviceModel(AValue: IServiceModel)
  : iServiceDuplicateController;
begin
  Result := Self;
  FServiceModel := AValue;
end;

function TServiceDuplicateController.status(AValue: Integer): iServiceDuplicateController;
begin
  Result := Self;
  FStatus := AValue;
end;

function TServiceDuplicateController.userId(AValue: string): iServiceDuplicateController;
begin
  Result := Self;
  FUserId := AValue;
end;

end.
