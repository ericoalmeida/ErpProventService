unit ServiceProvidedUpdate.Controller;

interface

uses ServiceProvided.Controller.Interf, ServiceProvided.Model.Interf,
   System.SysUtils, TORDSERVICESPROVIDED.Entity.Model;

type
   TServiceProvidedUpdateController = class(TInterfacedObject,
     iServiceProvidedUpdateController)
   private
      FServiceProvidedModel: IServiceProvidedModel;
      FSelectedRecord: TTORDSERVICESPROVIDED;

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
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iServiceProvidedUpdateController;

      function serviceProvidedModel(AValue: IServiceProvidedModel)
        : iServiceProvidedUpdateController;
      function selectedRecord(AValue: TTORDSERVICESPROVIDED)
        : iServiceProvidedUpdateController;

      function companyId(AValue: string): iServiceProvidedUpdateController;
      function providedAt(AValue: TDate): iServiceProvidedUpdateController;
      function clientId(AValue: string): iServiceProvidedUpdateController;
      function operatorId(AValue: string): iServiceProvidedUpdateController;
      function machineId(AValue: string): iServiceProvidedUpdateController;
      function serviceId(AValue: string): iServiceProvidedUpdateController;
      function totalHours(AValue: Integer): iServiceProvidedUpdateController;
      function totalKm(AValue: Double): iServiceProvidedUpdateController;
      function total(AValue: Currency): iServiceProvidedUpdateController;
      function userId(AValue: string): iServiceProvidedUpdateController;

      procedure save;
   end;

implementation

{ TServiceProvidedUpdateController }

function TServiceProvidedUpdateController.serviceId(AValue: string)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FServiceId := AValue;
end;

function TServiceProvidedUpdateController.serviceProvidedModel
  (AValue: IServiceProvidedModel): iServiceProvidedUpdateController;
begin
   Result := Self;
   FServiceProvidedModel := AValue;
end;

function TServiceProvidedUpdateController.clientId(AValue: string)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FClientId := AValue;
end;

function TServiceProvidedUpdateController.companyId(AValue: string)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

function TServiceProvidedUpdateController.total(AValue: Currency)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FTotal := AValue;
end;

function TServiceProvidedUpdateController.totalHours(AValue: Integer)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FTotalHours := AValue;
end;

function TServiceProvidedUpdateController.totalKm(AValue: Double)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FTotalKm := AValue;
end;

function TServiceProvidedUpdateController.userId(AValue: string)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FUserId := AValue;
end;

constructor TServiceProvidedUpdateController.Create;
begin

end;

destructor TServiceProvidedUpdateController.Destroy;
begin

   inherited;
end;

function TServiceProvidedUpdateController.machineId(AValue: string)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FMachineId := AValue;
end;

class function TServiceProvidedUpdateController.New
  : iServiceProvidedUpdateController;
begin
   Result := Self.Create;
end;

function TServiceProvidedUpdateController.operatorId(AValue: string)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FOperatorId := AValue;
end;

function TServiceProvidedUpdateController.providedAt(AValue: TDate)
  : iServiceProvidedUpdateController;
begin
   Result := Self;
   FProvidedAt := AValue;
end;

procedure TServiceProvidedUpdateController.save;
begin
   FServiceProvidedModel.DAO.Modify(FSelectedRecord);

   FSelectedRecord.companyId := FCompanyId;
   FSelectedRecord.providedAt := FProvidedAt;
   FSelectedRecord.providedAt := FProvidedAt;
   FSelectedRecord.clientId := FClientId;
   FSelectedRecord.operatorId := FOperatorId;
   FSelectedRecord.machineId := FMachineId;
   FSelectedRecord.serviceId := FServiceId;
   FSelectedRecord.totalHours := FTotalHours;
   FSelectedRecord.totalKm := FTotalKm;
   FSelectedRecord.total := FTotal;
   FSelectedRecord.userId := FUserId;
   FSelectedRecord.UPDATEDAT := Now;

   FServiceProvidedModel.DAO.Update(FSelectedRecord);
end;

function TServiceProvidedUpdateController.selectedRecord
  (AValue: TTORDSERVICESPROVIDED): iServiceProvidedUpdateController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

end.
