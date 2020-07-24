unit ServiceProvidedDuplicate.Controller;

interface

uses ServiceProvided.Controller.Interf, ServiceProvided.Model.Interf,
   System.SysUtils, TORDSERVICESPROVIDED.Entity.Model;

type
   TServiceProvidedDuplicateController = class(TInterfacedObject,
     iServiceProvidedDuplicateController)
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

      class function New: iServiceProvidedDuplicateController;

      function serviceProvidedModel(AValue: IServiceProvidedModel)
        : iServiceProvidedDuplicateController;

      function companyId(AValue: string): iServiceProvidedDuplicateController;
      function providedAt(AValue: TDate): iServiceProvidedDuplicateController;
      function clientId(AValue: string): iServiceProvidedDuplicateController;
      function operatorId(AValue: string): iServiceProvidedDuplicateController;
      function machineId(AValue: string): iServiceProvidedDuplicateController;
      function serviceId(AValue: string): iServiceProvidedDuplicateController;
      function totalHours(AValue: Integer): iServiceProvidedDuplicateController;
      function totalKm(AValue: Double): iServiceProvidedDuplicateController;
      function total(AValue: Currency): iServiceProvidedDuplicateController;
      function userId(AValue: string): iServiceProvidedDuplicateController;

      procedure save;
   end;

implementation

{ TServiceProvidedDuplicateController }

function TServiceProvidedDuplicateController.clientId(AValue: string)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FClientId := AValue;
end;

function TServiceProvidedDuplicateController.companyId(AValue: string)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TServiceProvidedDuplicateController.Create;
begin

end;

destructor TServiceProvidedDuplicateController.Destroy;
begin

   inherited;
end;

class function TServiceProvidedDuplicateController.New
  : iServiceProvidedDuplicateController;
begin
   Result := Self.Create;
end;

function TServiceProvidedDuplicateController.operatorId(AValue: string)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FOperatorId := AValue;
end;

function TServiceProvidedDuplicateController.providedAt(AValue: TDate)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FProvidedAt := AValue;
end;

function TServiceProvidedDuplicateController.getserviceProvidedId: Integer;
begin
   if FServiceProvidedModel.DAO.Find.Count <> 0 then
   begin
      Result := FServiceProvidedModel.DAO.FindWhere('',
        'SERVICEPROVIDEDID desc').Last.SERVICEPROVIDEDID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

function TServiceProvidedDuplicateController.machineId(AValue: string)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FMachineId := AValue;
end;

procedure TServiceProvidedDuplicateController.save;
begin
   FServiceProvidedModel.Entity(TTORDSERVICESPROVIDED.Create);

   FServiceProvidedModel.Entity.companyId := FCompanyId;
   FServiceProvidedModel.Entity.SERVICEPROVIDEDID := getserviceProvidedId;
   FServiceProvidedModel.Entity.providedAt := FProvidedAt;
   FServiceProvidedModel.Entity.clientId := FClientId;
   FServiceProvidedModel.Entity.operatorId := FOperatorId;
   FServiceProvidedModel.Entity.machineId := FMachineId;
   FServiceProvidedModel.Entity.serviceId := FServiceId;
   FServiceProvidedModel.Entity.totalHours := FTotalHours;
   FServiceProvidedModel.Entity.totalKm := FTotalKm;
   FServiceProvidedModel.Entity.total := FTotal;
   FServiceProvidedModel.Entity.userId := FUserId;
   FServiceProvidedModel.Entity.CREATEDAT := Now;
   FServiceProvidedModel.Entity.UPDATEDAT := Now;

   FServiceProvidedModel.DAO.Insert(FServiceProvidedModel.Entity);
end;

function TServiceProvidedDuplicateController.serviceId(AValue: string)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FServiceId := AValue;
end;

function TServiceProvidedDuplicateController.serviceProvidedModel
  (AValue: IServiceProvidedModel): iServiceProvidedDuplicateController;
begin
   Result := Self;
   FServiceProvidedModel := AValue;
end;

function TServiceProvidedDuplicateController.total(AValue: Currency)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FTotal := AValue;
end;

function TServiceProvidedDuplicateController.totalHours(AValue: Integer)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FTotalHours := AValue;
end;

function TServiceProvidedDuplicateController.totalKm(AValue: Double)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FTotalKm := AValue;
end;

function TServiceProvidedDuplicateController.userId(AValue: string)
  : iServiceProvidedDuplicateController;
begin
   Result := Self;
   FUserId := AValue;
end;

end.
