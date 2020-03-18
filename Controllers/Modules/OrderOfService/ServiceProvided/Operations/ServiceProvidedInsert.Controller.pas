unit ServiceProvidedInsert.Controller;

interface

uses ServiceProvided.Controller.Interf, ServiceProvided.Model.Interf,
  System.SysUtils, TORDSERVICESPROVIDED.Entity.Model;

type
  TServiceProvidedInsertController = class(TInterfacedObject,
    iServiceProvidedInsertController)
  private
    FServiceProvidedModel: IServiceProvidedModel;

    FCompanyId: string;
    FProvidedAt: TDate;
    FClientId: string;
    FOperatorId: string;
    FMachineId: string;
    FServiceId: string;
    FTotalHours: Integer;
    FTotalKm: Double;
    FTotal: Currency;
    FUserId: string;

    function getserviceProvidedId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iServiceProvidedInsertController;

    function serviceProvidedModel(AValue: IServiceProvidedModel)
      : iServiceProvidedInsertController;

    function companyId(AValue: string): iServiceProvidedInsertController;
    function providedAt(AValue: TDate): iServiceProvidedInsertController;
    function clientId(AValue: string): iServiceProvidedInsertController;
    function operatorId(AValue: string): iServiceProvidedInsertController;
    function machineId(AValue: string): iServiceProvidedInsertController;
    function serviceId(AValue: string): iServiceProvidedInsertController;
    function totalHours(AValue: Integer): iServiceProvidedInsertController;
    function totalKm(AValue: Double): iServiceProvidedInsertController;
    function total(AValue: Currency): iServiceProvidedInsertController;
    function userId(AValue: string): iServiceProvidedInsertController;

    procedure save;
  end;

implementation

{ TServiceProvidedInsertController }

function TServiceProvidedInsertController.clientId(
  AValue: string): iServiceProvidedInsertController;
begin
  Result := Self;
  FClientId := AValue;
end;

function TServiceProvidedInsertController.companyId(
  AValue: string): iServiceProvidedInsertController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TServiceProvidedInsertController.Create;
begin

end;

destructor TServiceProvidedInsertController.Destroy;
begin

  inherited;
end;

class function TServiceProvidedInsertController.New
  : iServiceProvidedInsertController;
begin
  Result := Self.Create;
end;

function TServiceProvidedInsertController.operatorId(
  AValue: string): iServiceProvidedInsertController;
begin
  Result := Self;
  FOperatorId := AValue;
end;

function TServiceProvidedInsertController.providedAt(
  AValue: TDate): iServiceProvidedInsertController;
begin
  Result := Self;
  FProvidedAt := AValue;
end;

function TServiceProvidedInsertController.getserviceProvidedId: Integer;
begin
  if FServiceProvidedModel.DAO.Find.Count <> 0 then
  begin
    Result := FServiceProvidedModel.DAO.FindWhere('', 'SERVICEPROVIDEDID desc')
      .Last.SERVICEPROVIDEDID + 1;
  end
  else
  begin
    Result := 1;
  end;
end;

function TServiceProvidedInsertController.machineId(
  AValue: string): iServiceProvidedInsertController;
begin
  Result := Self;
  FMachineId := AValue;
end;

procedure TServiceProvidedInsertController.save;
begin
  FServiceProvidedModel.Entity(TTORDSERVICESPROVIDED.Create);

  FServiceProvidedModel.Entity.companyId := FCompanyId;
  FServiceProvidedModel.Entity.SERVICEPROVIDEDID := getserviceProvidedId;
  FServiceProvidedModel.Entity.PROVIDEDAT := FProvidedAt;
  FServiceProvidedModel.Entity.CLIENTID := FClientId;
  FServiceProvidedModel.Entity.OPERATORID := FOperatorId;
  FServiceProvidedModel.Entity.MACHINEID := FMachineId;
  FServiceProvidedModel.Entity.SERVICEID := FServiceId;
  FServiceProvidedModel.Entity.TOTALHOURS := FTotalHours;
  FServiceProvidedModel.Entity.TOTALKM := FTotalKm;
  FServiceProvidedModel.Entity.TOTAL := FTotal;
  FServiceProvidedModel.Entity.USERID := FUserId;
  FServiceProvidedModel.Entity.CREATEDAT := Now;
  FServiceProvidedModel.Entity.UPDATEDAT := Now;

  FServiceProvidedModel.DAO.Insert(FServiceProvidedModel.Entity);
end;

function TServiceProvidedInsertController.serviceId(
  AValue: string): iServiceProvidedInsertController;
begin
  Result := Self;
  FServiceId := AValue;
end;

function TServiceProvidedInsertController.serviceProvidedModel
  (AValue: IServiceProvidedModel): iServiceProvidedInsertController;
begin
  Result := Self;
  FServiceProvidedModel := AValue;
end;

function TServiceProvidedInsertController.total(AValue: Currency): iServiceProvidedInsertController;
begin
  Result := Self;
  FTotal := AValue;
end;

function TServiceProvidedInsertController.totalHours(AValue: Integer): iServiceProvidedInsertController;
begin
  Result := Self;
  FTotalHours := AValue;
end;

function TServiceProvidedInsertController.totalKm(AValue: Double): iServiceProvidedInsertController;
begin
  Result := Self;
  FTotalKm := AValue;
end;

function TServiceProvidedInsertController.userId(AValue: string): iServiceProvidedInsertController;
begin
  Result := Self;
  FUserId := AValue;
end;

end.
