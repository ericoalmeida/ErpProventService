unit CityInsert.Controller;

interface

uses City.Controller.Interf, City.Model.Interf, TMNGCITY.Entity.Model,
  Utils.Controller.Interf, System.SysUtils;

type
  TCityInsertController = class(TInterfacedObject, iCityInsertController)
  private
    FCityModel: ICityModel;
    FUtils: iUtilsController;

    FName: string;
    FZipCode: string;
    FIBGECode: Integer;
    FStateId: string;

    function getCityId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCityInsertController;

    function cityModel(AValue: ICityModel): iCityInsertController;

    function name(AValue: string): iCityInsertController;
    function zipCode(AValue: string): iCityInsertController;
    function ibgeCode(AValue: string): iCityInsertController;
    function stateId(AValue: string): iCityInsertController;

    procedure save;
  end;

implementation

{ TCityInsertController }

uses Facade.Controller, Constants.Controller;

constructor TCityInsertController.Create;
begin
  FUtils := TFacadeController.New.Utils;
end;

destructor TCityInsertController.Destroy;
begin

  inherited;
end;

function TCityInsertController.getCityId: Integer;
begin
  if FCityModel.DAO.Find.Count <> 0 then  begin
    Result := FCityModel.DAO.FindWhere('', 'CITYID desc').Last.CITYID + 1;
  end else begin
    Result := 1;
  end;
end;

function TCityInsertController.ibgeCode(AValue: string): iCityInsertController;
begin
  Result := Self;
  FIBGECode := StrToInt(AValue);
end;

function TCityInsertController.name(AValue: string): iCityInsertController;
begin
  Result := Self;
  FName := AValue;
end;

class function TCityInsertController.New: iCityInsertController;
begin
  Result := Self.Create;
end;

procedure TCityInsertController.save;
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

function TCityInsertController.stateId(AValue: string): iCityInsertController;
begin
  Result := Self;
  FStateId := AValue;
end;

function TCityInsertController.zipCode(AValue: string): iCityInsertController;
begin
  Result := Self;
  FZipCode := AValue;
end;

function TCityInsertController.cityModel(AValue: ICityModel)
  : iCityInsertController;
begin
  Result := Self;
  FCityModel := AValue;
end;

end.
