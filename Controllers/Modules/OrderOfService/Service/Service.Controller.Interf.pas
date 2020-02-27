unit Service.Controller.Interf;

interface

uses Service.Model.Interf, TORDSERVICE.Entity.Model;

type
  iServiceInsertController = interface;
  iServiceUpdateController = interface;
  iServiceDeleteController = interface;
  iServiceDuplicateController = interface;

  iServiceController = interface
    function find(AValue: string): iServiceController;

    function insert: iServiceInsertController;
    function update: iServiceUpdateController;
    function delete: iServiceDeleteController;
    function duplicate: iServiceDuplicateController;

    function code: string;
    function serviceId: string;
    function description: string;
    function measuredUnit: string;
    function price: Currency;
    function status: Integer;
    function createdAt: string;
    function updatedAt: string;
  end;

  iServiceInsertController = interface
    function serviceModel(AValue: IServiceModel): iServiceInsertController;

    function companyId(AValue: string): iServiceInsertController;
    function description(AValue: string): iServiceInsertController;
    function measuredUnit(AValue: string): iServiceInsertController;
    function price(AValue: Currency): iServiceInsertController;
    function status(AValue: Integer): iServiceInsertController;
    function userId(AValue: string): iServiceInsertController;

    procedure save;
  end;

  iServiceUpdateController = interface
    function serviceModel(AValue: IServiceModel): iServiceUpdateController;
    function selectedRecord(AValue: TTORDSERVICE): iServiceUpdateController;

    function companyId(AValue: string): iServiceUpdateController;
    function description(AValue: string): iServiceUpdateController;
    function measuredUnit(AValue: string): iServiceUpdateController;
    function price(AValue: Currency): iServiceUpdateController;
    function status(AValue: Integer): iServiceUpdateController;
    function userId(AValue: string): iServiceUpdateController;

    procedure save;
  end;

  iServiceDeleteController = interface
    function serviceModel(AValue: IServiceModel): iServiceDeleteController;
    function selectedRecord(AValue: TTORDSERVICE): iServiceDeleteController;

    procedure save;
  end;

  iServiceDuplicateController = interface
    function serviceModel(AValue: IServiceModel): iServiceDuplicateController;

    function companyId(AValue: string): iServiceDuplicateController;
    function description(AValue: string): iServiceDuplicateController;
    function measuredUnit(AValue: string): iServiceDuplicateController;
    function price(AValue: Currency): iServiceDuplicateController;
    function status(AValue: Integer): iServiceDuplicateController;
    function userId(AValue: string): iServiceDuplicateController;

    procedure save;
  end;

implementation

end.
