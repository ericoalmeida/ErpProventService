unit City.Controller;

interface

uses City.Controller.Interf, City.Model.Interf, TMNGCITY.Entity.Model,
   System.SysUtils;

type
   TCityController = class(TInterfacedObject, iCityController)
   private
      FCityModel: ICityModel;
      FRecordFound: TTMNGCITY;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iCityController;

      function find(AValue: string): iCityController;
      function findById(AValue: string): iCityController;

      function insert: iCityInsertController;
      function update: iCityUpdateController;
      function delete: iCityDeleteController;
      function duplicate: iCityDuplicateController;

      function code: string;
      function cityId: string;
      function name: string;
      function zipCode: string;
      function ibgeCode: string;
      function stateId: string;
      function stateName: string;

      function createdAt: string;
      function updatedAt: string;
   end;

implementation

{ TCityController }

uses Facade.Model, CityInsert.Controller, CityUpdate.Controller,
   CityDelete.Controller, CityDuplicate.Controller;

function TCityController.stateName: string;
begin
   Result := FRecordFound.TMNGSTATE.name;
end;

function TCityController.stateId: string;
begin
   Result := FRecordFound.TMNGSTATE.stateId.ToString;
end;

function TCityController.code: string;
begin
   Result := FRecordFound.code;
end;

constructor TCityController.Create;
begin
   FCityModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.cityModel;
end;

function TCityController.createdAt: string;
begin
   Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TCityController.delete: iCityDeleteController;
begin
   Result := TCityDeleteController.New.cityModel(FCityModel)
     .selectedRecord(FRecordFound);
end;

function TCityController.name: string;
begin
   Result := FRecordFound.name;
end;

destructor TCityController.Destroy;
begin

   inherited;
end;

function TCityController.duplicate: iCityDuplicateController;
begin
   Result := TCityDuplicateController.New.cityModel(FCityModel);
end;

function TCityController.ibgeCode: string;
begin
   Result := inttostr(FRecordFound.ibgeCode);
end;

function TCityController.insert: iCityInsertController;
begin
   Result := TCityInsertController.New.cityModel(FCityModel);
end;

class function TCityController.New: iCityController;
begin
   Result := Self.Create;
end;

function TCityController.cityId: string;
begin
   Result := FRecordFound.cityId.ToString;
end;

function TCityController.find(AValue: string): iCityController;
begin
   Result := Self;

   FRecordFound := FCityModel.DAO.FindWhere
     (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TCityController.findById(AValue: string): iCityController;
begin
   Result := Self;

   FRecordFound := FCityModel.DAO.FindWhere
     (Format('CITYID = %d', [StrToInt(AValue)])).Items[0];
end;

function TCityController.update: iCityUpdateController;
begin
   Result := TCityUpdateController.New.cityModel(FCityModel)
     .selectedRecord(FRecordFound);
end;

function TCityController.updatedAt: string;
begin
   Result := DateTimeToStr(FRecordFound.updatedAt);
end;

function TCityController.zipCode: string;
begin
   Result := FRecordFound.zipCode;
end;

end.
