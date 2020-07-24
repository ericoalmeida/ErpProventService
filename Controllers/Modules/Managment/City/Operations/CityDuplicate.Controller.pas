unit CityDuplicate.Controller;

interface

uses City.Controller.Interf, City.Model.Interf,
   TMNGCITY.Entity.Model, System.SysUtils;

type
   TCityDuplicateController = class(TInterfacedObject, iCityDuplicateController)
   private
      FCityModel: iCityModel;

      FName: string;
      FZipCode: string;
      FIBGECode: Integer;
      FStateId: string;

      function getCityId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iCityDuplicateController;

      function cityModel(AValue: iCityModel): iCityDuplicateController;

      function name(AValue: string): iCityDuplicateController;
      function zipCode(AValue: string): iCityDuplicateController;
      function ibgeCode(AValue: string): iCityDuplicateController;
      function stateId(AValue: string): iCityDuplicateController;

      procedure save;
   end;

implementation

{ TCityDuplicateController }

constructor TCityDuplicateController.Create;
begin

end;

destructor TCityDuplicateController.Destroy;
begin

   inherited;
end;

function TCityDuplicateController.getCityId: Integer;
begin
   if FCityModel.DAO.Find.Count <> 0 then
   begin
      Result := FCityModel.DAO.FindWhere('', 'CITYID desc').Last.CITYID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

function TCityDuplicateController.ibgeCode(AValue: string)
  : iCityDuplicateController;
begin
   Result := Self;
   FIBGECode := StrToInt(AValue);
end;

function TCityDuplicateController.name(AValue: string)
  : iCityDuplicateController;
begin
   Result := Self;
   FName := AValue;
end;

function TCityDuplicateController.cityModel(AValue: iCityModel)
  : iCityDuplicateController;
begin
   Result := Self;
   FCityModel := AValue;
end;

class function TCityDuplicateController.New: iCityDuplicateController;
begin
   Result := Self.Create;
end;

procedure TCityDuplicateController.save;
begin
   FCityModel.Entity(TTMNGCITY.Create);

   FCityModel.Entity.CITYID := getCityId;
   FCityModel.Entity.name := FName;
   FCityModel.Entity.zipCode := FZipCode;
   FCityModel.Entity.ibgeCode := FIBGECode;
   FCityModel.Entity.stateId := FStateId;
   FCityModel.Entity.CREATEDAT := Now;
   FCityModel.Entity.UPDATEDAT := Now;

   FCityModel.DAO.Insert(FCityModel.Entity);
end;

function TCityDuplicateController.stateId(AValue: string)
  : iCityDuplicateController;
begin
   Result := Self;
   FStateId := AValue;
end;

function TCityDuplicateController.zipCode(AValue: string)
  : iCityDuplicateController;
begin
   Result := Self;
   FZipCode := AValue;
end;

end.
