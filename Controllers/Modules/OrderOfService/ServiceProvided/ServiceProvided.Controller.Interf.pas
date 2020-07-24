unit ServiceProvided.Controller.Interf;

interface

uses ServiceProvided.Model.Interf, TORDSERVICESPROVIDED.Entity.Model;

type
   iServiceProvidedInsertController = interface;
   iServiceProvidedUpdateController = interface;
   iServiceProvidedDeleteController = interface;
   iServiceProvidedDuplicateController = interface;

   iServiceProvidedController = interface
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

   iServiceProvidedInsertController = interface
      function serviceProvidedModel(AValue: iServiceProvidedModel)
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

   iServiceProvidedUpdateController = interface
      function serviceProvidedModel(AValue: iServiceProvidedModel)
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

   iServiceProvidedDeleteController = interface
      function serviceProvidedModel(AValue: iServiceProvidedModel)
        : iServiceProvidedDeleteController;
      function selectedRecord(AValue: TTORDSERVICESPROVIDED)
        : iServiceProvidedDeleteController;

      procedure save;
   end;

   iServiceProvidedDuplicateController = interface
      function serviceProvidedModel(AValue: iServiceProvidedModel)
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

end.
